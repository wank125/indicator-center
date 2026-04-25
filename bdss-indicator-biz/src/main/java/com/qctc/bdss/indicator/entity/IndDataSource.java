package com.qctc.bdss.indicator.entity;

import com.baomidou.mybatisplus.annotation.*;
import com.baomidou.mybatisplus.extension.handlers.JacksonTypeHandler;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName(value = "ind_data_source", autoResultMap = true)
public class IndDataSource {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long indicatorId;

    private String indicatorCode;

    private Integer sourceType;

    private String sourceDb;

    private String sourceTable;

    private String sourceField;

    private String filterCondition;

    @TableField(typeHandler = JacksonTypeHandler.class)
    private String joinConfig;

    @TableField(typeHandler = JacksonTypeHandler.class)
    private String fieldMapping;

    private String dateField;

    private String timeField;

    private String tenantField;

    private String testSql;

    private Integer status;

    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;

    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updateTime;

    private Long tenantId;

    @TableLogic
    private Integer delFlag;
}
