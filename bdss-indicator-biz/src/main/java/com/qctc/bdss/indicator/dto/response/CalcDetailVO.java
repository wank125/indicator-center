package com.qctc.bdss.indicator.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

@Data
public class CalcDetailVO {

    private Long id;

    private Long taskId;

    private String indicatorCode;

    private String indicatorName;

    private Integer calcLayer;

    private String status;

    @JsonProperty("affectedRows")
    private Integer rowsAffected;

    @JsonProperty("duration")
    private Long durationMs;

    private String errorMsg;
}
