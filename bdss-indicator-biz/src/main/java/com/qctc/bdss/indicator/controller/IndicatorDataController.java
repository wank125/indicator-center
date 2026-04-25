package com.qctc.bdss.indicator.controller;

import com.qctc.bdss.indicator.dto.R;
import com.qctc.bdss.indicator.dto.response.TimeseriesDataVO;
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
}
