package com.qctc.bdss.indicator.controller;

import com.qctc.bdss.indicator.dto.R;
import com.qctc.bdss.indicator.dto.request.CalcTriggerReq;
import com.qctc.bdss.indicator.dto.response.CalcResultVO;
import com.qctc.bdss.indicator.entity.CalcTaskLog;
import com.qctc.bdss.indicator.service.IndicatorCalcService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

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
}
