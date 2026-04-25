package com.qctc.bdss.indicator.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.qctc.bdss.indicator.entity.IndDataTimeseries;
import com.qctc.bdss.indicator.mapper.IndDataTimeseriesMapper;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
public class IndicatorDataService extends ServiceImpl<IndDataTimeseriesMapper, IndDataTimeseries> {

    public List<IndDataTimeseries> getTimeseries(String indicatorCode, String unitId,
                                                  LocalDate startDate, LocalDate endDate, Long tenantId) {
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
        return list(wrapper);
    }
}
