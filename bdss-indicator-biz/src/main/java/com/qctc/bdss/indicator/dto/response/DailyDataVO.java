package com.qctc.bdss.indicator.dto.response;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;

@Data
public class DailyDataVO {

    private String indicatorCode;

    private String indicatorName;

    private String unitId;

    private String unitName;

    private LocalDate tradeDate;

    private BigDecimal value;

    private BigDecimal minValue;

    private BigDecimal maxValue;

    private BigDecimal avgValue;
}
