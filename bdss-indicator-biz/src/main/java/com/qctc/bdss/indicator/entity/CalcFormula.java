package com.qctc.bdss.indicator.entity;

import com.baomidou.mybatisplus.annotation.*;
import com.baomidou.mybatisplus.extension.handlers.JacksonTypeHandler;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName(value = "ind_calc_formula", autoResultMap = true)
public class CalcFormula {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long indicatorId;

    private String indicatorCode;

    private Integer formulaType;

    private String formulaExpr;

    @TableField(typeHandler = JacksonTypeHandler.class)
    private String deps;

    private String depCodes;

    private Integer calcOrder;

    private String conditionExpr;

    private String trueValueExpr;

    private String falseValue;

    @TableField(typeHandler = JacksonTypeHandler.class)
    private String yoyMomConfig;

    @TableField(typeHandler = JacksonTypeHandler.class)
    private String aggConfig;

    @TableField(typeHandler = JacksonTypeHandler.class)
    private String rankConfig;

    private Integer status;

    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;

    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updateTime;

    private Long tenantId;

    @TableLogic
    private Integer delFlag;
}
