package com.qctc.bdss.indicator.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.math.BigDecimal;

@Data
@TableName("ind_dimension_entity")
public class DimensionEntity {

    @TableId(type = IdType.AUTO)
    private Long id;

    private String entityType;

    private String entityCode;

    private String entityName;

    private String parentCode;

    private String provinceCode;

    private BigDecimal ratedCapacity;

    private BigDecimal installedCap;

    private BigDecimal auxRate;

    private Integer sortOrder;

    private Integer status;

    private Long tenantId;

    @TableLogic
    private Integer delFlag;
}
