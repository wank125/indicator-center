# 指标中心 (Indicator Center) — 项目上下文

## 项目来龙去脉

本项目是「智慧交易运营管理平台」的新增模块——**指标中心**，面向电力交易市场的多省网一体化指标管理平台。

### 背景

- 现有系统是一个 Spring Cloud 微服务架构的电力营销管控平台，部署在 Docker 环境（22个容器），服务 9 个省网（山西/河南/湖北/蒙西/蒙东/宁夏/甘肃/陕西/云南/广西）
- 系统已有 11 个业务微服务，覆盖现货市场、交易管理、结算管理、成本管理、基础参数等，数据分布在 11 个 MySQL 业务库、30+ 张表中
- 客户提出 199 个指标需求，覆盖电量/电价/电费/偏差/边际贡献/成本/经营效率等维度，涉及中长期/现货/省间/辅助服务/容量/绿色权益 6 个市场
- 现有系统中 199 个指标散落在各服务代码中，无统一管理入口，新增指标需改代码、改库、改前端

### 立项目标

建立一个独立的「指标中心」微服务，统一管理 199 个指标的定义、计算逻辑、数据存储和查询服务：
- **配置化计算**：新增指标零代码，通过公式表达式驱动
- **多租户**：支持 9 个省网数据隔离
- **ODS-DWD-ADS 分层**：使用 Apache Doris 作为统一分析引擎
- **前端 4 页面**：看板 / 查询 / 配置 / 监控

## 项目状态

### 已完成

| 阶段 | 交付物 | 说明 |
|------|--------|------|
| 设计 | 设计方案 / 前端规格书 / 后端技术路线 | 完整的架构、数据模型、API、前端组件设计 |
| 数据库 | PostgreSQL DDL (11张表) + 初始化SQL (1054条) | 含月分区、触发器、199指标定义+157公式+28数据源 |
| 公式引擎 | FormulaCalcEngine.java (1025行) | 支持5种公式：四则运算/条件/聚合/同环比/排名 + DAG调度 |
| 骨架代码 | bdss-indicator-biz Maven项目 | 11 Entity + 11 Mapper + 6 Service + 4 Controller |
| 分层设计 | ODS-DWD-ADS Doris 分层架构 | ODS 12张 + DWD 6张 + ADS 3张 |
| 优先级 | P0-P3 分级设计 + P0 任务详细设计 | 10个子任务，20工作日排期 |
| 前端原型 | HTML 线框原型 | 4页面可交互原型 |

### 未开始

- [ ] T1: 数据抽取服务 (DataExtractService → 改为查询 Doris DWD)
- [ ] T2: 公式引擎集成 (拆分 FormulaCalcEngine → 5个 Spring Service)
- [ ] T3: DAG 调度与计算 (Layer 0→3, 90个 P0 指标)
- [ ] T4: 日/月聚合
- [ ] T5: Redis 缓存
- [ ] T6: 查询 API 补全
- [ ] T7: 定时调度
- [ ] T8-T9: 前端看板页 + 查询页
- [ ] T10: 联调验证

## 技术栈

| 层 | 技术 | 说明 |
|----|------|------|
| 后端框架 | Spring Boot 2.7 + Spring Cloud 2021 | 本地 JDK 11 |
| ORM | MyBatis Plus 3.5.5 | PostgreSQL 元数据存储 |
| 数仓 | Apache Doris 2.1+ | ODS-DWD-ADS 分层，MySQL 协议 |
| 元数据库 | PostgreSQL | 指标定义/公式/维度等元数据 |
| 缓存 | Redis | KPI + 热点数据 |
| 注册中心 | Nacos | 服务发现 + 配置中心 |
| 前端 | Vue 3 + Element Plus + ECharts | 与现有系统一致 |
| 部署 | Docker Compose | 端口 50009 |

## 目录结构

```
indicator-center/
├── CLAUDE.md                              # 本文件：项目上下文
├── docs/                                  # 设计文档
│   ├── 指标中心_设计方案.md                  # 总体架构、数据模型、API、路线图
│   ├── 指标中心_前端界面设计规格书.md          # 4页面布局、组件、交互
│   ├── 指标中心_后端技术路线.md               # 项目骨架、多数据源、部署
│   ├── 指标中心_ODS-DWD-ADS分层设计.md       # Doris 分层架构、DDL、同步方案
│   ├── 指标中心_P0-P3分级设计.md             # 全局优先级规划
│   ├── P0_任务详细设计.md                    # P0 十个子任务详细设计
│   ├── 智慧交易运营管理平台_系统总览.md        # 现有系统分析（参考资料）
│   ├── 指标中心_199指标完整映射.xlsx          # 199指标×17字段
│   ├── 客户指标库vs系统能力对比分析.xlsx       # 覆盖状态对比
│   └── 指标库-20260423-V1-客户提供.xlsx       # 客户原始需求
├── sql/                                   # PostgreSQL 数据库脚本
│   ├── 01_ddl_bdss_indicator_manage.sql    # 11张表 DDL
│   └── 02_init_indicator_data.sql          # 1054条初始化数据
├── engine/                                # 计算引擎（独立 Java 文件）
│   └── FormulaCalcEngine.java             # 公式解析/评估/DAG调度 (1025行, 21个类)
├── bdss-indicator-biz/                    # Maven 项目（Spring Boot 服务）
│   ├── pom.xml
│   └── src/main/java/com/qctc/bdss/indicator/
│       ├── IndicatorApplication.java
│       ├── config/                         # MybatisPlusConfig, RedisConfig
│       ├── entity/                         # 11个实体类
│       ├── mapper/                         # 11个Mapper接口
│       ├── service/                        # 业务服务（DataExtractService等有空壳TODO）
│       ├── controller/                     # 4个REST Controller
│       └── dto/                            # 请求/响应DTO + R<T>统一响应
└── mockup/                                # 前端原型
    └── 04_前端线框原型.html                  # 可交互4页面原型
```

## 关键设计决策

### 1. 指标编码规范

格式：`{市场}_{品类}_{子类型}`，如：
- `DAM_CLEARING_ENERGY` — 日前出清电量 (Day-Ahead Market)
- `MLT_CONTRACT_PRICE` — 中长期合约电价 (Medium-Long Term)
- `RTM_DEV_POS_FEE` — 实时正偏差电费 (Real-Time Market)

### 2. 计算层级 (10层)

```
L0 原始数据 (38个) → L1 基础计算 (9个) → L2 偏差 (10个) → L3 电费 (33个)
→ L4 差价合约 (14个) → L5 边际贡献 (19个) → L6 负荷率 (11个)
→ L7 集团聚合 (36个) → L8 同环比 (24个) → L9 排名 (5个)
```

DAG 拓扑排序保证按层级计算，循环依赖检测。

### 3. ODS-DWD-ADS 分层

```
MySQL 业务库 → Flink/Stream Load → Doris ODS (12张原始表)
                                      → Doris DWD (6张标准宽表)
                                      → Java 公式引擎
                                      → Doris ADS (3张指标表)
                                      → Java 查询服务 → 前端
```

- **ODS**: 1:1 映射源表，UNIQUE KEY
- **DWD**: 标准化宽表，多源 JOIN，统一字段名
- **ADS**: 公式计算结果，AGGREGATE KEY 自动聚合
- **元数据** (指标定义/公式/维度): 保留在 PostgreSQL

### 4. 多租户

所有表都有 `tenant_id` 字段，对应不同省网。查询时强制带 tenant_id 条件。

## 数据库连接信息

| 用途 | 地址 | 用户 | 说明 |
|------|------|------|------|
| PostgreSQL (元数据) | 192.168.31.123:5433 | sc-postgresql / postgres | 指标定义、公式、维度 |
| Doris (数仓) | 待部署 | root / 无密码 | ODS/DWD/ADS 指标数据 |
| MySQL (源系统) | 10.60.64.219:33075 | — | 11个业务库（只读） |
| Nacos | 10.60.64.219:40000 | — | 注册中心/配置中心 |
| Redis | 10.60.64.219:6379 | password | 缓存 |

## 本地开发注意事项

- **JDK 版本**: 本地是 JDK 11，项目使用 Spring Boot 2.7（非 3.x）
- **Maven 编译**: `cd bdss-indicator-biz && mvn compile` 验证编译
- **数据库**: 需要先在 PostgreSQL 执行 DDL + 初始化 SQL
- **公式引擎**: `engine/FormulaCalcEngine.java` 是独立 Java 文件（21个类），需要拆分为 5 个独立文件集成到 Spring
- **前端**: 尚未开始，设计规格书和线框原型已完成

## Git

- **远程**: `git@github.com:wank125/indicator-center.git`
- **分支**: master
- **Commit 规范**: `feat:` / `fix:` / `docs:` / `chore:`
