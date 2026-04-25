package com.qctc.bdss.indicator.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.qctc.bdss.indicator.dto.response.TimeseriesDataVO;
import com.qctc.bdss.indicator.entity.IndDataTimeseries;
import com.qctc.bdss.indicator.entity.IndicatorDef;
import com.qctc.bdss.indicator.mapper.IndDataTimeseriesMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class IndicatorDataService extends ServiceImpl<IndDataTimeseriesMapper, IndDataTimeseries> {

    @Autowired
    private IndicatorDefService indicatorDefService;

    public List<TimeseriesDataVO> getTimeseries(String indicatorCode, String unitId,
                                                  LocalDate startDate, LocalDate endDate, Long tenantId) {
        IndicatorDef def = indicatorDefService.getByCode(indicatorCode, tenantId);
        if (def == null) {
            return Collections.emptyList();
        }

        LambdaQueryWrapper<IndDataTimeseries> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(IndDataTimeseries::getIndicatorCode, indicatorCode);
        if (unitId != null) {
            wrapper.eq(IndDataTimeseries::getUnitId, unitId);
        }
        wrapper.between(IndDataTimeseries::getTradeDate, startDate, endDate);
        if (tenantId != null) {
            wrapper.eq(IndDataTimeseries::getTenantId, tenantId);
        }
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
}
