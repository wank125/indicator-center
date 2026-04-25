package com.qctc.bdss.indicator.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

import java.util.List;

@Data
public class CalcLogVO {

    private List<CalcTaskLogItem> list;

    private long total;

    @Data
    public static class CalcTaskLogItem {
        private Long id;
        private String tradeDate;
        private Long tenantId;
        private Integer totalCount;
        private Integer successCount;
        private Integer failCount;
        private Integer skipCount;
        @JsonProperty("duration")
        private Long durationMs;
        private String status;
        private String createTime;
    }
}
