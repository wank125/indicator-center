package com.qctc.bdss.indicator.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

import java.math.BigDecimal;

@Data
public class MonthlyDataVO {

    private String indicatorCode;

    private String indicatorName;

    private String unitId;

    private String unitName;

    @JsonProperty("month")
    private String tradeMonth;

    private BigDecimal value;

    private BigDecimal yearCumulative;
}
