package com.qctc.bdss.indicator.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("ind_dimension")
public class Dimension {

    @TableId(type = IdType.AUTO)
    private Long id;

    private String dimType;

    private String dimCode;

    private String dimName;

    private Long parentId;

    private String parentCode;

    private Integer levelNum;

    private Integer sortOrder;

    private String icon;

    private Integer status;

    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;

    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updateTime;

    private Long tenantId;

    @TableLogic
    private Integer delFlag;
}
