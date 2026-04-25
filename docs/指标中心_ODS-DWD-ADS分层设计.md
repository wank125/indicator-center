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
| ods_grp_unit_output | bdss_group_data | ha_ssfdjh | trade_date | 1 |
| ods_mkt_netload | bdss_market_analysis | mkt_netload | trade_date | 1 |
| **合计 12 张** | **7 个源库** | | | **28** |

---

## 五、DWD 层设计 (Data Warehouse Detail)

### 5.1 设计原则

- **统一语义**: 将 ODS 的不同字段名标准化为 `energy`/`price`/`fee`/`capacity`
- **统一粒度**: 每条记录 = 一个机组 × 一个时间点 × 一个交易日
- **维度关联**: 关联 `ods_bas_unit` 补充 plant_id, group_code
- **去除冗余**: 合并同源多指标为一张宽表

### 5.2 DWD 表设计

```sql
-- ============================================================
-- DWD: 统一出清明细表 (日前+实时合并)
-- ============================================================
CREATE TABLE indicator_dwd.dwd_clearing_detail (
    tenant_id       BIGINT          COMMENT '租户ID',
    unit_id         VARCHAR(32)     COMMENT '机组ID',
    unit_name       VARCHAR(64)     COMMENT '机组名称',
    plant_id        VARCHAR(32)     COMMENT '电厂ID',
    group_code      VARCHAR(32)     COMMENT '二级公司编码',
    trade_date      DATE            COMMENT '交易日期',
    time_id         INT             COMMENT '时间点(1-96)',
    dam_energy      DECIMAL(18,4)   COMMENT '日前出清电量',
    dam_price       DECIMAL(18,4)   COMMENT '日前出清电价',
    rtm_energy      DECIMAL(18,4)   COMMENT '实时出清电量',
    rtm_price       DECIMAL(18,4)   COMMENT '实时出清电价',
    online_energy   DECIMAL(18,4)   COMMENT '上网电量',
    __etl_time      DATETIME
)
DUPLICATE KEY(tenant_id, unit_id, trade_date, time_id)
DISTRIBUTED BY HASH(tenant_id, unit_id) BUCKETS 16
PARTITION BY RANGE(trade_date) (
    FROM ('2025-01-01') TO ('2027-01-01') INTERVAL 1 MONTH
)
PROPERTIES ("replication_num" = "1");

-- ============================================================
-- DWD: 合约明细表
-- ============================================================
CREATE TABLE indicator_dwd.dwd_contract_detail (
    tenant_id       BIGINT,
    unit_id         VARCHAR(32),
    unit_name       VARCHAR(64),
    plant_id        VARCHAR(32),
    group_code      VARCHAR(32),
    trade_date      DATE,
    time_id         INT,
    base_energy     DECIMAL(18,4)   COMMENT '基数电量',
    base_price      DECIMAL(18,4)   COMMENT '基数电价',
    mlt_energy      DECIMAL(18,4)   COMMENT '中长期电量',
    mlt_price       DECIMAL(18,4)   COMMENT '中长期电价',
    mlt_fee         DECIMAL(18,4)   COMMENT '中长期电费',
    __etl_time      DATETIME
)
DUPLICATE KEY(tenant_id, unit_id, trade_date, time_id)
DISTRIBUTED BY HASH(tenant_id, unit_id) BUCKETS 8
PARTITION BY RANGE(trade_date) (
    FROM ('2025-01-01') TO ('2027-01-01') INTERVAL 1 MONTH
);

-- ============================================================
-- DWD: 机组参数维度表 (SCD 缓变维度)
-- ============================================================
CREATE TABLE indicator_dwd.dwd_unit_param (
    tenant_id       BIGINT,
    unit_id         VARCHAR(32),
    unit_name       VARCHAR(64),
    plant_id        VARCHAR(32),
    plant_name      VARCHAR(64),
    group_code      VARCHAR(32),
    group_name      VARCHAR(64),
    rated_capacity  DECIMAL(10,2),
    min_output      DECIMAL(10,2),
    aux_rate        DECIMAL(5,4),
    installed_cap   DECIMAL(10,2),
    effective_cap   DECIMAL(10,2),
    __etl_time      DATETIME
)
UNIQUE KEY(tenant_id, unit_id)
DISTRIBUTED BY HASH(tenant_id) BUCKETS 4;

-- ============================================================
-- DWD: 结算费用明细表
-- ============================================================
CREATE TABLE indicator_dwd.dwd_settlement_detail (
    tenant_id       BIGINT,
    unit_id         VARCHAR(32),
    unit_name       VARCHAR(64),
    plant_id        VARCHAR(32),
    group_code      VARCHAR(32),
    trade_date      DATE,
    aux_assess_fee  DECIMAL(18,4)   COMMENT '辅助考核费',
    aux_return_fee  DECIMAL(18,4)   COMMENT '辅助返还费',
    aux_share_fee   DECIMAL(18,4)   COMMENT '辅助分摊费',
    aux_compensate_fee DECIMAL(18,4) COMMENT '辅助补偿费',
    total_fee       DECIMAL(18,4)   COMMENT '总电费',
    __etl_time      DATETIME
)
DUPLICATE KEY(tenant_id, unit_id, trade_date)
DISTRIBUTED BY HASH(tenant_id, unit_id) BUCKETS 8
PARTITION BY RANGE(trade_date) (
    FROM ('2025-01-01') TO ('2027-01-01') INTERVAL 1 MONTH
);

-- ============================================================
-- DWD: 省间交易明细
-- ============================================================
CREATE TABLE indicator_dwd.dwd_inter_province_detail (
    tenant_id       BIGINT,
    trade_date      DATE,
    time_id         INT,
    province_code   VARCHAR(8),
    dam_bid_output  DECIMAL(18,4),
    rtm_bid_output  DECIMAL(18,4),
    dam_price       DECIMAL(18,4),
    rtm_price       DECIMAL(18,4),
    __etl_time      DATETIME
)
DUPLICATE KEY(tenant_id, trade_date, time_id)
DISTRIBUTED BY HASH(tenant_id) BUCKETS 4
PARTITION BY RANGE(trade_date) (
    FROM ('2025-01-01') TO ('2027-01-01') INTERVAL 1 MONTH
);

-- ============================================================
-- DWD: 成本明细
-- ============================================================
CREATE TABLE indicator_dwd.dwd_cost_detail (
    tenant_id       BIGINT,
    unit_id         VARCHAR(32),
    trade_date      DATE,
    time_id         INT,
    var_cost_price  DECIMAL(18,4)   COMMENT '单位变动成本',
    __etl_time      DATETIME
)
DUPLICATE KEY(tenant_id, unit_id, trade_date, time_id)
DISTRIBUTED BY HASH(tenant_id, unit_id) BUCKETS 4
PARTITION BY RANGE(trade_date) (
    FROM ('2025-01-01') TO ('2027-01-01') INTERVAL 1 MONTH
);
```

### 5.3 DWD 表汇总

| DWD 表 | 来源 ODS | 粒度 | 用途 |
|--------|----------|------|------|
| dwd_clearing_detail | ods_spot_ahead + ods_spot_real + ods_sett_power_hour | 机组×日×96点 | 出清/上网主表 |
| dwd_contract_detail | ods_txm_contract_match_month + ods_bas_unit | 机组×日×96点 | 合约数据 |
| dwd_unit_param | ods_bas_unit | 机组 | 维度关联 |
| dwd_settlement_detail | ods_sett_base_subject + ods_sett_unit_bill_day | 机组×日 | 结算费用 |
| dwd_inter_province_detail | ods_spot_inter_province_* | 日×96点 | 省间数据 |
| dwd_cost_detail | ods_cost_unit_curve | 机组×日×96点 | 成本数据 |
| **合计 6 张** | | | |

### 5.4 ODS → DWD 转换逻辑

```sql
-- 例: DWD 出清明细 = 日前出清 JOIN 实时出清 JOIN 上网电量 JOIN 机组参数
INSERT INTO indicator_dwd.dwd_clearing_detail
SELECT
    COALESCE(a.tenant_id, r.tenant_id, s.tenant_id) AS tenant_id,
    COALESCE(a.unit_id, r.unit_id, s.unit_id)       AS unit_id,
    COALESCE(a.unit_name, r.unit_name, s.unit_name) AS unit_name,
    u.plant_id,
    u.group_code,
    COALESCE(a.trade_date, r.trade_date, s.trade_date) AS trade_date,
    COALESCE(a.time_id, r.time_id, s.time_id)          AS time_id,
    a.power    AS dam_energy,
    a.price    AS dam_price,
    r.power    AS rtm_energy,
    r.price    AS rtm_price,
    s.online_energy,
    NOW()      AS __etl_time
FROM indicator_ods.ods_spot_ahead_trade a
FULL OUTER JOIN indicator_ods.ods_spot_real_trade r
    ON a.tenant_id = r.tenant_id
    AND a.unit_id = r.unit_id
    AND a.trade_date = r.trade_date
    AND a.time_id = r.time_id
FULL OUTER JOIN indicator_ods.ods_sett_power_hour_unit s
    ON COALESCE(a.tenant_id, r.tenant_id) = s.tenant_id
    AND COALESCE(a.unit_id, r.unit_id) = s.unit_id
    AND COALESCE(a.trade_date, r.trade_date) = s.trade_date
    AND COALESCE(a.time_id, r.time_id) = s.time_id
LEFT JOIN indicator_dwd.dwd_unit_param u
    ON COALESCE(a.tenant_id, r.tenant_id) = u.tenant_id
    AND COALESCE(a.unit_id, r.unit_id) = u.unit_id
WHERE COALESCE(a.trade_date, r.trade_date) = '${calc_date}';
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
        // 直接查询 dwd_clearing_detail 等宽表
        String sql = "SELECT dam_energy, dam_price, rtm_energy, rtm_price, online_energy " +
                     "FROM indicator_dwd.dwd_clearing_detail " +
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

### 单个省网、1年数据量

| 表 | 行数/天 | 行数/年 | 单行大小 | 年存储 |
|----|---------|---------|----------|--------|
| dwd_clearing_detail | 机组数×96 ≈ 1,152 | 420,480 | 120B | ~50MB |
| dwd_contract_detail | 1,152 | 420,480 | 100B | ~42MB |
| ads_indicator_timeseries | 90×96×12 = 103,680 | 37.8M | 80B | ~3GB |
| ads_indicator_daily | 90×12 = 1,080 | 394,200 | 80B | ~32MB |
| ads_indicator_monthly | 90×12 = 1,080 | 12,960 | 60B | ~0.8MB |

### 10个省网、3年数据量

| 表 | 总行数 | 压缩后存储 |
|----|--------|-----------|
| ODS 全量 | ~50M | ~5GB |
| DWD 全量 | ~40M | ~4GB |
| ADS 全量 | ~1.2B | ~30GB |
| **合计** | **~1.3B** | **~40GB** |

Doris 列存储压缩比约 3:1，40GB 磁盘完全可承受。

---

## 十、P0 实施计划

### Phase 1: Doris 环境搭建 (2天)

- [ ] 部署 Doris FE + BE (Docker Compose)
- [ ] 创建 indicator_ods / indicator_dwd / indicator_ads 三个库
- [ ] 执行 ODS DDL (12张表)
- [ ] 执行 DWD DDL (6张表)
- [ ] 执行 ADS DDL (3张表)
- [ ] 验证 Stream Load 导入

### Phase 2: 数据同步 (3天)

- [ ] 编写 12 个 ODS 表的同步脚本 (MySQL → Doris)
- [ ] 编写 ODS → DWD 转换 SQL (6条)
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
