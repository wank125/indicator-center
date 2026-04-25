package com.qctc.bdss.indicator.dto.response;

import lombok.Data;

@Data
public class CalcResultVO {

    private Long taskId;

    private String status;

    private Integer totalCount;

    private Integer successCount;

    private Integer failCount;

    private Long durationMs;
}
