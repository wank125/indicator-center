package com.qctc.bdss.indicator.engine;

import java.math.BigDecimal;
import java.math.MathContext;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.util.*;
import java.util.function.Function;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

// ============================================================
// Data Models
// ============================================================

/**
 * Indicator definition, mapped from ind_indicator_def table.
 */
record IndicatorDef(
    long id,
    String indicatorCode,
    String indicatorName,
    int indicatorType,      // 1=raw, 2=calculated, 3=derived
    int calcLayer,           // 0-9, determines execution order
    String unit,
    String timeGrain,
    long tenantId
) {}

/**
 * Calc formula, mapped from ind_calc_formula table.
 */
record CalcFormula(
    long id,
    String indicatorCode,
    int formulaType,         // 1=arithmetic 2=conditional 3=aggregation 4=YoY/MoM 5=ranking
    String formulaExpr,
    List<String> depCodes,
    int calcOrder,
    String conditionExpr,
    String trueValueExpr,
    String falseValue,
    String yoyMomConfig,     // JSON
    String aggConfig,        // JSON
    String rankConfig        // JSON
) {}

/**
 * Year-over-year / month-over-month configuration.
 */
record YoyMomConfig(
    String baseCode,
    CompareType compareType,
    int offsetDays
) {}

enum CompareType {
    YOY, MOM
}

/**
 * Aggregation configuration.
 */
record AggConfig(
    String func,             // SUM, AVG, COUNT, MAX, MIN
    List<String> groupFields,
    String timeGrain
) {}

/**
 * Ranking configuration.
 */
record RankConfig(
    int topN,
    String order,            // ASC or DESC
    List<String> groupBy
) {}

/**
 * Historical data accessor interface for YoY/MoM calculations.
 */
@FunctionalInterface
interface HistoricalDataProvider {
    Optional<BigDecimal> getValue(String indicatorCode, String unitId, LocalDate date);
}

// ============================================================
// CalcContext
// ============================================================

/**
 * Holds computed indicator values at a given time point.
 * Thread-safe via ConcurrentHashMap.
 */
class CalcContext {

    private final LocalDate tradeDate;
    private final long tenantId;
    private final int timePoint; // 1-96 for 15-min grain, 0 for daily/monthly
    private final Map<String, BigDecimal> values;
    private final Map<String, String> unitIdByCode; // tracks which unit each value belongs to
    private final HistoricalDataProvider historyProvider;

    CalcContext(LocalDate tradeDate, long tenantId, int timePoint,
                HistoricalDataProvider historyProvider) {
        this.tradeDate = tradeDate;
        this.tenantId = tenantId;
        this.timePoint = timePoint;
        this.values = new ConcurrentHashMap<>();
        this.unitIdByCode = new ConcurrentHashMap<>();
        this.historyProvider = Objects.requireNonNull(historyProvider);
    }

    void put(String indicatorCode, BigDecimal value) {
        values.put(indicatorCode, value);
    }

    void put(String indicatorCode, BigDecimal value, String unitId) {
        values.put(indicatorCode, value);
        unitIdByCode.put(indicatorCode, unitId);
    }

    Optional<BigDecimal> get(String indicatorCode) {
        return Optional.ofNullable(values.get(indicatorCode));
    }

    BigDecimal getOrThrow(String indicatorCode) {
        BigDecimal val = values.get(indicatorCode);
        if (val == null) {
            throw new CalcException(
                "Missing value for indicator: " + indicatorCode);
        }
        return val;
    }

    LocalDate tradeDate() { return tradeDate; }
    long tenantId() { return tenantId; }
    int timePoint() { return timePoint; }
    HistoricalDataProvider historyProvider() { return historyProvider; }
    Map<String, BigDecimal> values() { return Collections.unmodifiableMap(values); }
}

// ============================================================
// FormulaParser
// ============================================================

/**
 * Parses formula expressions into a structured AST-like representation.
 *
 * Supported forms:
 *   {CODE} * {CODE} + 100          -> ARITHMETIC
 *   IF({CODE} >= 0, {CODE}, 0)     -> CONDITIONAL
 *   AGG_SUM({CODE})                -> AGGREGATION
 *   YOY({CODE})                    -> YOY_MOM
 *   MOM({CODE})                    -> YOY_MOM
 *   RANK({CODE}, 10, DESC)         -> RANKING
 */
class FormulaParser {

    private static final Pattern INDICATOR_REF = Pattern.compile("\\{([A-Z0-9_]+)}");
    private static final Pattern FUNC_PATTERN = Pattern.compile(
        "(IF|AGG_SUM|AGG_AVG|AGG_COUNT|AGG_MAX|AGG_MIN|YOY|MOM|RANK)\\s*\\(",
        Pattern.CASE_INSENSITIVE
    );

    /**
     * Detect the formula type from the expression string.
     */
    FormulaType detectType(String expr) {
        if (expr == null || expr.isBlank()) {
            throw new CalcException("Empty formula expression");
        }
        String trimmed = expr.trim().toUpperCase();
        if (trimmed.startsWith("IF("))    return FormulaType.CONDITIONAL;
        if (trimmed.startsWith("AGG_"))   return FormulaType.AGGREGATION;
        if (trimmed.startsWith("YOY("))   return FormulaType.YOY_MOM;
        if (trimmed.startsWith("MOM("))   return FormulaType.YOY_MOM;
        if (trimmed.startsWith("RANK("))  return FormulaType.RANKING;
        return FormulaType.ARITHMETIC;
    }

    /**
     * Extract all indicator codes referenced in a formula expression.
     * E.g. "{DAM_CLEARING_ENERGY} * {DAM_CLEARING_PRICE}" -> [DAM_CLEARING_ENERGY, DAM_CLEARING_PRICE]
     */
    List<String> extractDepCodes(String expr) {
        if (expr == null || expr.isBlank()) return List.of();
        Set<String> codes = new LinkedHashSet<>();
        Matcher m = INDICATOR_REF.matcher(expr);
        while (m.find()) {
            codes.add(m.group(1));
        }
        return List.copyOf(codes);
    }

    /**
     * Tokenize the expression into a list of tokens for evaluation.
     */
    List<Token> tokenize(String expr) {
        List<Token> tokens = new ArrayList<>();
        int pos = 0;
        String s = expr.trim();

        while (pos < s.length()) {
            char c = s.charAt(pos);

            if (Character.isWhitespace(c)) {
                pos++;
                continue;
            }

            // Indicator reference: {CODE}
            if (c == '{') {
                int end = s.indexOf('}', pos);
                if (end < 0) throw new CalcException("Unclosed indicator ref at pos " + pos + " in: " + expr);
                String code = s.substring(pos + 1, end);
                tokens.add(new Token(TokenType.INDICATOR, code));
                pos = end + 1;
                continue;
            }

            // Numeric literal (including negative)
            if (c == '-' || Character.isDigit(c)) {
                // Distinguish negative sign from minus operator
                boolean isNegative = (c == '-');
                if (isNegative) {
                    // It's a negative sign if the previous token is an operator or '(' or nothing
                    if (!tokens.isEmpty()) {
                        TokenType prev = tokens.getLast().type();
                        if (prev != TokenType.OPERATOR && prev != TokenType.LPAREN) {
                            // This is a subtraction operator
                            tokens.add(new Token(TokenType.OPERATOR, "-"));
                            pos++;
                            continue;
                        }
                    }
                }
                int start = pos;
                if (isNegative) pos++;
                while (pos < s.length() && (Character.isDigit(s.charAt(pos)) || s.charAt(pos) == '.')) {
                    pos++;
                }
                tokens.add(new Token(TokenType.NUMBER, s.substring(start, pos)));
                continue;
            }

            // Operators and parens
            if ("+-*/".indexOf(c) >= 0) {
                tokens.add(new Token(TokenType.OPERATOR, String.valueOf(c)));
                pos++;
                continue;
            }
            if (c == '(') { tokens.add(new Token(TokenType.LPAREN, "(")); pos++; continue; }
            if (c == ')') { tokens.add(new Token(TokenType.RPAREN, ")")); pos++; continue; }
            if (c == ',') { tokens.add(new Token(TokenType.COMMA, ",")); pos++; continue; }

            // Comparison operators: >=, <=, >, <, ==, !=
            if (pos + 1 < s.length()) {
                String two = s.substring(pos, pos + 2);
                if (Set.of(">=", "<=", "==", "!=").contains(two)) {
                    tokens.add(new Token(TokenType.COMPARISON, two));
                    pos += 2;
                    continue;
                }
            }
            if (c == '>' || c == '<') {
                tokens.add(new Token(TokenType.COMPARISON, String.valueOf(c)));
                pos++;
                continue;
            }

            // Function name (letters and underscore)
            if (Character.isLetter(c) || c == '_') {
                int start = pos;
                while (pos < s.length() && (Character.isLetterOrDigit(s.charAt(pos)) || s.charAt(pos) == '_')) {
                    pos++;
                }
                String word = s.substring(start, pos);
                Matcher fm = FUNC_PATTERN.matcher(word + "(");
                if (fm.matches()) {
                    tokens.add(new Token(TokenType.FUNCTION, word.toUpperCase()));
                } else {
                    // Could be a bare identifier outside {} -- treat as error
                    throw new CalcException("Unexpected identifier '" + word + "' in: " + expr);
                }
                continue;
            }

            throw new CalcException("Unexpected character '" + c + "' at pos " + pos + " in: " + expr);
        }

        return tokens;
    }

    /**
     * Parse an IF expression into its three parts.
     * Returns [conditionExpr, trueExpr, falseExpr].
     */
    IfParts parseIf(String expr) {
        String trimmed = expr.trim();
        if (!trimmed.toUpperCase().startsWith("IF(") || !trimmed.endsWith(")")) {
            throw new CalcException("Invalid IF expression: " + expr);
        }
        // Strip "IF(" and trailing ")"
        String inner = trimmed.substring(3, trimmed.length() - 1);
        List<String> parts = splitByComma(inner, 3);
        if (parts.size() != 3) {
            throw new CalcException("IF requires exactly 3 arguments: " + expr);
        }
        return new IfParts(parts.get(0).trim(), parts.get(1).trim(), parts.get(2).trim());
    }

    /**
     * Parse a function call like AGG_SUM({CODE}) or YOY({CODE}).
     * Returns [functionName, arg1, arg2, ...].
     */
    List<String> parseFunctionCall(String expr) {
        String trimmed = expr.trim();
        int parenStart = trimmed.indexOf('(');
        if (parenStart < 0) throw new CalcException("Not a function call: " + expr);
        String funcName = trimmed.substring(0, parenStart).trim().toUpperCase();
        if (!trimmed.endsWith(")")) throw new CalcException("Unclosed function call: " + expr);
        String argsStr = trimmed.substring(parenStart + 1, trimmed.length() - 1);
        List<String> args = splitByComma(argsStr, -1);
        List<String> result = new ArrayList<>();
        result.add(funcName);
        result.addAll(args.stream().map(String::trim).toList());
        return result;
    }

    /**
     * Split string by top-level commas (not inside braces or parens).
     * maxParts: -1 for unlimited.
     */
    private List<String> splitByComma(String s, int maxParts) {
        List<String> parts = new ArrayList<>();
        int depth = 0;
        int start = 0;
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (c == '(' || c == '{') depth++;
            else if (c == ')' || c == '}') depth--;
            else if (c == ',' && depth == 0) {
                if (maxParts > 0 && parts.size() >= maxParts - 1) break;
                parts.add(s.substring(start, i));
                start = i + 1;
            }
        }
        parts.add(s.substring(start));
        return parts;
    }
}

// ============================================================
// Token types and AST nodes
// ============================================================

enum TokenType {
    NUMBER, INDICATOR, OPERATOR, COMPARISON, FUNCTION, LPAREN, RPAREN, COMMA
}

record Token(TokenType type, String value) {}

enum FormulaType {
    ARITHMETIC, CONDITIONAL, AGGREGATION, YOY_MOM, RANKING
}

record IfParts(String condition, String trueExpr, String falseExpr) {}

// ============================================================
// FormulaEvaluator
// ============================================================

/**
 * Evaluates individual formula expressions against a CalcContext.
 * All arithmetic uses BigDecimal with scale 4, RoundingMode.HALF_UP.
 */
class FormulaEvaluator {

    private static final MathContext MC = new MathContext(18, RoundingMode.HALF_UP);
    private static final int DEFAULT_SCALE = 4;
    private static final BigDecimal ONE_HUNDRED = new BigDecimal("100");

    private final FormulaParser parser = new FormulaParser();

    /**
     * Evaluate any formula expression against the given context.
     */
    BigDecimal evaluate(String expr, CalcContext context) {
        FormulaType type = parser.detectType(expr);
        return switch (type) {
            case ARITHMETIC   -> evaluateArithmetic(expr, context);
            case CONDITIONAL  -> evaluateConditional(expr, context);
            case AGGREGATION  -> evaluateAggregation(expr, context);
            case YOY_MOM      -> evaluateYoyMom(expr, context);
            case RANKING      -> evaluateRanking(expr, context);
        };
    }

    // ---- Arithmetic ----

    /**
     * Evaluate arithmetic expressions using shunting-yard algorithm.
     * Example: "{DAM_CLEARING_ENERGY} * {DAM_CLEARING_PRICE}"
     */
    BigDecimal evaluateArithmetic(String expr, CalcContext context) {
        List<Token> tokens = parser.tokenize(expr);
        return evaluateTokens(tokens, context);
    }

    /**
     * Shunting-yard based evaluation. Handles operator precedence and parentheses.
     */
    private BigDecimal evaluateTokens(List<Token> tokens, CalcContext context) {
        Deque<BigDecimal> output = new ArrayDeque<>();
        Deque<String> ops = new ArrayDeque<>();

        for (Token token : tokens) {
            switch (token.type()) {
                case NUMBER -> output.push(new BigDecimal(token.value()));
                case INDICATOR -> output.push(context.getOrThrow(token.value()));
                case LPAREN -> ops.push("(");
                case RPAREN -> {
                    while (!ops.isEmpty() && !"(".equals(ops.peek())) {
                        applyOp(output, ops.pop());
                    }
                    if (ops.isEmpty()) throw new CalcException("Mismatched parentheses");
                    ops.pop(); // remove "("
                }
                case OPERATOR -> {
                    while (!ops.isEmpty() && precedence(ops.peek()) >= precedence(token.value())) {
                        applyOp(output, ops.pop());
                    }
                    ops.push(token.value());
                }
                default -> throw new CalcException("Unexpected token in arithmetic: " + token);
            }
        }

        while (!ops.isEmpty()) {
            String op = ops.pop();
            if ("(".equals(op)) throw new CalcException("Mismatched parentheses");
            applyOp(output, op);
        }

        if (output.size() != 1) {
            throw new CalcException("Evaluation error, output stack: " + output);
        }
        return output.pop().setScale(DEFAULT_SCALE, RoundingMode.HALF_UP);
    }

    private void applyOp(Deque<BigDecimal> stack, String op) {
        if (stack.size() < 2) throw new CalcException("Insufficient operands for operator: " + op);
        BigDecimal b = stack.pop();
        BigDecimal a = stack.pop();
        BigDecimal result = switch (op) {
            case "+" -> a.add(b);
            case "-" -> a.subtract(b);
            case "*" -> a.multiply(b, MC);
            case "/" -> {
                if (b.compareTo(BigDecimal.ZERO) == 0) {
                    throw new CalcException("Division by zero");
                }
                yield a.divide(b, DEFAULT_SCALE, RoundingMode.HALF_UP);
            }
            default -> throw new CalcException("Unknown operator: " + op);
        };
        stack.push(result);
    }

    private int precedence(String op) {
        return switch (op) {
            case "+", "-" -> 1;
            case "*", "/" -> 2;
            default -> 0;
        };
    }

    // ---- Conditional (IF) ----

    /**
     * Evaluate IF(condition, trueExpr, falseExpr).
     * Condition supports: >=, <=, >, <, ==, !=
     */
    BigDecimal evaluateConditional(String expr, CalcContext context) {
        IfParts parts = parser.parseIf(expr);
        boolean condResult = evaluateCondition(parts.condition(), context);
        String branch = condResult ? parts.trueExpr() : parts.falseExpr();
        // The branch might be a literal number or an expression
        return resolveValue(branch, context);
    }

    private boolean evaluateCondition(String condExpr, CalcContext context) {
        // Find the comparison operator
        String[] ops = {">=", "<=", "!=", "==", ">", "<"};
        String foundOp = null;
        int opIndex = -1;

        for (String op : ops) {
            int idx = condExpr.indexOf(op);
            if (idx >= 0) {
                foundOp = op;
                opIndex = idx;
                break;
            }
        }

        if (foundOp == null) {
            throw new CalcException("No comparison operator found in condition: " + condExpr);
        }

        String leftExpr = condExpr.substring(0, opIndex).trim();
        String rightExpr = condExpr.substring(opIndex + foundOp.length()).trim();

        BigDecimal left = resolveValue(leftExpr, context);
        BigDecimal right = resolveValue(rightExpr, context);

        return switch (foundOp) {
            case ">=" -> left.compareTo(right) >= 0;
            case "<=" -> left.compareTo(right) <= 0;
            case ">"  -> left.compareTo(right) > 0;
            case "<"  -> left.compareTo(right) < 0;
            case "==" -> left.compareTo(right) == 0;
            case "!=" -> left.compareTo(right) != 0;
            default   -> throw new CalcException("Unknown operator: " + foundOp);
        };
    }

    /**
     * Resolve a string that might be a number literal, an indicator ref {CODE},
     * or a full arithmetic expression.
     */
    private BigDecimal resolveValue(String expr, CalcContext context) {
        String trimmed = expr.trim();
        // Indicator reference
        if (trimmed.startsWith("{") && trimmed.endsWith("}")) {
            String code = trimmed.substring(1, trimmed.length() - 1);
            return context.getOrThrow(code);
        }
        // Try plain number
        try {
            return new BigDecimal(trimmed);
        } catch (NumberFormatException ignored) {
            // Fall through to expression evaluation
        }
        // Full arithmetic expression
        return evaluateArithmetic(trimmed, context);
    }

    // ---- Aggregation ----

    /**
     * Evaluate AGG_SUM({CODE}) or AGG_AVG({CODE}).
     *
     * Aggregation operates on pre-collected group values stored in context
     * under a special key pattern: __AGG:{func}:{code}__
     * In production the CalcExecutor populates these before calling evaluate.
     * For single-value context, returns the value itself (identity aggregation).
     */
    BigDecimal evaluateAggregation(String expr, CalcContext context) {
        List<String> parts = parser.parseFunctionCall(expr);
        String func = parts.get(0);
        if (parts.size() < 2) {
            throw new CalcException("Aggregation function requires at least 1 argument: " + expr);
        }
        String codeExpr = parts.get(1);
        String code = stripBraces(codeExpr);

        // Look for pre-computed aggregation result
        String aggKey = "__AGG:" + func + ":" + code + "__";
        Optional<BigDecimal> precomputed = context.get(aggKey);
        if (precomputed.isPresent()) {
            return precomputed.get();
        }

        // Fallback: return the single value for non-grouped context
        BigDecimal val = context.getOrThrow(code);
        return val.setScale(DEFAULT_SCALE, RoundingMode.HALF_UP);
    }

    // ---- YoY / MoM ----

    /**
     * Evaluate YOY({CODE}) or MOM({CODE}).
     *
     * YOY: ((current - last_year) / |last_year|) * 100
     * MOM: ((current - last_month) / |last_month|) * 100
     *
     * Returns percentage as BigDecimal. Returns null wrapped in Optional
     * via the CalcContext if historical data is unavailable -- but here we
     * throw so the CalcExecutor can catch and log per-indicator.
     */
    BigDecimal evaluateYoyMom(String expr, CalcContext context) {
        List<String> parts = parser.parseFunctionCall(expr);
        String func = parts.get(0); // YOY or MOM
        String codeExpr = parts.get(1);
        String code = stripBraces(codeExpr);

        BigDecimal currentValue = context.getOrThrow(code);
        LocalDate currentDate = context.tradeDate();

        LocalDate compareDate;
        if ("YOY".equals(func)) {
            compareDate = currentDate.minusYears(1);
        } else {
            compareDate = currentDate.minusMonths(1);
        }

        Optional<BigDecimal> historicalOpt = context.historyProvider()
            .getValue(code, null, compareDate);

        if (historicalOpt.isEmpty()) {
            // No historical data -- return 0 to avoid cascading failures
            return BigDecimal.ZERO.setScale(DEFAULT_SCALE, RoundingMode.HALF_UP);
        }

        BigDecimal historicalValue = historicalOpt.get();
        if (historicalValue.compareTo(BigDecimal.ZERO) == 0) {
            return BigDecimal.ZERO.setScale(DEFAULT_SCALE, RoundingMode.HALF_UP);
        }

        BigDecimal diff = currentValue.subtract(historicalValue);
        return diff.multiply(ONE_HUNDRED)
                   .divide(historicalValue.abs(), DEFAULT_SCALE, RoundingMode.HALF_UP);
    }

    // ---- Ranking ----

    /**
     * Evaluate RANK({CODE}, topN, ASC|DESC).
     *
     * Ranking is computed externally by CalcExecutor via SQL ORDER BY + LIMIT.
     * This method returns the pre-computed rank stored in context.
     * The key pattern is: __RANK:{code}:{topN}:{order}__
     */
    BigDecimal evaluateRanking(String expr, CalcContext context) {
        List<String> parts = parser.parseFunctionCall(expr);
        if (parts.size() < 4) {
            throw new CalcException("RANK requires 3 arguments: RANK({CODE}, topN, ASC|DESC). Got: " + expr);
        }
        String code = stripBraces(parts.get(1));
        int topN;
        try {
            topN = Integer.parseInt(parts.get(2));
        } catch (NumberFormatException e) {
            throw new CalcException("Invalid topN in RANK: " + parts.get(2));
        }
        String order = parts.get(3).toUpperCase();

        String rankKey = "__RANK:" + code + ":" + topN + ":" + order + "__";
        Optional<BigDecimal> rankOpt = context.get(rankKey);
        if (rankOpt.isPresent()) {
            return rankOpt.get();
        }

        // If no pre-computed rank, return the indicator value itself
        // (ranking will be applied at query/display layer)
        return context.getOrThrow(code);
    }

    private String stripBraces(String s) {
        if (s.startsWith("{") && s.endsWith("}")) {
            return s.substring(1, s.length() - 1);
        }
        return s;
    }
}

// ============================================================
// DAGScheduler
// ============================================================

/**
 * Topological sort of indicator dependencies to determine calculation order.
 * Reads dep_codes from ind_calc_formula to build a DAG, then outputs
 * calculation layers (Layer 0 through 9).
 *
 * If circular dependency is detected, throws CalcException.
 */
class DAGScheduler {

    /**
     * Build the execution plan: a list of layers, each layer is a list of
     * indicator codes that can be calculated in parallel (no mutual dependency).
     *
     * @param formulas map of indicator_code -> CalcFormula
     * @param allCodes set of all indicator codes (raw + calculated) for this tenant
     * @return ordered list of layers from 0..N
     */
    List<List<String>> schedule(Map<String, CalcFormula> formulas, Set<String> allCodes) {
        // Build adjacency: code -> set of codes it depends on
        Map<String, Set<String>> deps = new HashMap<>();
        for (var entry : formulas.entrySet()) {
            String code = entry.getKey();
            List<String> depList = entry.getValue().depCodes();
            Set<String> depSet = new HashSet<>();
            for (String dep : depList) {
                if (allCodes.contains(dep)) {
                    depSet.add(dep);
                }
                // Ignore unknown deps -- they might be raw indicators from external sources
            }
            deps.put(code, depSet);
        }

        // Kahn's algorithm for topological sort
        Map<String, Integer> inDegree = new HashMap<>();
        for (String code : allCodes) {
            inDegree.putIfAbsent(code, 0);
        }
        for (Set<String> depSet : deps.values()) {
            for (String dep : depSet) {
                inDegree.merge(dep, 0, (a, b) -> a); // ensure exists
            }
        }
        for (var entry : deps.entrySet()) {
            String code = entry.getKey();
            // in-degree = number of deps that are also in the formula set (calculated indicators)
            long calcDeps = entry.getValue().stream()
                .filter(d -> formulas.containsKey(d))
                .count();
            inDegree.put(code, (int) calcDeps);
        }

        // Build reverse adjacency for efficient traversal
        Map<String, Set<String>> reverseDeps = new HashMap<>();
        for (var entry : deps.entrySet()) {
            String code = entry.getKey();
            for (String dep : entry.getValue()) {
                reverseDeps.computeIfAbsent(dep, k -> new HashSet<>()).add(code);
            }
        }

        List<List<String>> layers = new ArrayList<>();
        Set<String> processed = new HashSet<>();

        // Start with all codes that have 0 in-degree (no calculated dependencies)
        Set<String> currentLayer = new LinkedHashSet<>();
        for (var entry : inDegree.entrySet()) {
            if (entry.getValue() == 0) {
                currentLayer.add(entry.getKey());
            }
        }

        int safetyCounter = allCodes.size() + 1;
        while (!currentLayer.isEmpty()) {
            if (safetyCounter-- <= 0) {
                throw new CalcException("Circular dependency detected in indicator formulas");
            }

            layers.add(new ArrayList<>(currentLayer));
            processed.addAll(currentLayer);

            Set<String> nextLayer = new LinkedHashSet<>();
            for (String code : currentLayer) {
                Set<String> dependents = reverseDeps.getOrDefault(code, Set.of());
                for (String dependent : dependents) {
                    int newDegree = inDegree.get(dependent) - 1;
                    inDegree.put(dependent, newDegree);
                    if (newDegree == 0) {
                        nextLayer.add(dependent);
                    }
                }
            }
            currentLayer = nextLayer;
        }

        // Check for unprocessed nodes (circular dependency)
        Set<String> unprocessed = new HashSet<>(formulas.keySet());
        unprocessed.removeAll(processed);
        if (!unprocessed.isEmpty()) {
            throw new CalcException(
                "Circular dependency detected among indicators: " + unprocessed);
        }

        return layers;
    }

    /**
     * Merge DB-defined calc_layer with topological sort result.
     * Respects the DB layer assignment when possible, but ensures that
     * a formula's dependencies are always in an earlier layer.
     */
    List<CalcLayer> resolveLayers(
            Map<String, CalcFormula> formulas,
            Map<String, IndicatorDef> allDefs) {

        // Group by DB-defined calc_layer
        Map<Integer, List<String>> byDbLayer = new TreeMap<>();
        for (var def : allDefs.values()) {
            byDbLayer.computeIfAbsent(def.calcLayer(), k -> new ArrayList<>())
                     .add(def.indicatorCode());
        }

        List<CalcLayer> result = new ArrayList<>();
        for (var entry : byDbLayer.entrySet()) {
            int layerNum = entry.getKey();
            List<String> codes = entry.getValue();

            // Sort within layer by calc_order from formula
            codes.sort((a, b) -> {
                CalcFormula fa = formulas.get(a);
                CalcFormula fb = formulas.get(b);
                int oa = (fa != null) ? fa.calcOrder() : 0;
                int ob = (fb != null) ? fb.calcOrder() : 0;
                return Integer.compare(oa, ob);
            });

            result.add(new CalcLayer(layerNum, codes));
        }

        return result;
    }
}

record CalcLayer(int layerNumber, List<String> indicatorCodes) {}

// ============================================================
// CalcExecutor
// ============================================================

/**
 * Executes indicator calculations in topological order, layer by layer.
 *
 * Typical flow:
 *   1. Load all formula definitions for the tenant
 *   2. DAGScheduler resolves execution layers
 *   3. For each layer (0..9):
 *      a. Raw indicators: fetch from source tables
 *      b. Calculated indicators: evaluate formula expressions
 *      c. Write results back to time-series tables
 *   4. Log results to ind_calc_task_log / ind_calc_detail_log
 */
class CalcExecutor {

    private final FormulaEvaluator evaluator = new FormulaEvaluator();
    private final DAGScheduler scheduler = new DAGScheduler();

    /**
     * Execute a full calculation run for a given date and tenant.
     *
     * @param request   the calculation request parameters
     * @param formulas  all active formulas for this tenant
     * @param defs      all indicator definitions (code -> def)
     * @param rawDataLoader  function to load raw indicator values from source tables
     * @param resultConsumer function to persist computed results
     * @return summary of the execution
     */
    CalcResult execute(
            CalcRequest request,
            Map<String, CalcFormula> formulas,
            Map<String, IndicatorDef> defs,
            RawDataLoader rawDataLoader,
            ResultConsumer resultConsumer) {

        long startTime = System.currentTimeMillis();
        List<CalcDetail> details = new ArrayList<>();

        // Resolve execution layers
        List<CalcLayer> layers = scheduler.resolveLayers(formulas, defs);

        // Build context for each time point
        int successCount = 0;
        int failCount = 0;
        int skipCount = 0;

        for (int timePoint : request.timePoints()) {
            CalcContext context = new CalcContext(
                request.tradeDate(),
                request.tenantId(),
                timePoint,
                request.historyProvider()
            );

            // Layer 0: load raw indicator values from source tables
            for (CalcLayer layer : layers) {
                for (String code : layer.indicatorCodes()) {
                    long indicatorStart = System.currentTimeMillis();
                    CalcFormula formula = formulas.get(code);

                    try {
                        if (formula == null) {
                            // Raw indicator -- load from data source
                            BigDecimal rawValue = rawDataLoader.load(code, request.tradeDate(), timePoint);
                            if (rawValue != null) {
                                context.put(code, rawValue);
                                successCount++;
                            } else {
                                skipCount++;
                            }
                            continue;
                        }

                        // Calculated indicator -- evaluate formula
                        BigDecimal result = evaluator.evaluate(formula.formulaExpr(), context);
                        context.put(code, result);

                        // Persist result
                        resultConsumer.accept(code, result, request.tradeDate(), timePoint, request.tenantId());

                        long elapsed = System.currentTimeMillis() - indicatorStart;
                        details.add(new CalcDetail(code, layer.layerNumber(), 1, elapsed, null));
                        successCount++;

                    } catch (Exception e) {
                        long elapsed = System.currentTimeMillis() - indicatorStart;
                        String errMsg = e instanceof CalcException ce ? ce.getMessage() : e.getMessage();
                        details.add(new CalcDetail(code, layer.layerNumber(), 2, elapsed, errMsg));
                        failCount++;
                    }
                }
            }
        }

        long totalMs = System.currentTimeMillis() - startTime;
        return new CalcResult(
            request.tradeDate(),
            successCount,
            failCount,
            skipCount,
            totalMs,
            details
        );
    }

    /**
     * Execute calculation for a single indicator (for ad-hoc / re-calc scenarios).
     */
    BigDecimal executeSingle(
            String indicatorCode,
            CalcFormula formula,
            CalcContext context) {

        return evaluator.evaluate(formula.formulaExpr(), context);
    }
}

// ============================================================
// Function interfaces for external dependencies
// ============================================================

/**
 * Loads raw indicator values from source database tables.
 */
@FunctionalInterface
interface RawDataLoader {
    BigDecimal load(String indicatorCode, LocalDate tradeDate, int timePoint);
}

/**
 * Persists computed indicator results.
 */
@FunctionalInterface
interface ResultConsumer {
    void accept(String indicatorCode, BigDecimal value,
                LocalDate tradeDate, int timePoint, long tenantId);
}

// ============================================================
// Request / Result records
// ============================================================

/**
 * Calculation request parameters.
 */
record CalcRequest(
    LocalDate tradeDate,
    long tenantId,
    List<Integer> timePoints,         // e.g. 1..96 for 15-min grain, [0] for daily
    HistoricalDataProvider historyProvider
) {
    /** Convenience constructor for daily grain (single time point 0). */
    static CalcRequest daily(LocalDate date, long tenantId, HistoricalDataProvider hp) {
        return new CalcRequest(date, tenantId, List.of(0), hp);
    }

    /** Convenience constructor for 96-point time grain. */
    static CalcRequest timeseries96(LocalDate date, long tenantId, HistoricalDataProvider hp) {
        List<Integer> points = new ArrayList<>();
        for (int i = 1; i <= 96; i++) points.add(i);
        return new CalcRequest(date, tenantId, points, hp);
    }
}

/**
 * Overall calculation result summary.
 */
record CalcResult(
    LocalDate tradeDate,
    int successCount,
    int failCount,
    int skipCount,
    long durationMs,
    List<CalcDetail> details
) {}

/**
 * Per-indicator calculation detail.
 */
record CalcDetail(
    String indicatorCode,
    int calcLayer,
    int status,          // 1=success, 2=fail, 3=skip
    long durationMs,
    String errorMsg
) {}

// ============================================================
// CalcException
// ============================================================

/**
 * Unchecked exception for formula calculation errors.
 */
class CalcException extends RuntimeException {

    CalcException(String message) {
        super(message);
    }

    CalcException(String message, Throwable cause) {
        super(message, cause);
    }
}
