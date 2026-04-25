package com.qctc.bdss.indicator.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@TableName("ind_data_monthly")
public class IndDataMonthly {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long indicatorId;

    private String indicatorCode;

    private String unitId;

    private String unitName;

    private String plantId;

    private String groupCode;

    private String tradeMonth;

    private BigDecimal value;

    private BigDecimal yearCumulative;

    private LocalDateTime calcTime;

    private Long tenantId;

    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;
}
