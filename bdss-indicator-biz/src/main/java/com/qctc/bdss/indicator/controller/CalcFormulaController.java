package com.qctc.bdss.indicator.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.qctc.bdss.indicator.dto.R;
import com.qctc.bdss.indicator.entity.CalcFormula;
import com.qctc.bdss.indicator.mapper.CalcFormulaMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/qctc/indicator/formula")
@RequiredArgsConstructor
public class CalcFormulaController {

    private final CalcFormulaMapper calcFormulaMapper;

    @GetMapping("/list")
    public R<List<CalcFormula>> list(@RequestParam(required = false) String indicatorCode) {
        LambdaQueryWrapper<CalcFormula> wrapper = new LambdaQueryWrapper<CalcFormula>()
                .eq(indicatorCode != null, CalcFormula::getIndicatorCode, indicatorCode)
                .orderByAsc(CalcFormula::getCalcOrder);
        return R.ok(calcFormulaMapper.selectList(wrapper));
    }

    @GetMapping("/{id}")
    public R<CalcFormula> getById(@PathVariable Long id) {
        return R.ok(calcFormulaMapper.selectById(id));
    }

    @GetMapping("/code/{indicatorCode}")
    public R<CalcFormula> getByCode(@PathVariable String indicatorCode) {
        LambdaQueryWrapper<CalcFormula> wrapper = new LambdaQueryWrapper<CalcFormula>()
                .eq(CalcFormula::getIndicatorCode, indicatorCode);
        return R.ok(calcFormulaMapper.selectOne(wrapper));
    }

    @PostMapping
    public R<Void> save(@RequestBody CalcFormula formula) {
        calcFormulaMapper.insert(formula);
        return R.ok();
    }

    @PutMapping("/{id}")
    public R<Void> update(@PathVariable Long id, @RequestBody CalcFormula formula) {
        formula.setId(id);
        calcFormulaMapper.updateById(formula);
        return R.ok();
    }

    @DeleteMapping("/{id}")
    public R<Void> delete(@PathVariable Long id) {
        calcFormulaMapper.deleteById(id);
        return R.ok();
    }

    @PostMapping("/validate")
    public R<Boolean> validate(@RequestBody CalcFormula formula) {
        return R.ok(true);
    }
}
