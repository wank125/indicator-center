-- ============================================================
-- 指标中心数据库 DDL
-- Database: bdss_indicator_manage
-- Engine: PostgreSQL
-- ============================================================

CREATE DATABASE bdss_indicator_manage
    ENCODING 'UTF8'
    LC_COLLATE = 'zh_CN.UTF-8'
    LC_CTYPE = 'zh_CN.UTF-8'
    TEMPLATE template0;

\c bdss_indicator_manage;

-- ============================================================
-- 通用触发器函数：自动更新 update_time 字段
-- ============================================================
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.update_time = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- ============================================================
-- 1. 指标定义表
-- ============================================================
CREATE TABLE ind_indicator_def (
    id              BIGINT       NOT NULL GENERATED ALWAYS AS IDENTITY,
    indicator_code  VARCHAR(32)  NOT NULL,
    indicator_name  VARCHAR(64)  NOT NULL,
    indicator_type  SMALLINT     NOT NULL,
    subject_type    VARCHAR(16)  NOT NULL,
    market_type     VARCHAR(16)  NOT NULL,
    category_l1     VARCHAR(32)  DEFAULT NULL,
    category_l2     VARCHAR(32)  DEFAULT NULL,
    unit            VARCHAR(16)  DEFAULT NULL,
    time_grain      VARCHAR(16)  NOT NULL,
    data_source     VARCHAR(32)  DEFAULT NULL,
    calc_layer      SMALLINT     DEFAULT 0,
    description     VARCHAR(256) DEFAULT NULL,
    status          SMALLINT     DEFAULT 1,
    create_by       VARCHAR(32)  DEFAULT 'system',
    create_time     TIMESTAMPTZ  DEFAULT CURRENT_TIMESTAMP,
    update_by       VARCHAR(32)  DEFAULT NULL,
    update_time     TIMESTAMPTZ  DEFAULT CURRENT_TIMESTAMP,
    tenant_id       BIGINT       NOT NULL,
    del_flag        SMALLINT     DEFAULT 0,
    PRIMARY KEY (id),
    CONSTRAINT uk_code_tenant UNIQUE (indicator_code, tenant_id)
);

CREATE INDEX idx_indicator_def_market ON ind_indicator_def (market_type, tenant_id);
CREATE INDEX idx_indicator_def_category ON ind_indicator_def (category_l1, category_l2);
CREATE INDEX idx_indicator_def_layer ON ind_indicator_def (calc_layer);
CREATE INDEX idx_indicator_def_type ON ind_indicator_def (indicator_type);

CREATE TRIGGER trg_ind_indicator_def_update_time
    BEFORE UPDATE ON ind_indicator_def
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

COMMENT ON TABLE ind_indicator_def IS '指标定义表';
COMMENT ON COLUMN ind_indicator_def.id IS '主键';
COMMENT ON COLUMN ind_indicator_def.indicator_code IS '指标编码，全局唯一，如 DAM_CLEARING_PRICE';
COMMENT ON COLUMN ind_indicator_def.indicator_name IS '指标名称，如 日前出清电价';
COMMENT ON COLUMN ind_indicator_def.indicator_type IS '1=原始指标 2=计算指标 3=派生指标';
COMMENT ON COLUMN ind_indicator_def.subject_type IS '所属主体：发电侧/集团公司';
COMMENT ON COLUMN ind_indicator_def.market_type IS '市场类型：中长期/现货/省间/辅助服务/容量/绿色权益/中长期+现货';
COMMENT ON COLUMN ind_indicator_def.category_l1 IS '业务一级分类：电量/电价/电费/偏差/边际贡献/成本/负荷率/覆盖率/经营/同比/环比/排名/容量/绿证/绿电';
COMMENT ON COLUMN ind_indicator_def.category_l2 IS '业务二级分类：合约/日前/实时/现货/省间/合约差价/对外增收 等';
COMMENT ON COLUMN ind_indicator_def.unit IS '计量单位：元/MWh, MWh, MW, %, 元, h, 个';
COMMENT ON COLUMN ind_indicator_def.time_grain IS '时间粒度：15min/96点/分时/小时/日/月/年/汇总';
COMMENT ON COLUMN ind_indicator_def.data_source IS '数据来源：电力交易中心/集团公司/算法产出/手动维护/需接入绿证系统';
COMMENT ON COLUMN ind_indicator_def.calc_layer IS '计算层级 0-9，决定计算顺序';
COMMENT ON COLUMN ind_indicator_def.description IS '业务说明';
COMMENT ON COLUMN ind_indicator_def.status IS '0=禁用 1=启用';
COMMENT ON COLUMN ind_indicator_def.create_by IS '创建人';
COMMENT ON COLUMN ind_indicator_def.create_time IS '创建时间';
COMMENT ON COLUMN ind_indicator_def.update_by IS '更新人';
COMMENT ON COLUMN ind_indicator_def.update_time IS '更新时间';
COMMENT ON COLUMN ind_indicator_def.tenant_id IS '租户ID(省网)';
COMMENT ON COLUMN ind_indicator_def.del_flag IS '0=正常 1=删除';

-- ============================================================
-- 2. 数据源映射表
-- ============================================================
CREATE TABLE ind_data_source (
    id              BIGINT       NOT NULL GENERATED ALWAYS AS IDENTITY,
    indicator_id    BIGINT       NOT NULL,
    indicator_code  VARCHAR(32)  NOT NULL,
    source_type     SMALLINT     NOT NULL,
    source_db       VARCHAR(64)  DEFAULT NULL,
    source_table    VARCHAR(64)  DEFAULT NULL,
    source_field    VARCHAR(64)  DEFAULT NULL,
    filter_condition TEXT        DEFAULT NULL,
    join_config     JSONB        DEFAULT NULL,
    field_mapping   JSONB        DEFAULT NULL,
    date_field      VARCHAR(32)  DEFAULT NULL,
    time_field      VARCHAR(32)  DEFAULT NULL,
    tenant_field    VARCHAR(32)  DEFAULT 'tenant_id',
    test_sql        TEXT         DEFAULT NULL,
    status          SMALLINT     DEFAULT 1,
    create_time     TIMESTAMPTZ  DEFAULT CURRENT_TIMESTAMP,
    update_time     TIMESTAMPTZ  DEFAULT CURRENT_TIMESTAMP,
    tenant_id       BIGINT       NOT NULL,
    del_flag        SMALLINT     DEFAULT 0,
    PRIMARY KEY (id),
    CONSTRAINT uk_indicator_source UNIQUE (indicator_id, source_type)
);

CREATE INDEX idx_data_source_code ON ind_data_source (indicator_code);

CREATE TRIGGER trg_ind_data_source_update_time
    BEFORE UPDATE ON ind_data_source
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

COMMENT ON TABLE ind_data_source IS '数据源映射表';
COMMENT ON COLUMN ind_data_source.id IS '主键';
COMMENT ON COLUMN ind_data_source.indicator_id IS '指标定义ID';
COMMENT ON COLUMN ind_data_source.indicator_code IS '指标编码(冗余)';
COMMENT ON COLUMN ind_data_source.source_type IS '1=数据库直连 2=Feign接口 3=算法服务 4=手动录入 5=外部系统';
COMMENT ON COLUMN ind_data_source.source_db IS '源数据库，如 bdss_spot_market';
COMMENT ON COLUMN ind_data_source.source_table IS '源表名，如 spot_ahead_trade';
COMMENT ON COLUMN ind_data_source.source_field IS '源字段，如 price';
COMMENT ON COLUMN ind_data_source.filter_condition IS '过滤条件JSON，如 {"object_type":"竞价空间"}';
COMMENT ON COLUMN ind_data_source.join_config IS '关联配置，支持多表JOIN';
COMMENT ON COLUMN ind_data_source.field_mapping IS '字段映射配置 {srcField: "price", targetField: "value"}';
COMMENT ON COLUMN ind_data_source.date_field IS '日期字段名';
COMMENT ON COLUMN ind_data_source.time_field IS '时间点字段名';
COMMENT ON COLUMN ind_data_source.tenant_field IS '租户字段名';
COMMENT ON COLUMN ind_data_source.test_sql IS '测试SQL';
COMMENT ON COLUMN ind_data_source.status IS '0=禁用 1=启用';
COMMENT ON COLUMN ind_data_source.create_time IS '创建时间';
COMMENT ON COLUMN ind_data_source.update_time IS '更新时间';
COMMENT ON COLUMN ind_data_source.tenant_id IS '租户ID';
COMMENT ON COLUMN ind_data_source.del_flag IS '0=正常 1=删除';

-- ============================================================
-- 3. 计算公式表
-- ============================================================
CREATE TABLE ind_calc_formula (
    id              BIGINT       NOT NULL GENERATED ALWAYS AS IDENTITY,
    indicator_id    BIGINT       NOT NULL,
    indicator_code  VARCHAR(32)  NOT NULL,
    formula_type    SMALLINT     NOT NULL,
    formula_expr    TEXT         NOT NULL,
    deps            JSONB        DEFAULT NULL,
    dep_codes       VARCHAR(512) DEFAULT NULL,
    calc_order      INT          DEFAULT 0,
    condition_expr  TEXT         DEFAULT NULL,
    true_value_expr TEXT         DEFAULT NULL,
    false_value     VARCHAR(32)  DEFAULT '0',
    yoy_mom_config  JSONB        DEFAULT NULL,
    agg_config      JSONB        DEFAULT NULL,
    rank_config     JSONB        DEFAULT NULL,
    status          SMALLINT     DEFAULT 1,
    create_time     TIMESTAMPTZ  DEFAULT CURRENT_TIMESTAMP,
    update_time     TIMESTAMPTZ  DEFAULT CURRENT_TIMESTAMP,
    tenant_id       BIGINT       NOT NULL,
    del_flag        SMALLINT     DEFAULT 0,
    PRIMARY KEY (id),
    CONSTRAINT uk_indicator_formula UNIQUE (indicator_id)
);

CREATE INDEX idx_calc_formula_code ON ind_calc_formula (indicator_code);
CREATE INDEX idx_calc_formula_type ON ind_calc_formula (formula_type);
CREATE INDEX idx_calc_formula_deps ON ind_calc_formula (dep_codes);

CREATE TRIGGER trg_ind_calc_formula_update_time
    BEFORE UPDATE ON ind_calc_formula
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

COMMENT ON TABLE ind_calc_formula IS '计算公式表';
COMMENT ON COLUMN ind_calc_formula.id IS '主键';
COMMENT ON COLUMN ind_calc_formula.indicator_id IS '目标指标ID';
COMMENT ON COLUMN ind_calc_formula.indicator_code IS '目标指标编码(冗余)';
COMMENT ON COLUMN ind_calc_formula.formula_type IS '1=四则运算 2=条件分支 3=聚合汇总 4=同环比 5=排名';
COMMENT ON COLUMN ind_calc_formula.formula_expr IS '公式表达式';
COMMENT ON COLUMN ind_calc_formula.deps IS '依赖指标编码列表';
COMMENT ON COLUMN ind_calc_formula.dep_codes IS '依赖指标编码逗号分隔(便于查询)';
COMMENT ON COLUMN ind_calc_formula.calc_order IS '同层级内的计算顺序';
COMMENT ON COLUMN ind_calc_formula.condition_expr IS 'IF条件表达式';
COMMENT ON COLUMN ind_calc_formula.true_value_expr IS '条件为真时的计算表达式';
COMMENT ON COLUMN ind_calc_formula.false_value IS '条件为假时的值';
COMMENT ON COLUMN ind_calc_formula.yoy_mom_config IS '同环比配置 {"baseCode":"ONLINE_ENERGY","compareType":"YOY","offset":-365}';
COMMENT ON COLUMN ind_calc_formula.agg_config IS '聚合配置 {"func":"SUM","groupFields":["unit_id"],"timeGrain":"daily"}';
COMMENT ON COLUMN ind_calc_formula.rank_config IS '排名配置 {"topN":10,"order":"DESC","groupBy":"group_company,plant,unit"}';
COMMENT ON COLUMN ind_calc_formula.status IS '0=禁用 1=启用';
COMMENT ON COLUMN ind_calc_formula.create_time IS '创建时间';
COMMENT ON COLUMN ind_calc_formula.update_time IS '更新时间';
COMMENT ON COLUMN ind_calc_formula.tenant_id IS '租户ID';
COMMENT ON COLUMN ind_calc_formula.del_flag IS '0=正常 1=删除';

-- ============================================================
-- 4. 分时指标数据表（按月分区）
-- ============================================================
CREATE TABLE ind_data_timeseries (
    id              BIGINT       NOT NULL GENERATED ALWAYS AS IDENTITY,
    indicator_id    BIGINT       NOT NULL,
    indicator_code  VARCHAR(32)  NOT NULL,
    unit_id         VARCHAR(32)  DEFAULT NULL,
    unit_name       VARCHAR(64)  DEFAULT NULL,
    plant_id        VARCHAR(32)  DEFAULT NULL,
    group_code      VARCHAR(32)  DEFAULT NULL,
    trade_date      DATE         NOT NULL,
    time_point      SMALLINT     NOT NULL,
    value           DECIMAL(18,4) DEFAULT NULL,
    data_type       SMALLINT     DEFAULT 1,
    calc_time       TIMESTAMPTZ  DEFAULT NULL,
    data_status     SMALLINT     DEFAULT 1,
    tenant_id       BIGINT       NOT NULL,
    create_time     TIMESTAMPTZ  DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id, trade_date),
    CONSTRAINT uk_timeseries_data UNIQUE (indicator_code, unit_id, trade_date, time_point, data_type, tenant_id)
) PARTITION BY RANGE (trade_date);

-- 创建分区
CREATE TABLE ind_data_timeseries_p202601 PARTITION OF ind_data_timeseries
    FOR VALUES FROM ('2026-01-01') TO ('2026-02-01');
CREATE TABLE ind_data_timeseries_p202602 PARTITION OF ind_data_timeseries
    FOR VALUES FROM ('2026-02-01') TO ('2026-03-01');
CREATE TABLE ind_data_timeseries_p202603 PARTITION OF ind_data_timeseries
    FOR VALUES FROM ('2026-03-01') TO ('2026-04-01');
CREATE TABLE ind_data_timeseries_p202604 PARTITION OF ind_data_timeseries
    FOR VALUES FROM ('2026-04-01') TO ('2026-05-01');
CREATE TABLE ind_data_timeseries_p202605 PARTITION OF ind_data_timeseries
    FOR VALUES FROM ('2026-05-01') TO ('2026-06-01');
CREATE TABLE ind_data_timeseries_p202606 PARTITION OF ind_data_timeseries
    FOR VALUES FROM ('2026-06-01') TO ('2026-07-01');
CREATE TABLE ind_data_timeseries_p202607 PARTITION OF ind_data_timeseries
    FOR VALUES FROM ('2026-07-01') TO ('2026-08-01');
CREATE TABLE ind_data_timeseries_p202608 PARTITION OF ind_data_timeseries
    FOR VALUES FROM ('2026-08-01') TO ('2026-09-01');
CREATE TABLE ind_data_timeseries_p202609 PARTITION OF ind_data_timeseries
    FOR VALUES FROM ('2026-09-01') TO ('2026-10-01');
CREATE TABLE ind_data_timeseries_p202610 PARTITION OF ind_data_timeseries
    FOR VALUES FROM ('2026-10-01') TO ('2026-11-01');
CREATE TABLE ind_data_timeseries_p202611 PARTITION OF ind_data_timeseries
    FOR VALUES FROM ('2026-11-01') TO ('2026-12-01');
CREATE TABLE ind_data_timeseries_p202612 PARTITION OF ind_data_timeseries
    FOR VALUES FROM ('2026-12-01') TO ('2027-01-01');
CREATE TABLE ind_data_timeseries_p202701 PARTITION OF ind_data_timeseries
    FOR VALUES FROM ('2027-01-01') TO ('2027-02-01');
CREATE TABLE ind_data_timeseries_p_default PARTITION OF ind_data_timeseries
    DEFAULT;

CREATE INDEX idx_timeseries_date ON ind_data_timeseries (trade_date);
CREATE INDEX idx_timeseries_indicator_date ON ind_data_timeseries (indicator_code, trade_date);
CREATE INDEX idx_timeseries_unit_date ON ind_data_timeseries (unit_id, trade_date);
CREATE INDEX idx_timeseries_plant_date ON ind_data_timeseries (plant_id, trade_date);

COMMENT ON TABLE ind_data_timeseries IS '分时指标数据表';
COMMENT ON COLUMN ind_data_timeseries.id IS '主键';
COMMENT ON COLUMN ind_data_timeseries.indicator_id IS '指标ID';
COMMENT ON COLUMN ind_data_timeseries.indicator_code IS '指标编码(冗余)';
COMMENT ON COLUMN ind_data_timeseries.unit_id IS '机组/电厂/交易单元编码';
COMMENT ON COLUMN ind_data_timeseries.unit_name IS '机组名称(冗余)';
COMMENT ON COLUMN ind_data_timeseries.plant_id IS '电厂编码';
COMMENT ON COLUMN ind_data_timeseries.group_code IS '二级公司编码';
COMMENT ON COLUMN ind_data_timeseries.trade_date IS '交易日期';
COMMENT ON COLUMN ind_data_timeseries.time_point IS '时间点(1-96), 日/月粒度填0';
COMMENT ON COLUMN ind_data_timeseries.value IS '指标值';
COMMENT ON COLUMN ind_data_timeseries.data_type IS '1=实际 2=预测 3=计划';
COMMENT ON COLUMN ind_data_timeseries.calc_time IS '计算完成时间';
COMMENT ON COLUMN ind_data_timeseries.data_status IS '1=正常 2=待确认 3=异常';
COMMENT ON COLUMN ind_data_timeseries.tenant_id IS '租户ID';
COMMENT ON COLUMN ind_data_timeseries.create_time IS '创建时间';

-- ============================================================
-- 5. 日维度指标数据表
-- ============================================================
CREATE TABLE ind_data_daily (
    id              BIGINT       NOT NULL GENERATED ALWAYS AS IDENTITY,
    indicator_id    BIGINT       NOT NULL,
    indicator_code  VARCHAR(32)  NOT NULL,
    unit_id         VARCHAR(32)  DEFAULT NULL,
    unit_name       VARCHAR(64)  DEFAULT NULL,
    plant_id        VARCHAR(32)  DEFAULT NULL,
    group_code      VARCHAR(32)  DEFAULT NULL,
    trade_date      DATE         NOT NULL,
    value           DECIMAL(18,4) DEFAULT NULL,
    min_value       DECIMAL(18,4) DEFAULT NULL,
    max_value       DECIMAL(18,4) DEFAULT NULL,
    avg_value       DECIMAL(18,4) DEFAULT NULL,
    calc_time       TIMESTAMPTZ  DEFAULT NULL,
    tenant_id       BIGINT       NOT NULL,
    create_time     TIMESTAMPTZ  DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    CONSTRAINT uk_daily_data UNIQUE (indicator_code, unit_id, trade_date, tenant_id)
);

CREATE INDEX idx_data_daily_date ON ind_data_daily (trade_date);
CREATE INDEX idx_data_daily_indicator_date ON ind_data_daily (indicator_code, trade_date);
CREATE INDEX idx_data_daily_plant_date ON ind_data_daily (plant_id, trade_date);

COMMENT ON TABLE ind_data_daily IS '日维度指标数据表';
COMMENT ON COLUMN ind_data_daily.id IS '主键';
COMMENT ON COLUMN ind_data_daily.indicator_id IS '指标ID';
COMMENT ON COLUMN ind_data_daily.indicator_code IS '指标编码(冗余)';
COMMENT ON COLUMN ind_data_daily.unit_id IS '机组编码';
COMMENT ON COLUMN ind_data_daily.unit_name IS '机组名称';
COMMENT ON COLUMN ind_data_daily.plant_id IS '电厂编码';
COMMENT ON COLUMN ind_data_daily.group_code IS '二级公司编码';
COMMENT ON COLUMN ind_data_daily.trade_date IS '交易日期';
COMMENT ON COLUMN ind_data_daily.value IS '日汇总值';
COMMENT ON COLUMN ind_data_daily.min_value IS '日最小值';
COMMENT ON COLUMN ind_data_daily.max_value IS '日最大值';
COMMENT ON COLUMN ind_data_daily.avg_value IS '日平均值';
COMMENT ON COLUMN ind_data_daily.calc_time IS '计算完成时间';
COMMENT ON COLUMN ind_data_daily.tenant_id IS '租户ID';
COMMENT ON COLUMN ind_data_daily.create_time IS '创建时间';

-- ============================================================
-- 6. 月维度指标数据表
-- ============================================================
CREATE TABLE ind_data_monthly (
    id              BIGINT       NOT NULL GENERATED ALWAYS AS IDENTITY,
    indicator_id    BIGINT       NOT NULL,
    indicator_code  VARCHAR(32)  NOT NULL,
    unit_id         VARCHAR(32)  DEFAULT NULL,
    unit_name       VARCHAR(64)  DEFAULT NULL,
    plant_id        VARCHAR(32)  DEFAULT NULL,
    group_code      VARCHAR(32)  DEFAULT NULL,
    trade_month     VARCHAR(7)   NOT NULL,
    value           DECIMAL(18,4) DEFAULT NULL,
    year_cumulative DECIMAL(18,4) DEFAULT NULL,
    calc_time       TIMESTAMPTZ  DEFAULT NULL,
    tenant_id       BIGINT       NOT NULL,
    create_time     TIMESTAMPTZ  DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    CONSTRAINT uk_monthly_data UNIQUE (indicator_code, unit_id, trade_month, tenant_id)
);

CREATE INDEX idx_data_monthly_month ON ind_data_monthly (trade_month);
CREATE INDEX idx_data_monthly_indicator_month ON ind_data_monthly (indicator_code, trade_month);

COMMENT ON TABLE ind_data_monthly IS '月维度指标数据表';
COMMENT ON COLUMN ind_data_monthly.id IS '主键';
COMMENT ON COLUMN ind_data_monthly.indicator_id IS '指标ID';
COMMENT ON COLUMN ind_data_monthly.indicator_code IS '指标编码(冗余)';
COMMENT ON COLUMN ind_data_monthly.unit_id IS '机组编码';
COMMENT ON COLUMN ind_data_monthly.unit_name IS '机组名称';
COMMENT ON COLUMN ind_data_monthly.plant_id IS '电厂编码';
COMMENT ON COLUMN ind_data_monthly.group_code IS '二级公司编码';
COMMENT ON COLUMN ind_data_monthly.trade_month IS '月份 yyyy-MM';
COMMENT ON COLUMN ind_data_monthly.value IS '月汇总值';
COMMENT ON COLUMN ind_data_monthly.year_cumulative IS '年累计值';
COMMENT ON COLUMN ind_data_monthly.calc_time IS '计算完成时间';
COMMENT ON COLUMN ind_data_monthly.tenant_id IS '租户ID';
COMMENT ON COLUMN ind_data_monthly.create_time IS '创建时间';

-- ============================================================
-- 7. 维度定义表（多维度分类）
-- ============================================================
CREATE TABLE ind_dimension (
    id              BIGINT       NOT NULL GENERATED ALWAYS AS IDENTITY,
    dim_type        VARCHAR(16)  NOT NULL,
    dim_code        VARCHAR(32)  NOT NULL,
    dim_name        VARCHAR(32)  NOT NULL,
    parent_id       BIGINT       DEFAULT NULL,
    parent_code     VARCHAR(32)  DEFAULT NULL,
    level_num       SMALLINT     DEFAULT 1,
    sort_order      INT          DEFAULT 0,
    icon            VARCHAR(32)  DEFAULT NULL,
    status          SMALLINT     DEFAULT 1,
    create_time     TIMESTAMPTZ  DEFAULT CURRENT_TIMESTAMP,
    update_time     TIMESTAMPTZ  DEFAULT CURRENT_TIMESTAMP,
    tenant_id       BIGINT       NOT NULL,
    del_flag        SMALLINT     DEFAULT 0,
    PRIMARY KEY (id),
    CONSTRAINT uk_dim UNIQUE (dim_type, dim_code, tenant_id)
);

CREATE INDEX idx_dimension_parent ON ind_dimension (parent_id);

CREATE TRIGGER trg_ind_dimension_update_time
    BEFORE UPDATE ON ind_dimension
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

COMMENT ON TABLE ind_dimension IS '维度定义表';
COMMENT ON COLUMN ind_dimension.id IS '主键';
COMMENT ON COLUMN ind_dimension.dim_type IS '维度类型: BUSINESS=业务域 / MARKET=市场类型 / SUBJECT=主体层级';
COMMENT ON COLUMN ind_dimension.dim_code IS '维度编码';
COMMENT ON COLUMN ind_dimension.dim_name IS '维度名称';
COMMENT ON COLUMN ind_dimension.parent_id IS '父维度ID(树形结构)';
COMMENT ON COLUMN ind_dimension.parent_code IS '父维度编码';
COMMENT ON COLUMN ind_dimension.level_num IS '层级号 1/2/3';
COMMENT ON COLUMN ind_dimension.sort_order IS '排序号';
COMMENT ON COLUMN ind_dimension.icon IS '图标';
COMMENT ON COLUMN ind_dimension.status IS '0=禁用 1=启用';
COMMENT ON COLUMN ind_dimension.create_time IS '创建时间';
COMMENT ON COLUMN ind_dimension.update_time IS '更新时间';
COMMENT ON COLUMN ind_dimension.tenant_id IS '租户ID';
COMMENT ON COLUMN ind_dimension.del_flag IS '0=正常 1=删除';

-- ============================================================
-- 8. 指标-维度关联表（多对多）
-- ============================================================
CREATE TABLE ind_indicator_dimension (
    id              BIGINT       NOT NULL GENERATED ALWAYS AS IDENTITY,
    indicator_id    BIGINT       NOT NULL,
    indicator_code  VARCHAR(32)  NOT NULL,
    dimension_id    BIGINT       NOT NULL,
    dim_type        VARCHAR(16)  NOT NULL,
    sort_order      INT          DEFAULT 0,
    tenant_id       BIGINT       NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT uk_rel UNIQUE (indicator_id, dimension_id)
);

CREATE INDEX idx_indicator_dimension_dim ON ind_indicator_dimension (dimension_id);
CREATE INDEX idx_indicator_dimension_dim_type ON ind_indicator_dimension (dim_type, dimension_id);

COMMENT ON TABLE ind_indicator_dimension IS '指标-维度多对多关联表';
COMMENT ON COLUMN ind_indicator_dimension.id IS '主键';
COMMENT ON COLUMN ind_indicator_dimension.indicator_id IS '指标ID';
COMMENT ON COLUMN ind_indicator_dimension.indicator_code IS '指标编码(冗余)';
COMMENT ON COLUMN ind_indicator_dimension.dimension_id IS '维度ID';
COMMENT ON COLUMN ind_indicator_dimension.dim_type IS '维度类型(冗余)';
COMMENT ON COLUMN ind_indicator_dimension.sort_order IS '排序号';
COMMENT ON COLUMN ind_indicator_dimension.tenant_id IS '租户ID';

-- ============================================================
-- 9. 计算任务日志表
-- ============================================================
CREATE TABLE ind_calc_task_log (
    id              BIGINT       NOT NULL GENERATED ALWAYS AS IDENTITY,
    task_date       DATE         NOT NULL,
    task_type       SMALLINT     NOT NULL,
    status          SMALLINT     NOT NULL,
    trigger_mode    SMALLINT     DEFAULT 1,
    total_count     INT          DEFAULT 0,
    success_count   INT          DEFAULT 0,
    fail_count      INT          DEFAULT 0,
    skip_count      INT          DEFAULT 0,
    start_time      TIMESTAMPTZ  DEFAULT NULL,
    end_time        TIMESTAMPTZ  DEFAULT NULL,
    duration_ms     BIGINT       DEFAULT NULL,
    error_detail    TEXT         DEFAULT NULL,
    tenant_id       BIGINT       NOT NULL,
    create_time     TIMESTAMPTZ  DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);

CREATE INDEX idx_calc_task_log_date ON ind_calc_task_log (task_date);
CREATE INDEX idx_calc_task_log_status ON ind_calc_task_log (status, task_date);

COMMENT ON TABLE ind_calc_task_log IS '计算任务日志表';
COMMENT ON COLUMN ind_calc_task_log.id IS '主键';
COMMENT ON COLUMN ind_calc_task_log.task_date IS '计算目标日期';
COMMENT ON COLUMN ind_calc_task_log.task_type IS '1=定时全量 2=手动触发 3=单指标重算';
COMMENT ON COLUMN ind_calc_task_log.status IS '1=运行中 2=成功 3=失败 4=部分失败';
COMMENT ON COLUMN ind_calc_task_log.trigger_mode IS '1=自动 2=手动';
COMMENT ON COLUMN ind_calc_task_log.total_count IS '总指标数';
COMMENT ON COLUMN ind_calc_task_log.success_count IS '成功数';
COMMENT ON COLUMN ind_calc_task_log.fail_count IS '失败数';
COMMENT ON COLUMN ind_calc_task_log.skip_count IS '跳过数';
COMMENT ON COLUMN ind_calc_task_log.start_time IS '开始时间';
COMMENT ON COLUMN ind_calc_task_log.end_time IS '结束时间';
COMMENT ON COLUMN ind_calc_task_log.duration_ms IS '耗时(毫秒)';
COMMENT ON COLUMN ind_calc_task_log.error_detail IS '错误详情';
COMMENT ON COLUMN ind_calc_task_log.tenant_id IS '租户ID';
COMMENT ON COLUMN ind_calc_task_log.create_time IS '创建时间';

-- ============================================================
-- 10. 指标计算明细日志表
-- ============================================================
CREATE TABLE ind_calc_detail_log (
    id              BIGINT       NOT NULL GENERATED ALWAYS AS IDENTITY,
    task_id         BIGINT       NOT NULL,
    indicator_code  VARCHAR(32)  NOT NULL,
    calc_layer      SMALLINT     DEFAULT NULL,
    status          SMALLINT     NOT NULL,
    rows_affected   INT          DEFAULT 0,
    duration_ms     BIGINT       DEFAULT NULL,
    error_msg       VARCHAR(512) DEFAULT NULL,
    calc_sql        TEXT         DEFAULT NULL,
    tenant_id       BIGINT       NOT NULL,
    create_time     TIMESTAMPTZ  DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);

CREATE INDEX idx_calc_detail_log_task ON ind_calc_detail_log (task_id);
CREATE INDEX idx_calc_detail_log_code ON ind_calc_detail_log (indicator_code, task_id);

COMMENT ON TABLE ind_calc_detail_log IS '指标计算明细日志表';
COMMENT ON COLUMN ind_calc_detail_log.id IS '主键';
COMMENT ON COLUMN ind_calc_detail_log.task_id IS '任务ID';
COMMENT ON COLUMN ind_calc_detail_log.indicator_code IS '指标编码';
COMMENT ON COLUMN ind_calc_detail_log.calc_layer IS '计算层级';
COMMENT ON COLUMN ind_calc_detail_log.status IS '1=成功 2=失败 3=跳过 4=无数据';
COMMENT ON COLUMN ind_calc_detail_log.rows_affected IS '影响行数';
COMMENT ON COLUMN ind_calc_detail_log.duration_ms IS '耗时(毫秒)';
COMMENT ON COLUMN ind_calc_detail_log.error_msg IS '错误信息';
COMMENT ON COLUMN ind_calc_detail_log.calc_sql IS '执行SQL(调试用)';
COMMENT ON COLUMN ind_calc_detail_log.tenant_id IS '租户ID';
COMMENT ON COLUMN ind_calc_detail_log.create_time IS '创建时间';

-- ============================================================
-- 11. 维度实体表（省网/二级公司/电厂/机组）
-- ============================================================
CREATE TABLE ind_dimension_entity (
    id              BIGINT       NOT NULL GENERATED ALWAYS AS IDENTITY,
    entity_type     VARCHAR(16)  NOT NULL,
    entity_code     VARCHAR(32)  NOT NULL,
    entity_name     VARCHAR(64)  NOT NULL,
    parent_code     VARCHAR(32)  DEFAULT NULL,
    province_code   VARCHAR(8)   DEFAULT NULL,
    rated_capacity  DECIMAL(10,2) DEFAULT NULL,
    installed_cap   DECIMAL(10,2) DEFAULT NULL,
    aux_rate        DECIMAL(5,4) DEFAULT NULL,
    sort_order      INT          DEFAULT 0,
    status          SMALLINT     DEFAULT 1,
    tenant_id       BIGINT       NOT NULL,
    del_flag        SMALLINT     DEFAULT 0,
    PRIMARY KEY (id),
    CONSTRAINT uk_entity UNIQUE (entity_type, entity_code, tenant_id)
);

CREATE INDEX idx_dimension_entity_parent ON ind_dimension_entity (parent_code);

COMMENT ON TABLE ind_dimension_entity IS '维度实体表(省网/公司/电厂/机组)';
COMMENT ON COLUMN ind_dimension_entity.id IS '主键';
COMMENT ON COLUMN ind_dimension_entity.entity_type IS '实体类型: PROVINCE/GROUP_COMPANY/PLANT/UNIT';
COMMENT ON COLUMN ind_dimension_entity.entity_code IS '实体编码';
COMMENT ON COLUMN ind_dimension_entity.entity_name IS '实体名称';
COMMENT ON COLUMN ind_dimension_entity.parent_code IS '上级编码';
COMMENT ON COLUMN ind_dimension_entity.province_code IS '省网编码(SX/HA/HB/MX/MD/NX/GS/SN/YN/GX)';
COMMENT ON COLUMN ind_dimension_entity.rated_capacity IS '额定容量(MW)';
COMMENT ON COLUMN ind_dimension_entity.installed_cap IS '装机容量(MW)';
COMMENT ON COLUMN ind_dimension_entity.aux_rate IS '厂用电率';
COMMENT ON COLUMN ind_dimension_entity.sort_order IS '排序号';
COMMENT ON COLUMN ind_dimension_entity.status IS '0=禁用 1=启用';
COMMENT ON COLUMN ind_dimension_entity.tenant_id IS '租户ID';
COMMENT ON COLUMN ind_dimension_entity.del_flag IS '0=正常 1=删除';
