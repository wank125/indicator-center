package com.qctc.bdss.indicator.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("ind_indicator_def")
public class IndicatorDef {

    @TableId(type = IdType.AUTO)
    private Long id;

    private String indicatorCode;

    private String indicatorName;

    private Integer indicatorType;

    private String subjectType;

    private String marketType;

    private String categoryL1;

    private String categoryL2;

    private String unit;

    private String timeGrain;

    private String dataSource;

    private Integer calcLayer;

    private String description;

    private Integer status;

    @TableField(fill = FieldFill.INSERT)
    private String createBy;

    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;

    private String updateBy;

    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updateTime;

    private Long tenantId;

    @TableLogic
    private Integer delFlag;
}
