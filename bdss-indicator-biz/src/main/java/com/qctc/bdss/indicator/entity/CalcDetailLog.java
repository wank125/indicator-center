package com.qctc.bdss.indicator.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("ind_calc_detail_log")
public class CalcDetailLog {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long taskId;

    private String indicatorCode;

    private Integer calcLayer;

    private Integer status;

    private Integer rowsAffected;

    private Long durationMs;

    private String errorMsg;

    private String calcSql;

    private Long tenantId;

    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;
}
