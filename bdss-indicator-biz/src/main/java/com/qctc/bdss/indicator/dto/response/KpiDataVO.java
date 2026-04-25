package com.qctc.bdss.indicator.dto.response;

import lombok.Data;

import java.math.BigDecimal;

@Data
public class KpiDataVO {

    private String code;

    private String label;

    private BigDecimal value;

    private String unit;

    /** 同比/环比变化率 */
    private BigDecimal changeRate;

    /** yoy=同比 mom=环比 */
    private String changeType;

    /** up/down/flat */
    private String changeDirection;
}
