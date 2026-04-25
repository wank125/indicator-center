package com.qctc.bdss.indicator.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.qctc.bdss.indicator.dto.response.CalcDetailVO;
import com.qctc.bdss.indicator.dto.response.CalcLogVO;
import com.qctc.bdss.indicator.entity.CalcDetailLog;
import com.qctc.bdss.indicator.entity.CalcTaskLog;
import com.qctc.bdss.indicator.entity.IndicatorDef;
import com.qctc.bdss.indicator.mapper.CalcDetailLogMapper;
import com.qctc.bdss.indicator.mapper.CalcTaskLogMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

@Slf4j
@Service
public class IndicatorCalcService extends ServiceImpl<CalcTaskLogMapper, CalcTaskLog> {

    @Autowired
    private CalcDetailLogMapper detailLogMapper;

    @Autowired
    private IndicatorDefService indicatorDefService;

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

    public CalcLogVO getCalcLog(Long tenantId, Integer page, Integer size) {
        LambdaQueryWrapper<CalcTaskLog> wrapper = new LambdaQueryWrapper<>();
        if (tenantId != null) wrapper.eq(CalcTaskLog::getTenantId, tenantId);
        wrapper.orderByDesc(CalcTaskLog::getCreateTime);

        Page<CalcTaskLog> pageResult = page(new Page<>(page, size), wrapper);

        CalcLogVO vo = new CalcLogVO();
        vo.setTotal(pageResult.getTotal());
        DateTimeFormatter fmt = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        vo.setList(pageResult.getRecords().stream().map(t -> {
            CalcLogVO.CalcTaskLogItem item = new CalcLogVO.CalcTaskLogItem();
            item.setId(t.getId());
            item.setTradeDate(t.getTaskDate() != null ? t.getTaskDate().toString() : null);
            item.setTenantId(t.getTenantId());
            item.setTotalCount(t.getTotalCount());
            item.setSuccessCount(t.getSuccessCount());
            item.setFailCount(t.getFailCount());
            item.setSkipCount(t.getSkipCount());
            item.setDurationMs(t.getDurationMs());
            item.setStatus(t.getStatus() != null ? statusLabel(t.getStatus()) : null);
            item.setCreateTime(t.getCreateTime() != null ? t.getCreateTime().format(fmt) : null);
            return item;
        }).collect(Collectors.toList()));
        return vo;
    }

    public List<CalcDetailVO> getCalcDetail(Long taskId) {
        LambdaQueryWrapper<CalcDetailLog> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(CalcDetailLog::getTaskId, taskId);
        wrapper.orderByAsc(CalcDetailLog::getCalcLayer);

        List<CalcDetailLog> details = detailLogMapper.selectList(wrapper);

        // 批量查指标名
        List<String> codes = details.stream()
                .map(CalcDetailLog::getIndicatorCode)
                .filter(Objects::nonNull)
                .distinct()
                .collect(Collectors.toList());
        Map<String, String> nameMap = codes.stream()
                .map(code -> indicatorDefService.getByCode(code, null))
                .filter(Objects::nonNull)
                .collect(Collectors.toMap(IndicatorDef::getIndicatorCode, IndicatorDef::getIndicatorName, (a, b) -> a));

        return details.stream().map(d -> {
            CalcDetailVO vo = new CalcDetailVO();
            vo.setId(d.getId());
            vo.setTaskId(d.getTaskId());
            vo.setIndicatorCode(d.getIndicatorCode());
            vo.setIndicatorName(nameMap.getOrDefault(d.getIndicatorCode(), d.getIndicatorCode()));
            vo.setCalcLayer(d.getCalcLayer());
            vo.setStatus(d.getStatus() != null ? statusLabel(d.getStatus()) : null);
            vo.setRowsAffected(d.getRowsAffected());
            vo.setDurationMs(d.getDurationMs());
            vo.setErrorMsg(d.getErrorMsg());
            return vo;
        }).collect(Collectors.toList());
    }

    private String statusLabel(int status) {
        switch (status) {
            case 0: return "PENDING";
            case 1: return "RUNNING";
            case 2: return "SUCCESS";
            case 3: return "FAILED";
            case 4: return "SKIPPED";
            default: return "UNKNOWN";
        }
    }
}
