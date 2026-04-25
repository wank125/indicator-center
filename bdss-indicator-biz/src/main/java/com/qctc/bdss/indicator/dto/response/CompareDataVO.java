package com.qctc.bdss.indicator.dto.response;

import lombok.Data;

import java.math.BigDecimal;

@Data
public class CompareDataVO {

    private String period;

    private BigDecimal value;

    private BigDecimal compareValue;

    private BigDecimal changeRate;
}
