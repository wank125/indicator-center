package com.qctc.bdss.indicator.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;

@Data
public class TimeseriesDataVO {

    private String indicatorCode;

    private String indicatorName;

    private String unitId;

    private String unitName;

    @JsonProperty("date")
    private LocalDate tradeDate;

    private Integer timePoint;

    private BigDecimal value;

    private Integer dataType;
}
