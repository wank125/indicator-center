package com.qctc.bdss.indicator.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

@Data
@TableName("ind_indicator_dimension")
public class IndicatorDimension {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long indicatorId;

    private String indicatorCode;

    private Long dimensionId;

    private String dimType;

    private Integer sortOrder;

    private Long tenantId;
}
