package com.qctc.bdss.indicator.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.qctc.bdss.indicator.dto.response.*;
import com.qctc.bdss.indicator.entity.IndDataDaily;
import com.qctc.bdss.indicator.entity.IndDataMonthly;
import com.qctc.bdss.indicator.entity.IndDataTimeseries;
import com.qctc.bdss.indicator.entity.IndicatorDef;
import com.qctc.bdss.indicator.mapper.IndDataDailyMapper;
import com.qctc.bdss.indicator.mapper.IndDataMonthlyMapper;
import com.qctc.bdss.indicator.mapper.IndDataTimeseriesMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class IndicatorDataService extends ServiceImpl<IndDataTimeseriesMapper, IndDataTimeseries> {

    @Autowired
    private IndicatorDefService indicatorDefService;

    @Autowired
    private IndDataDailyMapper dailyMapper;

    @Autowired
    private IndDataMonthlyMapper monthlyMapper;

    // ─── 时序数据查询 ────────────────────────────────
    public List<TimeseriesDataVO> getTimeseries(String indicatorCode, String unitId,
                                                  LocalDate startDate, LocalDate endDate, Long tenantId) {
        IndicatorDef def = indicatorDefService.getByCode(indicatorCode, tenantId);
        if (def == null) return Collections.emptyList();

        LambdaQueryWrapper<IndDataTimeseries> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(IndDataTimeseries::getIndicatorCode, indicatorCode);
        if (unitId != null && !"ALL".equals(unitId)) wrapper.eq(IndDataTimeseries::getUnitId, unitId);
        wrapper.between(IndDataTimeseries::getTradeDate, startDate, endDate);
        if (tenantId != null) wrapper.eq(IndDataTimeseries::getTenantId, tenantId);
        wrapper.orderByAsc(IndDataTimeseries::getTradeDate, IndDataTimeseries::getTimePoint);

        return list(wrapper).stream().map(ts -> {
            TimeseriesDataVO vo = new TimeseriesDataVO();
            vo.setIndicatorCode(ts.getIndicatorCode());
            vo.setIndicatorName(def.getIndicatorName());
            vo.setUnitId(ts.getUnitId());
            vo.setUnitName(ts.getUnitName());
            vo.setTradeDate(ts.getTradeDate());
            vo.setTimePoint(ts.getTimePoint());
            vo.setValue(ts.getValue());
            vo.setDataType(ts.getDataType());
            return vo;
        }).collect(Collectors.toList());
    }

    // ─── 日维度数据查询 ────────────────────────────────
    public List<DailyDataVO> getDaily(String indicatorCode, String unitId,
                                       LocalDate startDate, LocalDate endDate, Long tenantId) {
        IndicatorDef def = indicatorDefService.getByCode(indicatorCode, tenantId);
        if (def == null) return Collections.emptyList();

        LambdaQueryWrapper<IndDataDaily> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(IndDataDaily::getIndicatorCode, indicatorCode);
        if (unitId != null && !"ALL".equals(unitId)) wrapper.eq(IndDataDaily::getUnitId, unitId);
        wrapper.between(IndDataDaily::getTradeDate, startDate, endDate);
        if (tenantId != null) wrapper.eq(IndDataDaily::getTenantId, tenantId);
        wrapper.orderByAsc(IndDataDaily::getTradeDate);

        return dailyMapper.selectList(wrapper).stream().map(d -> {
            DailyDataVO vo = new DailyDataVO();
            vo.setIndicatorCode(d.getIndicatorCode());
            vo.setIndicatorName(def.getIndicatorName());
            vo.setUnitId(d.getUnitId());
            vo.setUnitName(d.getUnitName());
            vo.setTradeDate(d.getTradeDate());
            vo.setValue(d.getValue());
            vo.setMinValue(d.getMinValue());
            vo.setMaxValue(d.getMaxValue());
            vo.setAvgValue(d.getAvgValue());
            return vo;
        }).collect(Collectors.toList());
    }

    // ─── 月维度数据查询 ────────────────────────────────
    public List<MonthlyDataVO> getMonthly(String indicatorCode, String unitId,
                                            String startMonth, String endMonth, Long tenantId) {
        IndicatorDef def = indicatorDefService.getByCode(indicatorCode, tenantId);
        if (def == null) return Collections.emptyList();

        LambdaQueryWrapper<IndDataMonthly> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(IndDataMonthly::getIndicatorCode, indicatorCode);
        if (unitId != null && !"ALL".equals(unitId)) wrapper.eq(IndDataMonthly::getUnitId, unitId);
        wrapper.between(IndDataMonthly::getTradeMonth, startMonth, endMonth);
        if (tenantId != null) wrapper.eq(IndDataMonthly::getTenantId, tenantId);
        wrapper.orderByAsc(IndDataMonthly::getTradeMonth);

        return monthlyMapper.selectList(wrapper).stream().map(m -> {
            MonthlyDataVO vo = new MonthlyDataVO();
            vo.setIndicatorCode(m.getIndicatorCode());
            vo.setIndicatorName(def.getIndicatorName());
            vo.setUnitId(m.getUnitId());
            vo.setUnitName(m.getUnitName());
            vo.setTradeMonth(m.getTradeMonth());
            vo.setValue(m.getValue());
            vo.setYearCumulative(m.getYearCumulative());
            return vo;
        }).collect(Collectors.toList());
    }

    // ─── KPI 数据 ────────────────────────────────────
    public List<KpiDataVO> getKpi(Long tenantId) {
        // Dashboard 核心 KPI 指标编码
        String[] kpiCodes = {
            "MLT_CONTRACT_ENERGY", "ONLINE_ENERGY", "SPOT_FULL_FEE",
            "TOTAL_AVG_PRICE", "TOTAL_MARGIN"
        };

        LocalDate yesterday = LocalDate.now().minusDays(1);
        LocalDate dayBefore = yesterday.minusDays(1);
        LocalDate lastYearSame = yesterday.minusYears(1);

        List<KpiDataVO> result = new ArrayList<>();
        for (String code : kpiCodes) {
            IndicatorDef def = indicatorDefService.getByCode(code, tenantId);
            if (def == null) continue;

            KpiDataVO vo = new KpiDataVO();
            vo.setCode(code);
            vo.setLabel(def.getIndicatorName());
            vo.setUnit(def.getUnit());

            // 取昨日值
            IndDataDaily todayData = getLatestDaily(code, yesterday, tenantId);
            if (todayData != null) {
                vo.setValue(todayData.getValue());
            }

            // 取同比值（去年同日）
            IndDataDaily yoyData = getLatestDaily(code, lastYearSame, tenantId);
            if (todayData != null && todayData.getValue() != null
                    && yoyData != null && yoyData.getValue() != null
                    && yoyData.getValue().compareTo(BigDecimal.ZERO) != 0) {
                BigDecimal rate = todayData.getValue().subtract(yoyData.getValue())
                        .multiply(new BigDecimal("100"))
                        .divide(yoyData.getValue(), 1, RoundingMode.HALF_UP);
                vo.setChangeRate(rate);
                vo.setChangeType("yoy");
                vo.setChangeDirection(rate.compareTo(BigDecimal.ZERO) > 0 ? "up" :
                        rate.compareTo(BigDecimal.ZERO) < 0 ? "down" : "flat");
            }

            // 如果同比没有数据，尝试环比
            if (vo.getChangeRate() == null) {
                IndDataDaily momData = getLatestDaily(code, dayBefore, tenantId);
                if (todayData != null && todayData.getValue() != null
                        && momData != null && momData.getValue() != null
                        && momData.getValue().compareTo(BigDecimal.ZERO) != 0) {
                    BigDecimal rate = todayData.getValue().subtract(momData.getValue())
                            .multiply(new BigDecimal("100"))
                            .divide(momData.getValue(), 1, RoundingMode.HALF_UP);
                    vo.setChangeRate(rate);
                    vo.setChangeType("mom");
                    vo.setChangeDirection(rate.compareTo(BigDecimal.ZERO) > 0 ? "up" :
                            rate.compareTo(BigDecimal.ZERO) < 0 ? "down" : "flat");
                }
            }

            result.add(vo);
        }
        return result;
    }

    // ─── 同环比对比 ──────────────────────────────────
    public List<CompareDataVO> getCompare(String indicatorCode, String unitId,
                                           String compareType, Integer periods, Long tenantId) {
        IndicatorDef def = indicatorDefService.getByCode(indicatorCode, tenantId);
        if (def == null) return Collections.emptyList();

        LocalDate endDate = LocalDate.now().minusDays(1);
        LocalDate startDate;
        LocalDate compareStart;

        if ("yoy".equals(compareType)) {
            // 同比：过去N个月 vs 去年同期
            startDate = endDate.minusMonths(periods != null ? periods : 12).withDayOfMonth(1);
            compareStart = startDate.minusYears(1);
        } else {
            // 环比：过去N个月 vs 前N个月
            startDate = endDate.minusMonths(periods != null ? periods : 12).withDayOfMonth(1);
            compareStart = startDate.minusMonths(periods != null ? periods : 12);
        }

        // 查询当前期数据（月维度）
        LambdaQueryWrapper<IndDataMonthly> currentWrapper = new LambdaQueryWrapper<>();
        currentWrapper.eq(IndDataMonthly::getIndicatorCode, indicatorCode);
        if (unitId != null && !"ALL".equals(unitId)) currentWrapper.eq(IndDataMonthly::getUnitId, unitId);
        currentWrapper.between(IndDataMonthly::getTradeMonth,
                startDate.format(DateTimeFormatter.ofPattern("yyyy-MM")),
                endDate.format(DateTimeFormatter.ofPattern("yyyy-MM")));
        if (tenantId != null) currentWrapper.eq(IndDataMonthly::getTenantId, tenantId);
        currentWrapper.orderByAsc(IndDataMonthly::getTradeMonth);
        List<IndDataMonthly> currentData = monthlyMapper.selectList(currentWrapper);

        // 查询对比期数据
        LambdaQueryWrapper<IndDataMonthly> compareWrapper = new LambdaQueryWrapper<>();
        compareWrapper.eq(IndDataMonthly::getIndicatorCode, indicatorCode);
        if (unitId != null && !"ALL".equals(unitId)) compareWrapper.eq(IndDataMonthly::getUnitId, unitId);
        compareWrapper.between(IndDataMonthly::getTradeMonth,
                compareStart.format(DateTimeFormatter.ofPattern("yyyy-MM")),
                startDate.minusMonths(1).format(DateTimeFormatter.ofPattern("yyyy-MM")));
        if (tenantId != null) compareWrapper.eq(IndDataMonthly::getTenantId, tenantId);
        compareWrapper.orderByAsc(IndDataMonthly::getTradeMonth);
        List<IndDataMonthly> compareData = monthlyMapper.selectList(compareWrapper);

        // 按 month 做 map
        Map<String, BigDecimal> compareMap = compareData.stream()
                .filter(m -> m.getValue() != null)
                .collect(Collectors.toMap(IndDataMonthly::getTradeMonth, IndDataMonthly::getValue, (a, b) -> a));

        return currentData.stream().map(m -> {
            CompareDataVO vo = new CompareDataVO();
            vo.setPeriod(m.getTradeMonth());
            vo.setValue(m.getValue());
            BigDecimal compareVal = compareMap.get(m.getTradeMonth());
            vo.setCompareValue(compareVal);
            if (m.getValue() != null && compareVal != null && compareVal.compareTo(BigDecimal.ZERO) != 0) {
                vo.setChangeRate(m.getValue().subtract(compareVal)
                        .multiply(new BigDecimal("100"))
                        .divide(compareVal, 1, RoundingMode.HALF_UP));
            }
            return vo;
        }).collect(Collectors.toList());
    }

    // ─── 排名数据 ────────────────────────────────────
    public List<RankDataVO> getRank(String indicatorCode, String rankBy,
                                     Integer topN, String period, Long tenantId) {
        LocalDate tradeDate = period != null ? LocalDate.parse(period) : LocalDate.now().minusDays(1);
        int limit = topN != null ? topN : 10;

        LambdaQueryWrapper<IndDataDaily> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(IndDataDaily::getIndicatorCode, indicatorCode);
        wrapper.eq(IndDataDaily::getTradeDate, tradeDate);
        if (tenantId != null) wrapper.eq(IndDataDaily::getTenantId, tenantId);
        wrapper.isNotNull(IndDataDaily::getValue);
        wrapper.orderByDesc(IndDataDaily::getValue);
        wrapper.last("LIMIT " + limit);

        List<IndDataDaily> dataList = dailyMapper.selectList(wrapper);

        List<RankDataVO> result = new ArrayList<>();
        int rank = 1;
        for (IndDataDaily d : dataList) {
            RankDataVO vo = new RankDataVO();
            vo.setRank(rank++);
            vo.setEntityName(d.getUnitName() != null ? d.getUnitName() : d.getUnitId());
            vo.setValue(d.getValue());
            result.add(vo);
        }
        return result;
    }

    // ─── 内部工具方法 ────────────────────────────────
    private IndDataDaily getLatestDaily(String indicatorCode, LocalDate tradeDate, Long tenantId) {
        LambdaQueryWrapper<IndDataDaily> w = new LambdaQueryWrapper<>();
        w.eq(IndDataDaily::getIndicatorCode, indicatorCode);
        w.eq(IndDataDaily::getTradeDate, tradeDate);
        if (tenantId != null) w.eq(IndDataDaily::getTenantId, tenantId);
        w.last("LIMIT 1");
        return dailyMapper.selectOne(w);
    }
}
