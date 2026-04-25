package com.qctc.bdss.indicator.service;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.qctc.bdss.indicator.entity.CalcTaskLog;
import com.qctc.bdss.indicator.mapper.CalcTaskLogMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
public class IndicatorCalcService extends ServiceImpl<CalcTaskLogMapper, CalcTaskLog> {

    public CalcTaskLog triggerCalc(java.time.LocalDate calcDate, String indicatorCode, Long tenantId) {
        log.info("触发计算: date={}, code={}, tenant={}", calcDate, indicatorCode, tenantId);
        // TODO: Sprint 3 实现完整计算链路
        CalcTaskLog taskLog = new CalcTaskLog();
        taskLog.setTaskDate(calcDate);
        taskLog.setTaskType(indicatorCode != null ? 3 : 1);
        taskLog.setTriggerMode(2);
        taskLog.setStatus(1);
        taskLog.setTenantId(tenantId);
        save(taskLog);
        return taskLog;
    }
}
