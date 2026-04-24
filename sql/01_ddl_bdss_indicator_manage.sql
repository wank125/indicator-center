-- ============================================================
-- 指标中心数据库 DDL
-- Database: bdss_indicator_manage
-- Engine: MySQL 8.0.32
-- Charset: utf8mb4
-- ============================================================

CREATE DATABASE IF NOT EXISTS bdss_indicator_manage
    DEFAULT CHARACTER SET utf8mb4
    DEFAULT COLLATE utf8mb4_general_ci;

USE bdss_indicator_manage;

-- ============================================================
-- 1. 指标定义表
-- ============================================================
CREATE TABLE ind_indicator_def (
    id              BIGINT       NOT NULL AUTO_INCREMENT COMMENT '主键',
    indicator_code  VARCHAR(32)  NOT NULL COMMENT '指标编码，全局唯一，如 DAM_CLEARING_PRICE',
    indicator_name  VARCHAR(64)  NOT NULL COMMENT '指标名称，如 日前出清电价',
    indicator_type  TINYINT      NOT NULL COMMENT '1=原始指标 2=计算指标 3=派生指标',
    subject_type    VARCHAR(16)  NOT NULL COMMENT '所属主体：发电侧/集团公司',
    market_type     VARCHAR(16)  NOT NULL COMMENT '市场类型：中长期/现货/省间/辅助服务/容量/绿色权益/中长期+现货',
    category_l1     VARCHAR(32)  DEFAULT NULL COMMENT '业务一级分类：电量/电价/电费/偏差/边际贡献/成本/负荷率/覆盖率/经营/同比/环比/排名/容量/绿证/绿电',
    category_l2     VARCHAR(32)  DEFAULT NULL COMMENT '业务二级分类：合约/日前/实时/现货/省间/合约差价/对外增收 等',
    unit            VARCHAR(16)  DEFAULT NULL COMMENT '计量单位：元/MWh, MWh, MW, %, 元, h, 个',
    time_grain      VARCHAR(16)  NOT NULL COMMENT '时间粒度：15min/96点/分时/小时/日/月/年/汇总',
    data_source     VARCHAR(32)  DEFAULT NULL COMMENT '数据来源：电力交易中心/集团公司/算法产出/手动维护/需接入绿证系统',
    calc_layer      TINYINT      DEFAULT 0 COMMENT '计算层级 0-9，决定计算顺序',
    description     VARCHAR(256) DEFAULT NULL COMMENT '业务说明',
    status          TINYINT      DEFAULT 1 COMMENT '0=禁用 1=启用',
    create_by       VARCHAR(32)  DEFAULT 'system' COMMENT '创建人',
    create_time     DATETIME     DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_by       VARCHAR(32)  DEFAULT NULL COMMENT '更新人',
    update_time     DATETIME     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    tenant_id       BIGINT       NOT NULL COMMENT '租户ID(省网)',
    del_flag        TINYINT      DEFAULT 0 COMMENT '0=正常 1=删除',
    PRIMARY KEY (id),
    UNIQUE KEY uk_code_tenant (indicator_code, tenant_id),
    KEY idx_market (market_type, tenant_id),
    KEY idx_category (category_l1, category_l2),
    KEY idx_layer (calc_layer),
    KEY idx_type (indicator_type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='指标定义表';

-- ============================================================
-- 2. 数据源映射表
-- ============================================================
CREATE TABLE ind_data_source (
    id              BIGINT       NOT NULL AUTO_INCREMENT COMMENT '主键',
    indicator_id    BIGINT       NOT NULL COMMENT '指标定义ID',
    indicator_code  VARCHAR(32)  NOT NULL COMMENT '指标编码(冗余)',
    source_type     TINYINT      NOT NULL COMMENT '1=数据库直连 2=Feign接口 3=算法服务 4=手动录入 5=外部系统',
    source_db       VARCHAR(64)  DEFAULT NULL COMMENT '源数据库，如 bdss_spot_market',
    source_table    VARCHAR(64)  DEFAULT NULL COMMENT '源表名，如 spot_ahead_trade',
    source_field    VARCHAR(64)  DEFAULT NULL COMMENT '源字段，如 price',
    filter_condition TEXT        DEFAULT NULL COMMENT '过滤条件JSON，如 {"object_type":"竞价空间"}',
    join_config     JSON         DEFAULT NULL COMMENT '关联配置，支持多表JOIN',
    field_mapping   JSON         DEFAULT NULL COMMENT '字段映射配置 {srcField: "price", targetField: "value"}',
    date_field      VARCHAR(32)  DEFAULT NULL COMMENT '日期字段名',
    time_field      VARCHAR(32)  DEFAULT NULL COMMENT '时间点字段名',
    tenant_field    VARCHAR(32)  DEFAULT 'tenant_id' COMMENT '租户字段名',
    test_sql        TEXT         DEFAULT NULL COMMENT '测试SQL',
    status          TINYINT      DEFAULT 1 COMMENT '0=禁用 1=启用',
    create_time     DATETIME     DEFAULT CURRENT_TIMESTAMP,
    update_time     DATETIME     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    tenant_id       BIGINT       NOT NULL,
    del_flag        TINYINT      DEFAULT 0,
    PRIMARY KEY (id),
    UNIQUE KEY uk_indicator_source (indicator_id, source_type),
    KEY idx_code (indicator_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='数据源映射表';

-- ============================================================
-- 3. 计算公式表
-- ============================================================
CREATE TABLE ind_calc_formula (
    id              BIGINT       NOT NULL AUTO_INCREMENT COMMENT '主键',
    indicator_id    BIGINT       NOT NULL COMMENT '目标指标ID',
    indicator_code  VARCHAR(32)  NOT NULL COMMENT '目标指标编码(冗余)',
    formula_type    TINYINT      NOT NULL COMMENT '1=四则运算 2=条件分支 3=聚合汇总 4=同环比 5=排名',
    formula_expr    TEXT         NOT NULL COMMENT '公式表达式',
    deps            JSON         DEFAULT NULL COMMENT '依赖指标编码列表',
    dep_codes       VARCHAR(512) DEFAULT NULL COMMENT '依赖指标编码逗号分隔(便于查询)',
    calc_order      INT          DEFAULT 0 COMMENT '同层级内的计算顺序',
    condition_expr  TEXT         DEFAULT NULL COMMENT 'IF条件表达式',
    true_value_expr TEXT         DEFAULT NULL COMMENT '条件为真时的计算表达式',
    false_value     VARCHAR(32)  DEFAULT '0' COMMENT '条件为假时的值',
    yoy_mom_config  JSON         DEFAULT NULL COMMENT '同环比配置 {"baseCode":"ONLINE_ENERGY","compareType":"YOY","offset":-365}',
    agg_config      JSON         DEFAULT NULL COMMENT '聚合配置 {"func":"SUM","groupFields":["unit_id"],"timeGrain":"daily"}',
    rank_config     JSON         DEFAULT NULL COMMENT '排名配置 {"topN":10,"order":"DESC","groupBy":"group_company,plant,unit"}',
    status          TINYINT      DEFAULT 1,
    create_time     DATETIME     DEFAULT CURRENT_TIMESTAMP,
    update_time     DATETIME     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    tenant_id       BIGINT       NOT NULL,
    del_flag        TINYINT      DEFAULT 0,
    PRIMARY KEY (id),
    UNIQUE KEY uk_indicator_formula (indicator_id),
    KEY idx_code (indicator_code),
    KEY idx_type (formula_type),
    KEY idx_deps (dep_codes(255))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='计算公式表';

-- ============================================================
-- 4. 分时指标数据表（按月分区）
-- ============================================================
CREATE TABLE ind_data_timeseries (
    id              BIGINT       NOT NULL AUTO_INCREMENT COMMENT '主键',
    indicator_id    BIGINT       NOT NULL COMMENT '指标ID',
    indicator_code  VARCHAR(32)  NOT NULL COMMENT '指标编码(冗余)',
    unit_id         VARCHAR(32)  DEFAULT NULL COMMENT '机组/电厂/交易单元编码',
    unit_name       VARCHAR(64)  DEFAULT NULL COMMENT '机组名称(冗余)',
    plant_id        VARCHAR(32)  DEFAULT NULL COMMENT '电厂编码',
    group_code      VARCHAR(32)  DEFAULT NULL COMMENT '二级公司编码',
    trade_date      DATE         NOT NULL COMMENT '交易日期',
    time_point      SMALLINT     NOT NULL COMMENT '时间点(1-96), 日/月粒度填0',
    value           DECIMAL(18,4) DEFAULT NULL COMMENT '指标值',
    data_type       TINYINT      DEFAULT 1 COMMENT '1=实际 2=预测 3=计划',
    calc_time       DATETIME     DEFAULT NULL COMMENT '计算完成时间',
    data_status     TINYINT      DEFAULT 1 COMMENT '1=正常 2=待确认 3=异常',
    tenant_id       BIGINT       NOT NULL,
    create_time     DATETIME     DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id, trade_date),
    UNIQUE KEY uk_data (indicator_code, unit_id, trade_date, time_point, data_type, tenant_id),
    KEY idx_date (trade_date),
    KEY idx_indicator_date (indicator_code, trade_date),
    KEY idx_unit_date (unit_id, trade_date),
    KEY idx_plant_date (plant_id, trade_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='分时指标数据表'
PARTITION BY RANGE (TO_DAYS(trade_date)) (
    PARTITION p202601 VALUES LESS THAN (TO_DAYS('2026-02-01')),
    PARTITION p202602 VALUES LESS THAN (TO_DAYS('2026-03-01')),
    PARTITION p202603 VALUES LESS THAN (TO_DAYS('2026-04-01')),
    PARTITION p202604 VALUES LESS THAN (TO_DAYS('2026-05-01')),
    PARTITION p202605 VALUES LESS THAN (TO_DAYS('2026-06-01')),
    PARTITION p202606 VALUES LESS THAN (TO_DAYS('2026-07-01')),
    PARTITION p202607 VALUES LESS THAN (TO_DAYS('2026-08-01')),
    PARTITION p202608 VALUES LESS THAN (TO_DAYS('2026-09-01')),
    PARTITION p202609 VALUES LESS THAN (TO_DAYS('2026-10-01')),
    PARTITION p202610 VALUES LESS THAN (TO_DAYS('2026-11-01')),
    PARTITION p202611 VALUES LESS THAN (TO_DAYS('2026-12-01')),
    PARTITION p202612 VALUES LESS THAN (TO_DAYS('2027-01-01')),
    PARTITION p202701 VALUES LESS THAN (TO_DAYS('2027-02-01')),
    PARTITION p_future VALUES LESS THAN MAXVALUE
);

-- ============================================================
-- 5. 日维度指标数据表
-- ============================================================
CREATE TABLE ind_data_daily (
    id              BIGINT       NOT NULL AUTO_INCREMENT COMMENT '主键',
    indicator_id    BIGINT       NOT NULL COMMENT '指标ID',
    indicator_code  VARCHAR(32)  NOT NULL COMMENT '指标编码(冗余)',
    unit_id         VARCHAR(32)  DEFAULT NULL COMMENT '机组编码',
    unit_name       VARCHAR(64)  DEFAULT NULL,
    plant_id        VARCHAR(32)  DEFAULT NULL COMMENT '电厂编码',
    group_code      VARCHAR(32)  DEFAULT NULL COMMENT '二级公司编码',
    trade_date      DATE         NOT NULL COMMENT '交易日期',
    value           DECIMAL(18,4) DEFAULT NULL COMMENT '日汇总值',
    min_value       DECIMAL(18,4) DEFAULT NULL COMMENT '日最小值',
    max_value       DECIMAL(18,4) DEFAULT NULL COMMENT '日最大值',
    avg_value       DECIMAL(18,4) DEFAULT NULL COMMENT '日平均值',
    calc_time       DATETIME     DEFAULT NULL,
    tenant_id       BIGINT       NOT NULL,
    create_time     DATETIME     DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uk_data (indicator_code, unit_id, trade_date, tenant_id),
    KEY idx_date (trade_date),
    KEY idx_indicator_date (indicator_code, trade_date),
    KEY idx_plant_date (plant_id, trade_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='日维度指标数据表';

-- ============================================================
-- 6. 月维度指标数据表
-- ============================================================
CREATE TABLE ind_data_monthly (
    id              BIGINT       NOT NULL AUTO_INCREMENT COMMENT '主键',
    indicator_id    BIGINT       NOT NULL COMMENT '指标ID',
    indicator_code  VARCHAR(32)  NOT NULL COMMENT '指标编码(冗余)',
    unit_id         VARCHAR(32)  DEFAULT NULL COMMENT '机组编码',
    unit_name       VARCHAR(64)  DEFAULT NULL,
    plant_id        VARCHAR(32)  DEFAULT NULL,
    group_code      VARCHAR(32)  DEFAULT NULL,
    trade_month     VARCHAR(7)   NOT NULL COMMENT '月份 yyyy-MM',
    value           DECIMAL(18,4) DEFAULT NULL COMMENT '月汇总值',
    year_cumulative DECIMAL(18,4) DEFAULT NULL COMMENT '年累计值',
    calc_time       DATETIME     DEFAULT NULL,
    tenant_id       BIGINT       NOT NULL,
    create_time     DATETIME     DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uk_data (indicator_code, unit_id, trade_month, tenant_id),
    KEY idx_month (trade_month),
    KEY idx_indicator_month (indicator_code, trade_month)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='月维度指标数据表';

-- ============================================================
-- 7. 维度定义表（多维度分类）
-- ============================================================
CREATE TABLE ind_dimension (
    id              BIGINT       NOT NULL AUTO_INCREMENT COMMENT '主键',
    dim_type        VARCHAR(16)  NOT NULL COMMENT '维度类型: BUSINESS=业务域 / MARKET=市场类型 / SUBJECT=主体层级',
    dim_code        VARCHAR(32)  NOT NULL COMMENT '维度编码',
    dim_name        VARCHAR(32)  NOT NULL COMMENT '维度名称',
    parent_id       BIGINT       DEFAULT NULL COMMENT '父维度ID(树形结构)',
    parent_code     VARCHAR(32)  DEFAULT NULL COMMENT '父维度编码',
    level_num       TINYINT      DEFAULT 1 COMMENT '层级号 1/2/3',
    sort_order      INT          DEFAULT 0 COMMENT '排序号',
    icon            VARCHAR(32)  DEFAULT NULL COMMENT '图标',
    status          TINYINT      DEFAULT 1,
    create_time     DATETIME     DEFAULT CURRENT_TIMESTAMP,
    update_time     DATETIME     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    tenant_id       BIGINT       NOT NULL,
    del_flag        TINYINT      DEFAULT 0,
    PRIMARY KEY (id),
    UNIQUE KEY uk_dim (dim_type, dim_code, tenant_id),
    KEY idx_parent (parent_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='维度定义表';

-- ============================================================
-- 8. 指标-维度关联表（多对多）
-- ============================================================
CREATE TABLE ind_indicator_dimension (
    id              BIGINT       NOT NULL AUTO_INCREMENT COMMENT '主键',
    indicator_id    BIGINT       NOT NULL COMMENT '指标ID',
    indicator_code  VARCHAR(32)  NOT NULL COMMENT '指标编码(冗余)',
    dimension_id    BIGINT       NOT NULL COMMENT '维度ID',
    dim_type        VARCHAR(16)  NOT NULL COMMENT '维度类型(冗余)',
    sort_order      INT          DEFAULT 0,
    tenant_id       BIGINT       NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uk_rel (indicator_id, dimension_id),
    KEY idx_dim (dimension_id),
    KEY idx_dim_type (dim_type, dimension_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='指标-维度多对多关联表';

-- ============================================================
-- 9. 计算任务日志表
-- ============================================================
CREATE TABLE ind_calc_task_log (
    id              BIGINT       NOT NULL AUTO_INCREMENT COMMENT '主键',
    task_date       DATE         NOT NULL COMMENT '计算目标日期',
    task_type       TINYINT      NOT NULL COMMENT '1=定时全量 2=手动触发 3=单指标重算',
    status          TINYINT      NOT NULL COMMENT '1=运行中 2=成功 3=失败 4=部分失败',
    trigger_mode    TINYINT      DEFAULT 1 COMMENT '1=自动 2=手动',
    total_count     INT          DEFAULT 0 COMMENT '总指标数',
    success_count   INT          DEFAULT 0 COMMENT '成功数',
    fail_count      INT          DEFAULT 0 COMMENT '失败数',
    skip_count      INT          DEFAULT 0 COMMENT '跳过数',
    start_time      DATETIME     DEFAULT NULL COMMENT '开始时间',
    end_time        DATETIME     DEFAULT NULL COMMENT '结束时间',
    duration_ms     BIGINT       DEFAULT NULL COMMENT '耗时(毫秒)',
    error_detail    TEXT         DEFAULT NULL COMMENT '错误详情',
    tenant_id       BIGINT       NOT NULL,
    create_time     DATETIME     DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    KEY idx_date (task_date),
    KEY idx_status (status, task_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='计算任务日志表';

-- ============================================================
-- 10. 指标计算明细日志表
-- ============================================================
CREATE TABLE ind_calc_detail_log (
    id              BIGINT       NOT NULL AUTO_INCREMENT COMMENT '主键',
    task_id         BIGINT       NOT NULL COMMENT '任务ID',
    indicator_code  VARCHAR(32)  NOT NULL COMMENT '指标编码',
    calc_layer      TINYINT      DEFAULT NULL COMMENT '计算层级',
    status          TINYINT      NOT NULL COMMENT '1=成功 2=失败 3=跳过 4=无数据',
    rows_affected   INT          DEFAULT 0 COMMENT '影响行数',
    duration_ms     BIGINT       DEFAULT NULL COMMENT '耗时(毫秒)',
    error_msg       VARCHAR(512) DEFAULT NULL COMMENT '错误信息',
    calc_sql        TEXT         DEFAULT NULL COMMENT '执行SQL(调试用)',
    tenant_id       BIGINT       NOT NULL,
    create_time     DATETIME     DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    KEY idx_task (task_id),
    KEY idx_code (indicator_code, task_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='指标计算明细日志表';

-- ============================================================
-- 11. 维度实体表（省网/二级公司/电厂/机组）
-- ============================================================
CREATE TABLE ind_dimension_entity (
    id              BIGINT       NOT NULL AUTO_INCREMENT COMMENT '主键',
    entity_type     VARCHAR(16)  NOT NULL COMMENT '实体类型: PROVINCE/GROUP_COMPANY/PLANT/UNIT',
    entity_code     VARCHAR(32)  NOT NULL COMMENT '实体编码',
    entity_name     VARCHAR(64)  NOT NULL COMMENT '实体名称',
    parent_code     VARCHAR(32)  DEFAULT NULL COMMENT '上级编码',
    province_code   VARCHAR(8)   DEFAULT NULL COMMENT '省网编码(SX/HA/HB/MX/MD/NX/GS/SN/YN/GX)',
    rated_capacity  DECIMAL(10,2) DEFAULT NULL COMMENT '额定容量(MW)',
    installed_cap   DECIMAL(10,2) DEFAULT NULL COMMENT '装机容量(MW)',
    aux_rate        DECIMAL(5,4) DEFAULT NULL COMMENT '厂用电率',
    sort_order      INT          DEFAULT 0,
    status          TINYINT      DEFAULT 1,
    tenant_id       BIGINT       NOT NULL,
    del_flag        TINYINT      DEFAULT 0,
    PRIMARY KEY (id),
    UNIQUE KEY uk_entity (entity_type, entity_code, tenant_id),
    KEY idx_parent (parent_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='维度实体表(省网/公司/电厂/机组)';
