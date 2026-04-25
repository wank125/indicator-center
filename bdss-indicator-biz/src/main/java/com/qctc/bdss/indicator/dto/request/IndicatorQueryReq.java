package com.qctc.bdss.indicator.dto.request;

import lombok.Data;

@Data
public class IndicatorQueryReq {

    private String indicatorCode;

    private String indicatorName;

    private String marketType;

    private String categoryL1;

    private String categoryL2;

    private Integer indicatorType;

    private Integer calcLayer;

    private Integer status;

    private Long tenantId;

    private Integer pageNum = 1;

    private Integer pageSize = 20;
}
