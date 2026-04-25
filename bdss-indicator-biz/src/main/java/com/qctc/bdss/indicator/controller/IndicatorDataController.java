package com.qctc.bdss.indicator.controller;

import com.qctc.bdss.indicator.dto.R;
import com.qctc.bdss.indicator.dto.response.*;
import com.qctc.bdss.indicator.service.IndicatorDataService;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/qctc/indicator/data")
@RequiredArgsConstructor
public class IndicatorDataController {

    private final IndicatorDataService indicatorDataService;

    @GetMapping("/timeseries")
    public R<List<TimeseriesDataVO>> timeseries(
            @RequestParam String indicatorCode,
            @RequestParam(required = false) String unitId,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate,
            @RequestParam(required = false) Long tenantId) {
        return R.ok(indicatorDataService.getTimeseries(indicatorCode, unitId, startDate, endDate, tenantId));
    }

    @GetMapping("/daily")
    public R<List<DailyDataVO>> daily(
            @RequestParam String indicatorCode,
            @RequestParam(required = false) String unitId,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate,
            @RequestParam(required = false) Long tenantId) {
        return R.ok(indicatorDataService.getDaily(indicatorCode, unitId, startDate, endDate, tenantId));
    }

    @GetMapping("/monthly")
    public R<List<MonthlyDataVO>> monthly(
            @RequestParam String indicatorCode,
            @RequestParam(required = false) String unitId,
            @RequestParam String startMonth,
            @RequestParam String endMonth,
            @RequestParam(required = false) Long tenantId) {
        return R.ok(indicatorDataService.getMonthly(indicatorCode, unitId, startMonth, endMonth, tenantId));
    }

    @GetMapping("/kpi")
    public R<List<KpiDataVO>> kpi(@RequestParam(required = false) Long tenantId) {
        return R.ok(indicatorDataService.getKpi(tenantId));
    }

    @GetMapping("/compare")
    public R<List<CompareDataVO>> compare(
            @RequestParam String indicatorCode,
            @RequestParam(required = false) String unitId,
            @RequestParam(defaultValue = "yoy") String compareType,
            @RequestParam(required = false) Integer periods,
            @RequestParam(required = false) Long tenantId) {
        return R.ok(indicatorDataService.getCompare(indicatorCode, unitId, compareType, periods, tenantId));
    }

    @GetMapping("/rank")
    public R<List<RankDataVO>> rank(
            @RequestParam String indicatorCode,
            @RequestParam(required = false) String rankBy,
            @RequestParam(required = false) Integer topN,
            @RequestParam(required = false) String period,
            @RequestParam(required = false) Long tenantId) {
        return R.ok(indicatorDataService.getRank(indicatorCode, rankBy, topN, period, tenantId));
    }
}
