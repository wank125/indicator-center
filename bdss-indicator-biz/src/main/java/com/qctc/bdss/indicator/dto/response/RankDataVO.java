package com.qctc.bdss.indicator.dto.response;

import lombok.Data;

import java.math.BigDecimal;

@Data
public class RankDataVO {

    private Integer rank;

    private String entityName;

    private BigDecimal value;

    private String changeDirection;
}
