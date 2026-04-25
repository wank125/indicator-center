package com.qctc.bdss.indicator.controller;

import com.qctc.bdss.indicator.dto.R;
import com.qctc.bdss.indicator.dto.request.CalcTriggerReq;
import com.qctc.bdss.indicator.dto.response.CalcDetailVO;
import com.qctc.bdss.indicator.dto.response.CalcLogVO;
import com.qctc.bdss.indicator.dto.response.CalcResultVO;
import com.qctc.bdss.indicator.entity.CalcTaskLog;
import com.qctc.bdss.indicator.service.IndicatorCalcService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/qctc/indicator/calc")
@RequiredArgsConstructor
public class IndicatorCalcController {

    private final IndicatorCalcService indicatorCalcService;

    @PostMapping("/trigger")
    public R<CalcResultVO> trigger(@RequestBody CalcTriggerReq req) {
        CalcTaskLog taskLog = indicatorCalcService.triggerCalc(
                req.getCalcDate(), req.getIndicatorCode(), req.getTenantId());
        CalcResultVO vo = new CalcResultVO();
        vo.setTaskId(taskLog.getId());
        vo.setStatus("RUNNING");
        return R.ok(vo);
    }

    @GetMapping("/status/{taskId}")
    public R<CalcTaskLog> status(@PathVariable Long taskId) {
        return R.ok(indicatorCalcService.getById(taskId));
    }

    @GetMapping("/log")
    public R<CalcLogVO> log(
            @RequestParam(required = false) Long tenantId,
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "20") Integer size) {
        return R.ok(indicatorCalcService.getCalcLog(tenantId, page, size));
    }

    @GetMapping("/log/{taskId}/detail")
    public R<List<CalcDetailVO>> detail(@PathVariable Long taskId) {
        return R.ok(indicatorCalcService.getCalcDetail(taskId));
    }
}
