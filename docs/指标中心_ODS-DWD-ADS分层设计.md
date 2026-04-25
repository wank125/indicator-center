# 指标中心 — ODS-DWD-ADS 分层架构设计 (Apache Doris)

> 基于 ODS → DWD → ADS 三层数仓架构，使用 Apache Doris 作为统一分析引擎，替代原"动态跨库查询"方案。

---

## 一、为什么选择 Doris 分层架构

### 现有方案的问题

```
当前: 各业务库 → @DS动态切换 → DataExtractService动态SQL → ind_data_timeseries
                                         │
                                         ├─ 跨11个库，连接池开销大
                                         ├─ 动态SQL拼接不安全(注入风险)
                                         ├─ 无数据血缘，难以追溯
                                         ├─ 源表结构变更直接影响指标计算
                                         └─ 查询性能受业务库影响
```

### Doris 分层方案

```
改进: 各业务库 → Flink/ETL → Doris ODS → DWD → ADS → Java服务查询
                                          │
                                          ├─ 统一存储，单库查询
                                          ├─ 列存储 + 分区 + 分桶，查询快
                                          ├─ 标准化分层，数据血缘清晰
                                          ├─ 源表变更只影响 ODS，DWD/ADS 隔离
                                          └─ 支持实时+批量双模写入
```

---

## 二、整体架构

```
┌─────────────────────────────────────────────────────────────────────┐
│                        数据源 (11个MySQL业务库)                       │
│  spot_market | transaction | settlement | cost | basic_parameter    │
│  algorithm | group_data | market_analysis | retail | examination    │
└──────────────────────────┬──────────────────────────────────────────┘
                           │
              ┌────────────▼─────────────┐
              │   ETL 同步层              │
              │   Flink CDC / DataX       │
              │   (实时流 + 定时批量)       │
              └────────────┬──────────────┘
                           │
        ┌──────────────────▼──────────────────────┐
        │          Apache Doris 数仓               │
        │                                          │
        │  ┌─────────┐  ┌─────────┐  ┌─────────┐ │
        │  │  ODS 层  │→ │  DWD 层  │→ │  ADS 层  │ │
        │  │ 原始数据  │  │ 明细数据  │  │ 指标数据  │ │
        │  └─────────┘  └─────────┘  └─────────┘ │
        │       DB: indicator_ods                   │
        │            indicator_dwd                   │
        │            indicator_ads                   │
        └──────────────────┬──────────────────────┘
                           │ HTTP SQL/JDBC
              ┌────────────▼─────────────┐
              │  Spring Boot 指标服务      │
              │  IndicatorDataService     │
              │  CalcService (公式引擎)    │
              └────────────┬──────────────┘
                           │
              ┌────────────▼─────────────┐
              │  前端 (Vue + ECharts)     │
              │  看板 / 查询 / 配置 / 监控 │
              └──────────────────────────┘
```

---

## 三、Doris 部署规划

### 3.1 集群配置

| 组件 | 规格 | 说明 |
|------|------|------|
| FE (Frontend) | 1-3 节点, 4C8G | 查询解析、元数据管理 |
| BE (Backend) | 3 节点, 8C32G | 数据存储、查询执行 |
| Broker | 可选 | 数据导入导出 |
| 版本 | 2.1.x+ | 推荐 2.1.4 或 3.0 |

### 3.2 数据库划分

```sql
-- 三层分库
CREATE DATABASE IF NOT EXISTS indicator_ods;    -- ODS: 原始数据层
CREATE DATABASE IF NOT EXISTS indicator_dwd;    -- DWD: 明细数据层
CREATE DATABASE IF NOT EXISTS indicator_ads;    -- ADS: 指标应用层
```

---

## 四、ODS 层设计 (Operational Data Store)

### 4.1 设计原则

- **1:1 映射**: 每张业务源表对应一张 ODS 表，保持原始字段
- **统一前缀**: `ods_{源库缩写}_{源表名}`
- **增量字段**: 增加 `__etl_time` (导入时间)、`__op_type` (INSERT/UPDATE/DELETE)
- **分区策略**: 按日期分区 (交易日期/创建日期)
- **不清洗**: 保持与源表一致，仅做类型适配 (MySQL→Doris 类型映射)

### 4.2 ODS 表清单

```sql
-- ============================================================
-- ODS 层: 现货市场
-- ============================================================

-- 日前出清
CREATE TABLE indicator_ods.ods_spot_ahead_trade (
    id              BIGINT          COMMENT '主键',
    tenant_id       BIGINT          COMMENT '租户ID',
    unit_id         VARCHAR(32)     COMMENT '机组ID',
    unit_name       VARCHAR(64)     COMMENT '机组名称',
    trade_date      DATE            COMMENT '交易日期',
    time_id         INT             COMMENT '时间点(1-96)',
    power           DECIMAL(18,4)   COMMENT '出清电量(MWh)',
    price           DECIMAL(18,4)   COMMENT '出清电价(元/MWh)',
    market_type     VARCHAR(16)     COMMENT '市场类型',
    create_time     DATETIME        COMMENT '创建时间',
    __etl_time      DATETIME        COMMENT 'ETL导入时间'
)
UNIQUE KEY(id, tenant_id, trade_date, time_id)
DISTRIBUTED BY HASH(tenant_id) BUCKETS 8
PARTITION BY RANGE(trade_date) (
    FROM ('2025-01-01') TO ('2025-02-01') INTERVAL 1 MONTH,
    FROM ('2025-02-01') TO ('2026-01-01') INTERVAL 1 MONTH,
    FROM ('2026-01-01') TO ('2027-01-01') INTERVAL 1 MONTH
)
PROPERTIES (
    "replication_num" = "1",
    "enable_unique_key_merge_on_write" = "true"
);

-- 实时出清
CREATE TABLE indicator_ods.ods_spot_real_trade (
    id              BIGINT,
    tenant_id       BIGINT,
    unit_id         VARCHAR(32),
    unit_name       VARCHAR(64),
    trade_date      DATE,
    time_id         INT,
    power           DECIMAL(18,4),
    price           DECIMAL(18,4),
    market_type     VARCHAR(16),
    create_time     DATETIME,
    __etl_time      DATETIME
)
UNIQUE KEY(id, tenant_id, trade_date, time_id)
DISTRIBUTED BY HASH(tenant_id) BUCKETS 8
PARTITION BY RANGE(trade_date) (
    FROM ('2025-01-01') TO ('2027-01-01') INTERVAL 1 MONTH
);

-- 省间交易申报
CREATE TABLE indicator_ods.ods_spot_inter_province_declare (
    id              BIGINT,
    tenant_id       BIGINT,
    unit_id         VARCHAR(32),
    trade_date      DATE,
    time_id         INT,
    dam_bid_output  DECIMAL(18,4)   COMMENT '日前申报出力',
    rtm_bid_output  DECIMAL(18,4)   COMMENT '实时申报出力',
    create_time     DATETIME,
    __etl_time      DATETIME
)
UNIQUE KEY(id, tenant_id, trade_date, time_id)
DISTRIBUTED BY HASH(tenant_id) BUCKETS 4
PARTITION BY RANGE(trade_date) (
    FROM ('2025-01-01') TO ('2027-01-01') INTERVAL 1 MONTH
);

-- 省间交易结果
CREATE TABLE indicator_ods.ods_spot_inter_province_result (
    id              BIGINT,
    tenant_id       BIGINT,
    trade_date      DATE,
    time_id         INT,
    dam_price       DECIMAL(18,4)   COMMENT '日前出清价',
    rtm_price       DECIMAL(18,4)   COMMENT '实时出清价',
    province_code   VARCHAR(8)      COMMENT '省网编码',
    create_time     DATETIME,
    __etl_time      DATETIME
)
UNIQUE KEY(id, tenant_id, trade_date, time_id)
DISTRIBUTED BY HASH(tenant_id) BUCKETS 4
PARTITION BY RANGE(trade_date) (
    FROM ('2025-01-01') TO ('2027-01-01') INTERVAL 1 MONTH
);

-- ============================================================
-- ODS 层: 交易管理
-- ============================================================

CREATE TABLE indicator_ods.ods_txm_contract_match_month (
    id              BIGINT,
    tenant_id       BIGINT,
    unit_id         VARCHAR(32),
    unit_name       VARCHAR(64),
    contract_month  VARCHAR(7)      COMMENT '合约月份 yyyy-MM',
    trade_date      DATE            COMMENT '交易日',
    time_id         INT             COMMENT '时间点',
    base_energy     DECIMAL(18,4)   COMMENT '基数电量',
    base_price      DECIMAL(18,4)   COMMENT '基数电价',
    mlt_energy      DECIMAL(18,4)   COMMENT '中长期电量',
    mlt_price       DECIMAL(18,4)   COMMENT '中长期电价',
    mlt_fee         DECIMAL(18,4)   COMMENT '中长期电费',
    create_time     DATETIME,
    __etl_time      DATETIME
)
UNIQUE KEY(id, tenant_id, trade_date, time_id)
DISTRIBUTED BY HASH(tenant_id) BUCKETS 8
PARTITION BY RANGE(trade_date) (
    FROM ('2025-01-01') TO ('2027-01-01') INTERVAL 1 MONTH
);

-- ============================================================
-- ODS 层: 结算管理
-- ============================================================

CREATE TABLE indicator_ods.ods_sett_power_hour_unit (
    id              BIGINT,
    tenant_id       BIGINT,
    unit_id         VARCHAR(32),
    unit_name       VARCHAR(64),
    trade_date      DATE,
    time_id         INT,
    online_energy   DECIMAL(18,4)   COMMENT '上网电量',
    create_time     DATETIME,
    __etl_time      DATETIME
)
UNIQUE KEY(id, tenant_id, trade_date, time_id)
DISTRIBUTED BY HASH(tenant_id) BUCKETS 8
PARTITION BY RANGE(trade_date) (
    FROM ('2025-01-01') TO ('2027-01-01') INTERVAL 1 MONTH
);

CREATE TABLE indicator_ods.ods_sett_base_subject (
    id              BIGINT,
    tenant_id       BIGINT,
    unit_id         VARCHAR(32),
    trade_date      DATE,
    subject_code    VARCHAR(32)     COMMENT '科目编码',
    subject_name    VARCHAR(64)     COMMENT '科目名称',
    fee_amount      DECIMAL(18,4)   COMMENT '费用金额',
    create_time     DATETIME,
    __etl_time      DATETIME
)
UNIQUE KEY(id, tenant_id, trade_date, subject_code)
DISTRIBUTED BY HASH(tenant_id) BUCKETS 4
PARTITION BY RANGE(trade_date) (
    FROM ('2025-01-01') TO ('2027-01-01') INTERVAL 1 MONTH
);

CREATE TABLE indicator_ods.ods_sett_unit_bill_day (
    id              BIGINT,
    tenant_id       BIGINT,
    unit_id         VARCHAR(32),
    unit_name       VARCHAR(64),
    trade_date      DATE,
    total_fee       DECIMAL(18,4)   COMMENT '总电费',
    create_time     DATETIME,
    __etl_time      DATETIME
)
UNIQUE KEY(id, tenant_id, trade_date)
DISTRIBUTED BY HASH(tenant_id) BUCKETS 4
PARTITION BY RANGE(trade_date) (
    FROM ('2025-01-01') TO ('2027-01-01') INTERVAL 1 MONTH
);

-- ============================================================
-- ODS 层: 基础参数
-- ============================================================

CREATE TABLE indicator_ods.ods_bas_unit (
    id              BIGINT,
    tenant_id       BIGINT,
    unit_id         VARCHAR(32),
    unit_name       VARCHAR(64),
    plant_id        VARCHAR(32),
    group_code      VARCHAR(32),
    rated_capacity  DECIMAL(10,2)   COMMENT '额定容量(MW)',
    min_output      DECIMAL(10,2)   COMMENT '最小技术出力(MW)',
    aux_rate        DECIMAL(5,4)    COMMENT '厂用电率',
    installed_cap   DECIMAL(10,2)   COMMENT '装机容量(MW)',
    effective_cap   DECIMAL(10,2)   COMMENT '有效容量(MW)',
    status          INT,
    __etl_time      DATETIME
)
UNIQUE KEY(id, tenant_id)
DISTRIBUTED BY HASH(tenant_id) BUCKETS 4;

-- ============================================================
-- ODS 层: 成本管理
-- ============================================================

CREATE TABLE indicator_ods.ods_cost_unit_curve (
    id              BIGINT,
    tenant_id       BIGINT,
    unit_id         VARCHAR(32),
    trade_date      DATE,
    time_id         INT,
    var_cost_price  DECIMAL(18,4)   COMMENT '单位变动成本',
    __etl_time      DATETIME
)
UNIQUE KEY(id, tenant_id, trade_date, time_id)
DISTRIBUTED BY HASH(tenant_id) BUCKETS 4
PARTITION BY RANGE(trade_date) (
    FROM ('2025-01-01') TO ('2027-01-01') INTERVAL 1 MONTH
);

-- ============================================================
-- ODS 层: 集团数据 + 市场分析
-- ============================================================

CREATE TABLE indicator_ods.ods_grp_unit_output (
    id              BIGINT,
    tenant_id       BIGINT,
    unit_id         VARCHAR(32),
    trade_date      DATE,
    time_id         INT,
    actual_output   DECIMAL(18,4)   COMMENT '实际出力',
    __etl_time      DATETIME
)
UNIQUE KEY(id, tenant_id, trade_date, time_id)
DISTRIBUTED BY HASH(tenant_id) BUCKETS 4
PARTITION BY RANGE(trade_date) (
    FROM ('2025-01-01') TO ('2027-01-01') INTERVAL 1 MONTH
);

CREATE TABLE indicator_ods.ods_mkt_netload (
    id              BIGINT,
    tenant_id       BIGINT,
    trade_date      DATE,
    time_id         INT,
    net_load        DECIMAL(18,4)   COMMENT '净负荷(竞价空间)',
    __etl_time      DATETIME
)
UNIQUE KEY(id, tenant_id, trade_date, time_id)
DISTRIBUTED BY HASH(tenant_id) BUCKETS 4
PARTITION BY RANGE(trade_date) (
    FROM ('2025-01-01') TO ('2027-01-01') INTERVAL 1 MONTH
);

-- ============================================================
-- ODS 层: 算法预测
-- ============================================================

-- 算法预测电价
CREATE TABLE indicator_ods.ods_algo_forecast_clearing (
    id              BIGINT,
    tenant_id       BIGINT,
    unit_id         VARCHAR(32),
    trade_date      DATE,
    time_id         INT,
    forecast_price  DECIMAL(18,4)   COMMENT '预测电价(元/MWh)',
    create_time     DATETIME,
    __etl_time      DATETIME
)
UNIQUE KEY(id, tenant_id, trade_date, time_id)
DISTRIBUTED BY HASH(tenant_id) BUCKETS 4
PARTITION BY RANGE(trade_date) (
    FROM ('2025-01-01') TO ('2027-01-01') INTERVAL 1 MONTH
);

-- ============================================================
-- ODS 层: 成本管理（补充固定成本）
-- ============================================================

-- 机组月度固定成本
CREATE TABLE indicator_ods.ods_cost_fixed_monthly (
    id              BIGINT,
    tenant_id       BIGINT,
    unit_id         VARCHAR(32),
    trade_month     VARCHAR(7)      COMMENT '月份 yyyy-MM',
    fixed_cost      DECIMAL(18,4)   COMMENT '固定成本(元/月)',
    create_time     DATETIME,
    __etl_time      DATETIME
)
UNIQUE KEY(id, tenant_id, trade_month)
DISTRIBUTED BY HASH(tenant_id) BUCKETS 4;
```

### 4.3 ODS 表汇总

| ODS 表名 | 源库 | 源表 | 分区键 | 指标数 |
|----------|------|------|--------|--------|
| ods_spot_ahead_trade | bdss_spot_market | spot_ahead_trade | trade_date | 3 |
| ods_spot_real_trade | bdss_spot_market | spot_real_trade | trade_date | 3 |
| ods_spot_inter_province_declare | bdss_spot_market | spot_sjxh_...declare | trade_date | 2 |
| ods_spot_inter_province_result | bdss_spot_market | spot_sjxh_...result | trade_date | 2 |
| ods_txm_contract_match_month | bdss_transaction_manage | trxn_contract_match_month | trade_date | 4 |
| ods_sett_power_hour_unit | bdss_settlement_manage | sett_power_hour_unit | trade_date | 1 |
| ods_sett_base_subject | bdss_settlement_manage | sett_base_subject | trade_date | 4 |
| ods_sett_unit_bill_day | bdss_settlement_manage | sett_unit_bill_day | trade_date | 1 |
| ods_bas_unit | bdss_basic_parameter | bas_unit | — (维度表) | 5 |
| ods_cost_unit_curve | bdss_cost_manage | cost_unit_curve | trade_date | 1 |
| ods_cost_fixed_monthly | bdss_cost_manage | cost_fixed_monthly | — (月粒度) | 1 |
| ods_grp_unit_output | bdss_group_data | ha_ssfdjh | trade_date | 1 |
| ods_mkt_netload | bdss_market_analysis | mkt_netload | trade_date | 1 |
| ods_algo_forecast_clearing | bdss_algorithm_manage | algo_price_forecast_clearing | trade_date | 1 |
| **合计 14 张** | **8 个源库** | | | **30** |

---

## 五、DWD 层设计 (Data Warehouse Detail) — 按业务域建模

### 5.1 设计原则

- **按业务域建模**: 对齐 199 指标的 12 个 category_l1，每域一张宽表
- **统一粒度**: 每条记录 = 一个机组 × 一个时间点(1-96) × 一个交易日
- **维度关联**: 所有 DWD 表通过 `dwd_unit_param` 补充 plant_id, group_code
- **标准化字段**: 统一用 `energy`/`price`/`fee`/`capacity`/`rate` 语义
- **覆盖全量**: 10 张 DWD 表覆盖 199 个指标全部所需原始数据

### 5.2 DWD 表与业务域映射

| DWD 表 | 业务域 (category_l1) | 指标数 | 来源 ODS | 类型 |
|--------|----------------------|--------|----------|------|
| dwd_energy_detail | 电量 (35) | 35 | spot_ahead/real, txm_contract, sett_power | 原始 |
| dwd_price_detail | 电价 (34) | 34 | spot_ahead/real, txm_contract, cost, algo_forecast | 原始 |
| dwd_fee_detail | 电费 (44) | 44 | sett_base_subject, sett_unit_bill_day + 公式计算 | 混合 |
| dwd_margin_detail | 边际贡献 (16) | 16 | 由 fee + cost 联合计算 | 计算 |
| dwd_aux_detail | 辅助服务 (12) | 12 | sett_base_subject (科目拆分) | 原始 |
| dwd_green_detail | 绿证/绿电 (9) | 9 | 外部系统同步 | 原始 |
| dwd_capacity_detail | 容量 (6) | 6 | bas_unit, 外部 | 原始 |
| dwd_cost_detail | 成本 (4) | 4 | cost_unit_curve, cost_fixed_monthly | 原始 |
| dwd_loadrate_detail | 负荷率/覆盖率 (10) | 10 | 由 energy + unit_param 计算 | 计算 |
| dwd_unit_param | 维度 (机组参数) | 5 | bas_unit | 原始 |
| dwd_inter_province_detail | 省间交易 (4) | 4 | spot_inter_province_declare/result | 原始 |
| **合计 11 张** | **12 个域全覆盖** | **199** | | |

### 5.3 DWD DDL

```sql
-- ============================================================
-- DWD: 机组参数维度表 (所有DWD表的外键)
-- ============================================================
CREATE TABLE indicator_dwd.dwd_unit_param (
    tenant_id       BIGINT          COMMENT '租户ID',
    unit_id         VARCHAR(32)     COMMENT '机组ID',
    unit_name       VARCHAR(64)     COMMENT '机组名称',
    plant_id        VARCHAR(32)     COMMENT '电厂ID',
    plant_name      VARCHAR(64)     COMMENT '电厂名称',
    group_code      VARCHAR(32)     COMMENT '二级公司编码',
    group_name      VARCHAR(64)     COMMENT '二级公司名称',
    province_code   VARCHAR(8)      COMMENT '省网编码',
    rated_capacity  DECIMAL(10,2)   COMMENT '额定容量(MW)',
    min_output      DECIMAL(10,2)   COMMENT '最小技术出力(MW)',
    aux_rate        DECIMAL(5,4)    COMMENT '厂用电率',
    installed_cap   DECIMAL(10,2)   COMMENT '装机容量(MW)',
    effective_cap   DECIMAL(10,2)   COMMENT '有效容量(MW)',
    __etl_time      DATETIME
)
UNIQUE KEY(tenant_id, unit_id)
DISTRIBUTED BY HASH(tenant_id) BUCKETS 4;

-- ============================================================
-- DWD 1: 电量明细表 (覆盖35个电量指标)
-- ============================================================
-- 来源: ODS 现货出清 + 合约匹配 + 上网电量 + 省间申报 + 集团发电 + 市场分析
-- 粒度: 机组 × 交易日 × 时间点(1-96)
CREATE TABLE indicator_dwd.dwd_energy_detail (
    tenant_id       BIGINT          COMMENT '租户ID',
    unit_id         VARCHAR(32)     COMMENT '机组ID',
    unit_name       VARCHAR(64)     COMMENT '机组名称',
    plant_id        VARCHAR(32)     COMMENT '电厂ID',
    group_code      VARCHAR(32)     COMMENT '二级公司',
    trade_date      DATE            COMMENT '交易日期',
    time_id         INT             COMMENT '时间点(1-96)',

    -- 中长期电量
    base_energy     DECIMAL(18,4)   COMMENT '基数电量(MWh)',
    mlt_energy      DECIMAL(18,4)   COMMENT '中长期电量(MWh)',

    -- 现货电量
    dam_energy      DECIMAL(18,4)   COMMENT '日前出清电量(MWh)',
    rtm_energy      DECIMAL(18,4)   COMMENT '实时出清电量(MWh)',

    -- 物理电量
    online_energy   DECIMAL(18,4)   COMMENT '上网电量(MWh)',
    actual_output   DECIMAL(18,4)   COMMENT '实际出力(MW)',

    -- 竞价空间
    bidding_space   DECIMAL(18,4)   COMMENT '竞价空间(MW)',

    __etl_time      DATETIME
)
DUPLICATE KEY(tenant_id, unit_id, trade_date, time_id)
DISTRIBUTED BY HASH(tenant_id, unit_id) BUCKETS 16
PARTITION BY RANGE(trade_date) (
    FROM ('2025-01-01') TO ('2027-01-01') INTERVAL 1 MONTH
);

-- ============================================================
-- DWD 2: 电价明细表 (覆盖33个电价指标)
-- ============================================================
-- 来源: ODS 现货出清 + 合约匹配 + 成本 + 省间结果 + 算法预测
-- 粒度: 机组 × 交易日 × 时间点(1-96)
CREATE TABLE indicator_dwd.dwd_price_detail (
    tenant_id       BIGINT,
    unit_id         VARCHAR(32),
    unit_name       VARCHAR(64),
    plant_id        VARCHAR(32),
    group_code      VARCHAR(32),
    trade_date      DATE,
    time_id         INT,

    -- 中长期电价
    base_price      DECIMAL(18,4)   COMMENT '基数电价(元/MWh)',
    mlt_price       DECIMAL(18,4)   COMMENT '中长期电价(元/MWh)',

    -- 现货电价
    dam_price       DECIMAL(18,4)   COMMENT '日前出清电价(元/MWh)',
    rtm_price       DECIMAL(18,4)   COMMENT '实时出清电价(元/MWh)',

    -- 成本价
    var_cost_price  DECIMAL(18,4)   COMMENT '单位变动成本(元/MWh)',
    benchmark_price DECIMAL(18,4)   COMMENT '基准电价(元/MWh)',

    -- 算法预测
    algo_forecast_price DECIMAL(18,4) COMMENT '算法预测电价(元/MWh)',

    -- 省间电价
    int_dam_price   DECIMAL(18,4)   COMMENT '省间日前电价(元/MWh)',
    int_rtm_price   DECIMAL(18,4)   COMMENT '省间实时电价(元/MWh)',

    __etl_time      DATETIME
)
DUPLICATE KEY(tenant_id, unit_id, trade_date, time_id)
DISTRIBUTED BY HASH(tenant_id, unit_id) BUCKETS 16
PARTITION BY RANGE(trade_date) (
    FROM ('2025-01-01') TO ('2027-01-01') INTERVAL 1 MONTH
);

-- ============================================================
-- DWD 3: 电费明细表 (覆盖44个电费指标)
-- ============================================================
-- 来源: ODS 合约电费 + 结算科目 + 结算日账单 + 计算层派生
-- 粒度: 机组 × 交易日 × 时间点(1-96)
CREATE TABLE indicator_dwd.dwd_fee_detail (
    tenant_id       BIGINT,
    unit_id         VARCHAR(32),
    unit_name       VARCHAR(64),
    plant_id        VARCHAR(32),
    group_code      VARCHAR(32),
    trade_date      DATE,
    time_id         INT,

    -- 合约电费
    base_fee        DECIMAL(18,4)   COMMENT '基数电费(元)',
    mlt_fee         DECIMAL(18,4)   COMMENT '中长期电费(元)',

    -- 现货电费 (由 energy×price 计算)
    dam_full_fee    DECIMAL(18,4)   COMMENT '日前全量电费(元)',
    rtm_full_fee    DECIMAL(18,4)   COMMENT '实时全量电费(元)',

    -- 偏差电费
    dam_dev_pos_fee DECIMAL(18,4)   COMMENT '日前正偏差电费(元)',
    dam_dev_neg_fee DECIMAL(18,4)   COMMENT '日前负偏差电费(元)',
    rtm_dev_pos_fee DECIMAL(18,4)   COMMENT '实时正偏差电费(元)',
    rtm_dev_neg_fee DECIMAL(18,4)   COMMENT '实时负偏差电费(元)',

    -- 差价合约
    cfd_long_fee    DECIMAL(18,4)   COMMENT '差价合约多头(元)',
    cfd_short_fee   DECIMAL(18,4)   COMMENT '差价合约空头(元)',

    -- 汇总
    total_electric_fee DECIMAL(18,4) COMMENT '总电费(元)',
    spot_full_fee   DECIMAL(18,4)   COMMENT '现货总电费(元)',

    -- 结算
    sett_total_fee  DECIMAL(18,4)   COMMENT '结算总电费(元)',

    __etl_time      DATETIME
)
DUPLICATE KEY(tenant_id, unit_id, trade_date, time_id)
DISTRIBUTED BY HASH(tenant_id, unit_id) BUCKETS 16
PARTITION BY RANGE(trade_date) (
    FROM ('2025-01-01') TO ('2027-01-01') INTERVAL 1 MONTH
);

-- ============================================================
-- DWD 4: 边际贡献明细表 (覆盖16个边际贡献指标)
-- ============================================================
-- 来源: 由 dwd_fee_detail + dwd_price_detail + dwd_cost_detail 联合计算
-- 粒度: 机组 × 交易日 × 时间点(1-96)
CREATE TABLE indicator_dwd.dwd_margin_detail (
    tenant_id       BIGINT,
    unit_id         VARCHAR(32),
    unit_name       VARCHAR(64),
    plant_id        VARCHAR(32),
    group_code      VARCHAR(32),
    trade_date      DATE,
    time_id         INT,

    -- 变动成本
    var_cost        DECIMAL(18,4)   COMMENT '变动成本(元)',
    var_cost_price  DECIMAL(18,4)   COMMENT '单位变动成本(元/MWh)',

    -- 边际贡献
    total_margin    DECIMAL(18,4)   COMMENT '总边际贡献(元)',
    unit_margin     DECIMAL(18,4)   COMMENT '单位边际贡献(元/MWh)',
    margin_rate     DECIMAL(18,4)   COMMENT '边际贡献率(%)',

    -- 分项边际贡献
    contract_margin DECIMAL(18,4)   COMMENT '合约边际贡献(元)',
    spot_margin     DECIMAL(18,4)   COMMENT '现货边际贡献(元)',
    dam_margin      DECIMAL(18,4)   COMMENT '日前边际贡献(元)',
    rtm_margin      DECIMAL(18,4)   COMMENT '实时边际贡献(元)',

    __etl_time      DATETIME
)
DUPLICATE KEY(tenant_id, unit_id, trade_date, time_id)
DISTRIBUTED BY HASH(tenant_id, unit_id) BUCKETS 8
PARTITION BY RANGE(trade_date) (
    FROM ('2025-01-01') TO ('2027-01-01') INTERVAL 1 MONTH
);

-- ============================================================
-- DWD 5: 辅助服务明细表 (覆盖12个辅助服务指标)
-- ============================================================
-- 来源: ODS sett_base_subject (按科目拆分)
-- 粒度: 机组 × 交易日
CREATE TABLE indicator_dwd.dwd_aux_detail (
    tenant_id       BIGINT,
    unit_id         VARCHAR(32),
    unit_name       VARCHAR(64),
    plant_id        VARCHAR(32),
    group_code      VARCHAR(32),
    trade_date      DATE,

    -- 调频
    freq_clearing_energy DECIMAL(18,4) COMMENT '调频出清电量(MWh)',
    freq_assess_fee DECIMAL(18,4)  COMMENT '调频考核费(元)',
    freq_return_fee DECIMAL(18,4)  COMMENT '调频返还费(元)',

    -- 备用
    reserve_clearing_energy DECIMAL(18,4) COMMENT '备用出清电量(MWh)',
    reserve_assess_fee DECIMAL(18,4) COMMENT '备用考核费(元)',
    reserve_return_fee DECIMAL(18,4) COMMENT '备用返还费(元)',

    -- 汇总
    aux_total_assess DECIMAL(18,4) COMMENT '辅助考核总费(元)',
    aux_total_return DECIMAL(18,4) COMMENT '辅助返还总费(元)',
    aux_total_share  DECIMAL(18,4) COMMENT '辅助分摊总费(元)',
    aux_total_compensate DECIMAL(18,4) COMMENT '辅助补偿总费(元)',
    aux_net_fee      DECIMAL(18,4) COMMENT '辅助服务净收入(元)',

    __etl_time      DATETIME
)
DUPLICATE KEY(tenant_id, unit_id, trade_date)
DISTRIBUTED BY HASH(tenant_id, unit_id) BUCKETS 8
PARTITION BY RANGE(trade_date) (
    FROM ('2025-01-01') TO ('2027-01-01') INTERVAL 1 MONTH
);

-- ============================================================
-- DWD 6: 绿色权益明细表 (覆盖9个绿证/绿电指标)
-- ============================================================
-- 来源: 外部系统同步 (绿证交易平台)
-- 粒度: 机组 × 月
CREATE TABLE indicator_dwd.dwd_green_detail (
    tenant_id       BIGINT,
    unit_id         VARCHAR(32),
    unit_name       VARCHAR(64),
    plant_id        VARCHAR(32),
    group_code      VARCHAR(32),
    trade_month     VARCHAR(7)      COMMENT '月份 yyyy-MM',

    -- 绿证
    cert_issue_count INT            COMMENT '绿证核发量(个)',
    cert_grant_count INT            COMMENT '绿证补贴量(个)',
    cert_trade_vol   INT            COMMENT '绿证交易量(个)',
    cert_price       DECIMAL(18,4)  COMMENT '绿证价格(元/个)',
    cert_fee         DECIMAL(18,4)  COMMENT '绿证费用(元)',

    -- 绿电
    green_energy     DECIMAL(18,4)  COMMENT '绿电交易电量(MWh)',
    green_price      DECIMAL(18,4)  COMMENT '绿电交易电价(元/MWh)',
    green_fee        DECIMAL(18,4)  COMMENT '绿电交易电费(元)',

    __etl_time      DATETIME
)
UNIQUE KEY(tenant_id, unit_id, trade_month)
DISTRIBUTED BY HASH(tenant_id) BUCKETS 4;

-- ============================================================
-- DWD 7: 容量市场明细表 (覆盖6个容量指标)
-- ============================================================
-- 来源: ODS bas_unit + 外部系统
-- 粒度: 机组 × 月
CREATE TABLE indicator_dwd.dwd_capacity_detail (
    tenant_id       BIGINT,
    unit_id         VARCHAR(32),
    unit_name       VARCHAR(64),
    plant_id        VARCHAR(32),
    group_code      VARCHAR(32),
    trade_month     VARCHAR(7),

    -- 容量
    installed_cap   DECIMAL(10,2)   COMMENT '装机容量(MW)',
    effective_cap   DECIMAL(10,2)   COMMENT '有效容量(MW)',
    capacity_price  DECIMAL(18,4)   COMMENT '容量电价(元/MW·月)',
    capacity_fee    DECIMAL(18,4)   COMMENT '容量电费(元/月)',
    capacity_income DECIMAL(18,4)   COMMENT '容量收益(元/月)',

    __etl_time      DATETIME
)
UNIQUE KEY(tenant_id, unit_id, trade_month)
DISTRIBUTED BY HASH(tenant_id) BUCKETS 4;

-- ============================================================
-- DWD 8: 成本明细表 (覆盖4个成本指标)
-- ============================================================
-- 来源: ODS cost_unit_curve
-- 粒度: 机组 × 交易日 × 时间点(1-96)
CREATE TABLE indicator_dwd.dwd_cost_detail (
    tenant_id       BIGINT,
    unit_id         VARCHAR(32),
    unit_name       VARCHAR(64),
    plant_id        VARCHAR(32),
    group_code      VARCHAR(32),
    trade_date      DATE,
    time_id         INT,

    var_cost_price  DECIMAL(18,4)   COMMENT '单位变动成本(元/MWh)',
    var_cost_total  DECIMAL(18,4)   COMMENT '变动成本合计(元)',
    fixed_cost      DECIMAL(18,4)   COMMENT '固定成本(元/月)',

    __etl_time      DATETIME
)
DUPLICATE KEY(tenant_id, unit_id, trade_date, time_id)
DISTRIBUTED BY HASH(tenant_id, unit_id) BUCKETS 4
PARTITION BY RANGE(trade_date) (
    FROM ('2025-01-01') TO ('2027-01-01') INTERVAL 1 MONTH
);

-- ============================================================
-- DWD 9: 负荷率/覆盖率明细表 (覆盖10个指标)
-- ============================================================
-- 来源: 由 dwd_energy_detail + dwd_unit_param 计算派生
-- 粒度: 机组 × 交易日
CREATE TABLE indicator_dwd.dwd_loadrate_detail (
    tenant_id       BIGINT,
    unit_id         VARCHAR(32),
    unit_name       VARCHAR(64),
    plant_id        VARCHAR(32),
    group_code      VARCHAR(32),
    trade_date      DATE,

    -- 负荷率
    load_rate       DECIMAL(5,2)    COMMENT '负荷率(%)',
    peak_load_rate  DECIMAL(5,2)    COMMENT '峰负荷率(%)',
    valley_load_rate DECIMAL(5,2)   COMMENT '谷负荷率(%)',
    avg_load_rate   DECIMAL(5,2)    COMMENT '平均负荷率(%)',

    -- 覆盖率
    contract_coverage DECIMAL(5,2)  COMMENT '合约覆盖率(%)',
    spot_ratio      DECIMAL(5,2)    COMMENT '现货占比(%)',

    -- 利用小时
    utilization_hours DECIMAL(8,2)  COMMENT '利用小时数(h)',
    equivalent_hours DECIMAL(8,2)   COMMENT '等效利用小时(h)',

    __etl_time      DATETIME
)
DUPLICATE KEY(tenant_id, unit_id, trade_date)
DISTRIBUTED BY HASH(tenant_id, unit_id) BUCKETS 8
PARTITION BY RANGE(trade_date) (
    FROM ('2025-01-01') TO ('2027-01-01') INTERVAL 1 MONTH
);

-- ============================================================
-- DWD 10: 省间交易明细表 (覆盖4个省间指标)
-- ============================================================
-- 来源: ODS spot_inter_province_declare + spot_inter_province_result
-- 粒度: 省网 × 交易日 × 时间点(1-96)（省级维度，非机组级）
-- 说明: 省间数据无 unit_id 维度，无法并入机组宽表，单独建表
CREATE TABLE indicator_dwd.dwd_inter_province_detail (
    tenant_id       BIGINT          COMMENT '租户ID',
    province_code   VARCHAR(8)      COMMENT '省网编码',
    trade_date      DATE            COMMENT '交易日期',
    time_id         INT             COMMENT '时间点(1-96)',

    -- 省间电量
    int_dam_bid     DECIMAL(18,4)   COMMENT '省间日前申报(MW)',
    int_rtm_bid     DECIMAL(18,4)   COMMENT '省间实时申报(MW)',
    int_dam_energy  DECIMAL(18,4)   COMMENT '省间日前出清电量(MWh)',
    int_rtm_energy  DECIMAL(18,4)   COMMENT '省间实时出清电量(MWh)',

    -- 省间电价
    int_dam_price   DECIMAL(18,4)   COMMENT '省间日前电价(元/MWh)',
    int_rtm_price   DECIMAL(18,4)   COMMENT '省间实时电价(元/MWh)',

    __etl_time      DATETIME
)
DUPLICATE KEY(tenant_id, province_code, trade_date, time_id)
DISTRIBUTED BY HASH(tenant_id, province_code) BUCKETS 8
PARTITION BY RANGE(trade_date) (
    FROM ('2025-01-01') TO ('2027-01-01') INTERVAL 1 MONTH
);
```

### 5.4 DWD/ADS 分层边界

> **分层原则**: DWD 层只存放 ODS 原始数据的标准化宽表，不含公式计算派生值。

| 分类 | DWD 表 | 说明 |
|------|--------|------|
| **原始 DWD (ODS映射)** | dwd_unit_param, dwd_energy_detail, dwd_price_detail, dwd_aux_detail, dwd_green_detail, dwd_capacity_detail, dwd_cost_detail, dwd_inter_province_detail | 字段全部来自 ODS，零计算 |
| **计算 DWD (→ 后续迁移至 ADS)** | dwd_fee_detail, dwd_margin_detail, dwd_loadrate_detail | 含公式引擎计算派生字段，P0 阶段暂时放在 DWD，P1 阶段迁移到 ADS 层 |

**计算表字段溯源**:

| 表 | ODS 原始字段 | 公式计算字段 |
|----|------------|-------------|
| dwd_fee_detail | base_fee, mlt_fee, sett_total_fee | dam_full_fee, rtm_full_fee, dam_dev_*_fee, cfd_*_fee, total_electric_fee, spot_full_fee |
| dwd_margin_detail | (无) | total_margin, unit_margin, margin_rate, contract_margin, spot_margin 等 |
| dwd_loadrate_detail | (无) | load_rate, peak_load_rate, valley_load_rate, contract_coverage, spot_ratio 等 |

**P0 策略**: 保持现有 DDL 不变，公式引擎计算结果写入 dwd_fee/margin/loadrate，先跑通链路。
**P1 策略**: 将计算字段全部迁移到 `ads_indicator_timeseries`，dwd_fee/margin/loadrate 只保留 ODS 原始字段。

### 5.5 DWD 表汇总 (11张，覆盖199指标)

| # | DWD 表 | 粒度 | 分区 | 覆盖域 | 指标数 | 类型 |
|---|--------|------|------|--------|--------|------|
| 1 | dwd_unit_param | 机组 | — | 维度 | 5 | 原始 |
| 2 | dwd_energy_detail | 机组×96点 | 月 | 电量 | 35 | 原始 |
| 3 | dwd_price_detail | 机组×96点 | 月 | 电价 | 34 | 原始 |
| 4 | dwd_fee_detail | 机组×96点 | 月 | 电费 | 44 | 混合 |
| 5 | dwd_margin_detail | 机组×96点 | 月 | 边际贡献 | 16 | 计算 |
| 6 | dwd_aux_detail | 机组×日 | 月 | 辅助服务 | 12 | 原始 |
| 7 | dwd_green_detail | 机组×月 | — | 绿证/绿电 | 9 | 原始 |
| 8 | dwd_capacity_detail | 机组×月 | — | 容量 | 6 | 原始 |
| 9 | dwd_cost_detail | 机组×96点 | 月 | 成本 | 4 | 原始 |
| 10 | dwd_loadrate_detail | 机组×日 | 月 | 负荷率/覆盖率 | 10 | 计算 |
| 11 | dwd_inter_province_detail | 省网×96点 | 月 | 省间交易 | 4 | 原始 |

### 5.6 ODS → DWD 转换逻辑

> **改进**: 原设计使用 6 表 FULL OUTER JOIN，性能风险大且可维护性差。
> 改为分步写入：以最完整的维度表为基础，逐步补充其他来源字段。
> 利用 Doris Aggregate Key 模型自动合并同 key 行。

#### dwd_energy_detail (电量宽表) — 分步写入

```sql
-- Step 1: 以日前出清为基础表（最完整的机组×时间维度）
INSERT INTO indicator_dwd.dwd_energy_detail
    (tenant_id, unit_id, trade_date, time_id, dam_energy, __etl_time)
SELECT tenant_id, unit_id, trade_date, time_id, power, NOW()
FROM indicator_ods.ods_spot_ahead_trade
WHERE trade_date = '${calc_date}';

-- Step 2: 补充实时出清
INSERT INTO indicator_dwd.dwd_energy_detail
    (tenant_id, unit_id, trade_date, time_id, rtm_energy, __etl_time)
SELECT tenant_id, unit_id, trade_date, time_id, power, NOW()
FROM indicator_ods.ods_spot_real_trade
WHERE trade_date = '${calc_date}';

-- Step 3: 补充上网电量
INSERT INTO indicator_dwd.dwd_energy_detail
    (tenant_id, unit_id, trade_date, time_id, online_energy, __etl_time)
SELECT tenant_id, unit_id, trade_date, time_id, online_energy, NOW()
FROM indicator_ods.ods_sett_power_hour_unit
WHERE trade_date = '${calc_date}';

-- Step 4: 补充合约电量
INSERT INTO indicator_dwd.dwd_energy_detail
    (tenant_id, unit_id, trade_date, time_id, base_energy, mlt_energy, __etl_time)
SELECT tenant_id, unit_id, trade_date, time_id, base_energy, mlt_energy, NOW()
FROM indicator_ods.ods_txm_contract_match_month
WHERE trade_date = '${calc_date}';

-- Step 5: 补充实际出力
INSERT INTO indicator_dwd.dwd_energy_detail
    (tenant_id, unit_id, trade_date, time_id, actual_output, __etl_time)
SELECT tenant_id, unit_id, trade_date, time_id, actual_output, NOW()
FROM indicator_ods.ods_grp_unit_output
WHERE trade_date = '${calc_date}';

-- Step 6: 补充竞价空间 + 关联维度
INSERT INTO indicator_dwd.dwd_energy_detail
    (tenant_id, unit_id, trade_date, time_id, bidding_space, __etl_time)
SELECT tenant_id, unit_id, trade_date, time_id, net_load, NOW()
FROM indicator_ods.ods_mkt_netload
WHERE trade_date = '${calc_date}';

-- Step 7: 关联机组维度信息（unit_name, plant_id, group_code）
UPDATE indicator_dwd.dwd_energy_detail e
SET unit_name = u.unit_name, plant_id = u.plant_id, group_code = u.group_code
FROM indicator_dwd.dwd_unit_param u
WHERE e.tenant_id = u.tenant_id AND e.unit_id = u.unit_id
  AND e.trade_date = '${calc_date}';
```

> **注意**: 分步写入需将 dwd_energy_detail 的模型改为 **Aggregate Key**，
> 对相同 (tenant_id, unit_id, trade_date, time_id) 的多次 INSERT 自动合并。

#### dwd_inter_province_detail (省间交易) — 单独写入

```sql
-- 省间数据为省级粒度，写入独立的省间宽表
INSERT INTO indicator_dwd.dwd_inter_province_detail
    (tenant_id, province_code, trade_date, time_id, int_dam_bid, int_rtm_bid, __etl_time)
SELECT tenant_id, province_code, trade_date, time_id, dam_bid_output, rtm_bid_output, NOW()
FROM indicator_ods.ods_spot_inter_province_declare
WHERE trade_date = '${calc_date}';

INSERT INTO indicator_dwd.dwd_inter_province_detail
    (tenant_id, province_code, trade_date, time_id, int_dam_price, int_rtm_price, __etl_time)
SELECT tenant_id, province_code, trade_date, time_id, dam_price, rtm_price, NOW()
FROM indicator_ods.ods_spot_inter_province_result
WHERE trade_date = '${calc_date}';
```

#### dwd_fee_detail (电费宽表)

```sql
-- Layer 3 电费由公式引擎计算后写入 DWD
-- 公式引擎从 dwd_energy_detail + dwd_price_detail 读取原始值
-- 计算结果通过 Java 服务 INSERT 到 dwd_fee_detail
```

#### dwd_margin_detail (边际贡献)

```sql
-- Layer 5 由公式引擎计算
-- 公式: total_margin = total_electric_fee - var_cost
-- 来源: dwd_fee_detail.total_electric_fee + dwd_cost_detail.var_cost_price
```

#### dwd_loadrate_detail (负荷率)

```sql
-- Layer 6 由公式引擎计算
-- 公式: load_rate = actual_output / rated_capacity * 100
-- 来源: dwd_energy_detail.actual_output + dwd_unit_param.rated_capacity
```

---

## 六、ADS 层设计 (Application Data Service)

### 6.1 设计原则

ADS 层即指标应用层，存储公式引擎计算后的最终指标结果，对应现有的 `ind_data_*` 表。

### 6.2 ADS 表 (复用现有设计，迁移到 Doris)

```sql
-- ============================================================
-- ADS: 分时指标数据
-- ============================================================
CREATE TABLE indicator_ads.ads_indicator_timeseries (
    tenant_id       BIGINT,
    indicator_code  VARCHAR(32),
    unit_id         VARCHAR(32),
    unit_name       VARCHAR(64),
    plant_id        VARCHAR(32),
    group_code      VARCHAR(32),
    trade_date      DATE,
    time_id         INT             COMMENT '时间点(1-96), 日/月=0',
    value           DECIMAL(18,4),
    data_type       INT             COMMENT '1=实际 2=预测 3=计划',
    calc_time       DATETIME
)
DUPLICATE KEY(tenant_id, indicator_code, unit_id, trade_date, time_id)
DISTRIBUTED BY HASH(tenant_id, indicator_code) BUCKETS 16
PARTITION BY RANGE(trade_date) (
    FROM ('2025-01-01') TO ('2027-01-01') INTERVAL 1 MONTH
)
PROPERTIES ("replication_num" = "1");

-- ============================================================
-- ADS: 日维度指标
-- ============================================================
CREATE TABLE indicator_ads.ads_indicator_daily (
    tenant_id       BIGINT,
    indicator_code  VARCHAR(32),
    unit_id         VARCHAR(32),
    unit_name       VARCHAR(64),
    plant_id        VARCHAR(32),
    group_code      VARCHAR(32),
    trade_date      DATE,
    value           DECIMAL(18,4),
    min_value       DECIMAL(18,4),
    max_value       DECIMAL(18,4),
    avg_value       DECIMAL(18,4),
    calc_time       DATETIME
)
AGGREGATE KEY(tenant_id, indicator_code, unit_id, trade_date)
DISTRIBUTED BY HASH(tenant_id, indicator_code) BUCKETS 16
PARTITION BY RANGE(trade_date) (
    FROM ('2025-01-01') TO ('2027-01-01') INTERVAL 1 MONTH
);

-- ============================================================
-- ADS: 月维度指标
-- ============================================================
CREATE TABLE indicator_ads.ads_indicator_monthly (
    tenant_id       BIGINT,
    indicator_code  VARCHAR(32),
    unit_id         VARCHAR(32),
    trade_month     VARCHAR(7),
    value           DECIMAL(18,4),
    year_cumulative DECIMAL(18,4),
    calc_time       DATETIME
)
AGGREGATE KEY(tenant_id, indicator_code, unit_id, trade_month)
DISTRIBUTED BY HASH(tenant_id, indicator_code) BUCKETS 8;
```

### 6.3 ADS 指标元数据 (保留在 PostgreSQL)

```sql
-- 元数据表保留在 PostgreSQL (变更频率低、需要事务)
-- ind_indicator_def     指标定义
-- ind_calc_formula      计算公式
-- ind_data_source       数据源映射 → 改为映射到 DWD 表
-- ind_dimension         维度定义
-- ind_indicator_dimension 指标维度关联
-- ind_calc_task_log     计算任务日志
-- ind_calc_detail_log   计算明细日志
-- ind_dimension_entity  维度实体
```

---

## 七、计算流程改造

### 7.1 改造前后对比

```
【改造前】
各业务库 → @DS动态切换 → Java动态SQL → ind_data_timeseries (PG)
                         │
                         └─ 每次计算都要跨库查询

【改造后】
各业务库 → Flink CDC → ODS(Doris) → SQL转换 → DWD(Doris)
                                                    │
                                          Java公式引擎读DWD
                                                    │
                                          ADS(Doris) ← 计算结果写回
                                                    │
                                          Java查询服务 ← 前端调用
```

### 7.2 Java 服务改造要点

**DataExtractService 改造**:
```java
// 改造前: 动态SQL跨库查询
@DS("spot_market")
public List<Map<String, Object>> extractRawData(...) { ... }

// 改造后: 查询 Doris DWD 层
@Service
public class DataExtractService {

    @Autowired
    private JdbcTemplate dorisJdbcTemplate;  // Doris JDBC

    /**
     * 从 DWD 层读取原始指标数据
     */
    public Map<String, BigDecimal> loadDwdData(String indicatorCode,
                                                LocalDate date, String unitId,
                                                Long tenantId) {
        // 直接查询 dwd_energy_detail 等宽表
        String sql = "SELECT dam_energy, dam_price, rtm_energy, rtm_price, online_energy " +
                     "FROM indicator_dwd.dwd_energy_detail " +
                     "WHERE tenant_id = ? AND unit_id = ? AND trade_date = ? AND time_id = ?";
        return dorisJdbcTemplate.queryForObject(sql, ...);
    }
}
```

**新增配置**:
```yaml
# application.yml 新增 Doris 数据源
spring:
  datasource:
    dynamic:
      datasource:
        # ... 原有10个业务库保留 (ODS ETL 用)
        doris:
          url: jdbc:mysql://192.168.31.123:9030/indicator_dwd
          username: root
          password:
          driver-class-name: com.mysql.cj.jdbc.Driver
```

### 7.3 数据同步方案

| 方案 | 适用场景 | 延迟 | 复杂度 |
|------|----------|------|--------|
| **Flink CDC** | 实时同步 | 秒级 | 高 |
| **Stream Load** | 批量导入 | 分钟级 | 中 |
| **Broker Load** | 大批量离线 | 小时级 | 低 |

**P0 推荐方案: Stream Load + 定时调度**

```bash
# 定时同步脚本 (每日执行)
# 1. 从 MySQL 源表导出当天数据
mysql -h 10.60.64.219 -e "SELECT * FROM spot_ahead_trade WHERE trade_date = CURDATE()-1" > /tmp/spot_ahead.csv

# 2. Stream Load 写入 Doris ODS
curl --location-trusted -u root: \
    -H "column_separator:," \
    -T /tmp/spot_ahead.csv \
    http://192.168.31.123:8040/api/indicator_ods/ods_spot_ahead_trade/_stream_load
```

### 7.4 计算编排改造

```java
// IndicatorCalcService.java 改造
public CalcTaskLog calcDaily(LocalDate date, Long tenantId, String singleCode) {
    // 1. 创建任务日志
    CalcTaskLog taskLog = createTaskLog(date);

    // 2. 确认 ODS 数据已同步 (检查 __etl_time)
    verifyOdsReady(date, tenantId);

    // 3. 执行 ODS → DWD 转换 (Doris SQL)
    executeDwdTransform(date, tenantId);

    // 4. 从 DWD 加载 Layer 0 原始数据 (查 Doris)
    CalcContext ctx = loadFromDwd(date, tenantId);

    // 5. 逐层计算 Layer 1-3 (Java 公式引擎)
    executeCalcLayers(ctx, date, tenantId);

    // 6. 结果写入 ADS (Doris Stream Load / INSERT)
    saveToAds(ctx, date, tenantId);

    // 7. 日聚合 ADS timeseries → daily
    executeAdsAggregation(date, tenantId);

    // 8. 刷新 Redis 缓存
    cacheService.refreshAll(date, tenantId);

    return taskLog;
}
```

---

## 八、技术栈变更

### 改造前后对比

| 组件 | 改造前 | 改造后 |
|------|--------|--------|
| 指标数据存储 | PostgreSQL 分区表 | **Apache Doris** |
| 元数据存储 | PostgreSQL | PostgreSQL (不变) |
| 数据同步 | @DS 动态跨库 | **Flink CDC / Stream Load** |
| 数据查询 | MyBatis Plus | **Doris SQL (JDBC)** |
| 公式计算 | Java 公式引擎 | Java 公式引擎 (不变) |
| 缓存 | Redis | Redis (不变) |
| 新增依赖 | — | doris-jdbc, flink (可选) |

### pom.xml 新增依赖

```xml
<!-- Doris JDBC (兼容 MySQL 协议) -->
<dependency>
    <groupId>com.mysql</groupId>
    <artifactId>mysql-connector-j</artifactId>
    <scope>runtime</scope>
</dependency>
```

---

## 九、数据量估算

> 以下估算基于：12台机组/省网，90个P0指标，96个时间点。

### 单个省网、1年数据量

| 表 | 行数/天 | 行数/年 | 单行大小 | 年存储 |
|----|---------|---------|----------|--------|
| dwd_energy_detail | 12×96 = 1,152 | 420,480 | 120B | ~50MB |
| dwd_price_detail | 1,152 | 420,480 | 100B | ~42MB |
| dwd_fee_detail | 1,152 | 420,480 | 150B | ~63MB |
| dwd_cost_detail | 1,152 | 420,480 | 60B | ~25MB |
| dwd_inter_province_detail | 1×96 = 96 | 35,040 | 80B | ~2.8MB |
| ads_indicator_timeseries | 90×96×12 = 103,680 | 37.8M | 80B | ~3GB |
| ads_indicator_daily | 90×12 = 1,080 | 394,200 | 80B | ~32MB |
| ads_indicator_monthly | 90×12 = 1,080 | 12,960 | 60B | ~0.8MB |

### 10个省网、3年数据量

| 表 | 总行数 | 压缩后存储 |
|----|--------|-----------|
| ODS 全量 (14张) | ~50M | ~5GB |
| DWD 全量 (11张) | ~40M | ~4GB |
| ADS 全量 (3张) | ~1.2B | ~30GB |
| **合计** | **~1.3B** | **~40GB** |

Doris 列存储压缩比约 3:1，40GB 磁盘完全可承受。

---

## 九B、PostgreSQL / Doris 双写策略

> 引入 Doris 后，指标数据存储面临 PostgreSQL 和 Doris 双写问题，需明确策略。

### 策略：PostgreSQL 仅保留元数据，指标数据全部迁移到 Doris

| 数据类别 | 存储位置 | 说明 |
|---------|---------|------|
| 指标定义 (ind_indicator_def) | PostgreSQL | 元数据，需要事务，低频变更 |
| 公式配置 (ind_calc_formula) | PostgreSQL | 元数据，需要事务 |
| 数据源映射 (ind_data_source) | PostgreSQL | 元数据，改为映射到 DWD 表 |
| 维度 (ind_dimension 等) | PostgreSQL | 元数据，需要事务 |
| 计算日志 (ind_calc_task/detail_log) | PostgreSQL | 运行日志，需要事务 |
| **分时数据 (ind_data_timeseries)** | **废弃 → ads_indicator_timeseries (Doris)** | 不再双写 |
| **日数据 (ind_data_daily)** | **废弃 → ads_indicator_daily (Doris)** | 不再双写 |
| **月数据 (ind_data_monthly)** | **废弃 → ads_indicator_monthly (Doris)** | 不再双写 |

**迁移步骤**：
1. P0 阶段：Java 服务改为查询 Doris ADS 层，PostgreSQL 的 `ind_data_*` 表停止写入
2. 保留 PostgreSQL 的 `ind_data_*` DDL 不删除，作为回滚兜底
3. Java 查询层通过 `@DS("doris")` 切换数据源，MyBatis Mapper 的 SQL 语法保持兼容（Doris 兼容 MySQL 协议）

**数据源类型说明**：
- 现有业务库均为 **PostgreSQL** (192.168.31.123:5433)
- Doris 使用 **MySQL 协议** (端口 9030)
- ODS 同步方式：从 PostgreSQL 导出 → Stream Load 写入 Doris（非 Flink CDC MySQL 连接器）

---

## 十、P0 实施计划

### Phase 1: Doris 环境搭建 (2天)

- [ ] 部署 Doris FE + BE (Docker Compose)
- [ ] 创建 indicator_ods / indicator_dwd / indicator_ads 三个库
- [ ] 执行 ODS DDL (14张表)
- [ ] 执行 DWD DDL (11张表)
- [ ] 执行 ADS DDL (3张表)
- [ ] 验证 Stream Load 导入

### Phase 2: 数据同步 (3天)

- [ ] 编写 14 个 ODS 表的同步脚本 (PostgreSQL → Doris)
- [ ] 编写 ODS → DWD 转换 SQL (分步写入)
- [ ] 定时调度: 每日凌晨 1:00 执行同步
- [ ] 验证: ODS + DWD 数据完整

### Phase 3: Java 服务改造 (5天)

- [ ] 新增 Doris 数据源配置
- [ ] 改造 DataExtractService: 查询 DWD 而非跨库
- [ ] 改造 IndicatorCalcService: 结果写入 ADS
- [ ] 集成公式引擎
- [ ] 改造 AggregateService: ADS 内 SQL 聚合

### Phase 4: 前端 + 联调 (5天)

- [ ] 看板页 + 查询页 (不变)
- [ ] API 层改为查询 Doris ADS
- [ ] 全链路联调验证

**总计: 15 个工作日 (3周)**
