package com.qctc.bdss.indicator.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@TableName("ind_data_daily")
public class IndDataDaily {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long indicatorId;

    private String indicatorCode;

    private String unitId;

    private String unitName;

    private String plantId;

    private String groupCode;

    private LocalDate tradeDate;

    private BigDecimal value;

    private BigDecimal minValue;

    private BigDecimal maxValue;

    private BigDecimal avgValue;

    private LocalDateTime calcTime;

    private Long tenantId;

    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;
}
