package com.qctc.bdss.indicator.dto.request;

import lombok.Data;

import java.time.LocalDate;

@Data
public class CalcTriggerReq {

    private LocalDate calcDate;

    private String indicatorCode;

    private Long tenantId;
}
