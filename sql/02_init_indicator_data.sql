-- ============================================================
-- 指标中心初始化数据 SQL
-- Database: bdss_indicator_manage
-- Engine: PostgreSQL
-- 共计: 维度树 + 199指标定义 + 计算公式 + 数据源映射 + 维度关联
-- ============================================================

\c bdss_indicator_manage;

-- ============================================================
-- SECTION 1: 维度树 ind_dimension
-- ============================================================

-- --- BUSINESS 业务域维度 ---

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (1, 'BUSINESS', 'BIZ_ENERGY', '电量', NULL, NULL, 1, 10, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (2, 'BUSINESS', 'BIZ_ENERGY_CONTRACT', '合约电量', 1, NULL, 2, 1010, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (3, 'BUSINESS', 'BIZ_ENERGY_SPOT', '现货电量', 1, NULL, 2, 1020, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (4, 'BUSINESS', 'BIZ_ENERGY_DEVIATION', '偏差电量', 1, NULL, 2, 1030, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (5, 'BUSINESS', 'BIZ_ENERGY_INTERPROV', '省间电量', 1, NULL, 2, 1040, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (6, 'BUSINESS', 'BIZ_ENERGY_GROUP_AGG', '集团聚合', 1, NULL, 2, 1050, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (7, 'BUSINESS', 'BIZ_PRICE', '电价', NULL, NULL, 1, 20, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (8, 'BUSINESS', 'BIZ_PRICE_CLEARING', '出清电价', 7, NULL, 2, 2010, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (9, 'BUSINESS', 'BIZ_PRICE_CONTRACT', '合约电价', 7, NULL, 2, 2020, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (10, 'BUSINESS', 'BIZ_PRICE_DEVIATION', '偏差电价', 7, NULL, 2, 2030, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (11, 'BUSINESS', 'BIZ_PRICE_AVG', '综合电价', 7, NULL, 2, 2040, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (12, 'BUSINESS', 'BIZ_PRICE_INCREMENT', '增收电价', 7, NULL, 2, 2050, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (13, 'BUSINESS', 'BIZ_FEE', '电费', NULL, NULL, 1, 30, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (14, 'BUSINESS', 'BIZ_FEE_CONTRACT', '合约电费', 13, NULL, 2, 3010, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (15, 'BUSINESS', 'BIZ_FEE_DEVIATION', '偏差电费', 13, NULL, 2, 3020, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (16, 'BUSINESS', 'BIZ_FEE_FULL', '全量电费', 13, NULL, 2, 3030, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (17, 'BUSINESS', 'BIZ_FEE_CFD', '差价合约电费', 13, NULL, 2, 3040, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (18, 'BUSINESS', 'BIZ_FEE_INCREMENT', '增收电费', 13, NULL, 2, 3050, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (19, 'BUSINESS', 'BIZ_COST', '成本', NULL, NULL, 1, 40, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (20, 'BUSINESS', 'BIZ_COST_VARIABLE', '变动成本', 19, NULL, 2, 4010, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (21, 'BUSINESS', 'BIZ_COST_UNIT', '度电成本', 19, NULL, 2, 4020, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (22, 'BUSINESS', 'BIZ_LOAD_RATE', '负荷率', NULL, NULL, 1, 50, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (23, 'BUSINESS', 'BIZ_LOAD_RATE_MAIN', '负荷率', 22, NULL, 2, 5010, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (24, 'BUSINESS', 'BIZ_COVERAGE_RATE', '覆盖率', 22, NULL, 2, 5020, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (25, 'BUSINESS', 'BIZ_MARGIN', '边际贡献', NULL, NULL, 1, 60, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (26, 'BUSINESS', 'BIZ_MARGIN_CONTRACT', '合约边际', 25, NULL, 2, 6010, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (27, 'BUSINESS', 'BIZ_MARGIN_DEVIATION', '偏差边际', 25, NULL, 2, 6020, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (28, 'BUSINESS', 'BIZ_MARGIN_FULL', '全量边际', 25, NULL, 2, 6030, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (29, 'BUSINESS', 'BIZ_MARGIN_UNIT', '度电贡献', 25, NULL, 2, 6040, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (30, 'BUSINESS', 'BIZ_EFFICIENCY', '经营效率', NULL, NULL, 1, 70, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (31, 'BUSINESS', 'BIZ_EFF_COMPLETION', '完成率', 30, NULL, 2, 7010, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (32, 'BUSINESS', 'BIZ_EFF_UTIL_HOURS', '可利用小时数', 30, NULL, 2, 7020, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (33, 'BUSINESS', 'BIZ_EFF_UNIT_REVENUE', '度电收益', 30, NULL, 2, 7030, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (34, 'BUSINESS', 'BIZ_YOY_MOM', '同比环比', NULL, NULL, 1, 80, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (35, 'BUSINESS', 'BIZ_YOY', '同比', 34, NULL, 2, 8010, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (36, 'BUSINESS', 'BIZ_MOM', '环比', 34, NULL, 2, 8020, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (37, 'BUSINESS', 'BIZ_RANK', '排名', NULL, NULL, 1, 90, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (38, 'BUSINESS', 'BIZ_RANK_TOP10', 'TOP10', 37, NULL, 2, 9010, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (39, 'BUSINESS', 'BIZ_AUX_SERVICE', '辅助服务', NULL, NULL, 1, 100, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (40, 'BUSINESS', 'BIZ_AUX_FREQ', '调频', 39, NULL, 2, 10010, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (41, 'BUSINESS', 'BIZ_AUX_RESERVE', '备用', 39, NULL, 2, 10020, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (42, 'BUSINESS', 'BIZ_AUX_ASSESS', '考核', 39, NULL, 2, 10030, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (43, 'BUSINESS', 'BIZ_AUX_RETURN', '返还', 39, NULL, 2, 10040, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (44, 'BUSINESS', 'BIZ_AUX_SHARE', '分摊', 39, NULL, 2, 10050, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (45, 'BUSINESS', 'BIZ_AUX_COMPENSATE', '补偿', 39, NULL, 2, 10060, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (46, 'BUSINESS', 'BIZ_CAPACITY', '容量', NULL, NULL, 1, 110, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (47, 'BUSINESS', 'BIZ_CAP_INSTALLED', '装机', 46, NULL, 2, 11010, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (48, 'BUSINESS', 'BIZ_CAP_EFFECTIVE', '有效容量', 46, NULL, 2, 11020, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (49, 'BUSINESS', 'BIZ_CAP_FEE', '容量电费', 46, NULL, 2, 11030, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (50, 'BUSINESS', 'BIZ_CAP_PRICE', '容量电价', 46, NULL, 2, 11040, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (51, 'BUSINESS', 'BIZ_GREEN', '绿色权益', NULL, NULL, 1, 120, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (52, 'BUSINESS', 'BIZ_GREEN_CERT', '绿证', 51, NULL, 2, 12010, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (53, 'BUSINESS', 'BIZ_GREEN_ELEC', '绿电', 51, NULL, 2, 12020, NULL, 1, 1, 0);

-- --- MARKET 市场类型维度 ---

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (54, 'MARKET', 'MKT_MLT', '中长期市场', NULL, NULL, 1, 10, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (55, 'MARKET', 'MKT_MLT_CONTRACT_ENERGY', '合约电量', 54, NULL, 2, 1010, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (56, 'MARKET', 'MKT_MLT_CONTRACT_PRICE', '合约电价', 54, NULL, 2, 1020, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (57, 'MARKET', 'MKT_MLT_CONTRACT_FEE', '合约电费', 54, NULL, 2, 1030, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (58, 'MARKET', 'MKT_MLT_CFD', '差价合约', 54, NULL, 2, 1040, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (59, 'MARKET', 'MKT_MLT_LOAD_RATE', '负荷率', 54, NULL, 2, 1050, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (60, 'MARKET', 'MKT_SPOT', '现货市场', NULL, NULL, 1, 20, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (61, 'MARKET', 'MKT_SPOT_DAM', '日前市场', 60, NULL, 2, 2010, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (62, 'MARKET', 'MKT_SPOT_RTM', '实时市场', 60, NULL, 2, 2020, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (63, 'MARKET', 'MKT_SPOT_AVG', '综合指标', 60, NULL, 2, 2030, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (64, 'MARKET', 'MKT_SPOT_INTERPROV', '省间市场', 60, NULL, 2, 2040, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (65, 'MARKET', 'MKT_SPOT_YOY_MOM', '同比环比', 60, NULL, 2, 2050, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (66, 'MARKET', 'MKT_SPOT_RANK', '排名', 60, NULL, 2, 2060, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (67, 'MARKET', 'MKT_AUX', '辅助服务市场', NULL, NULL, 1, 30, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (68, 'MARKET', 'MKT_CAPACITY', '容量市场', NULL, NULL, 1, 40, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (69, 'MARKET', 'MKT_GREEN', '绿色权益', NULL, NULL, 1, 50, NULL, 1, 1, 0);

-- --- SUBJECT 主体层级维度 ---

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (70, 'SUBJECT', 'SUBJ_GEN', '发电侧', NULL, NULL, 1, 10, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (71, 'SUBJECT', 'SUBJ_GEN_RAW', '原始指标', 70, NULL, 2, 1010, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (72, 'SUBJECT', 'SUBJ_GEN_CALC', '计算指标', 70, NULL, 2, 1020, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (73, 'SUBJECT', 'SUBJ_GROUP', '集团公司', NULL, NULL, 1, 20, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (74, 'SUBJECT', 'SUBJ_GRP_GEN_AGG', '发电侧聚合', 73, NULL, 2, 2010, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (75, 'SUBJECT', 'SUBJ_GRP_AUX', '辅助服务', 73, NULL, 2, 2020, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (76, 'SUBJECT', 'SUBJ_GRP_CAP', '容量', 73, NULL, 2, 2030, NULL, 1, 1, 0);

INSERT INTO ind_dimension (id, dim_type, dim_code, dim_name, parent_id, parent_code, level_num, sort_order, icon, status, tenant_id, del_flag)
VALUES (77, 'SUBJECT', 'SUBJ_GRP_GREEN', '绿色权益', 73, NULL, 2, 2040, NULL, 1, 1, 0);

-- Total dimension nodes: 77

-- ============================================================
-- SECTION 2: 指标定义 ind_indicator_def (199条)
-- ============================================================

-- 指标 #1: PLAN_REVENUE - 计划收益
INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (1, 'PLAN_REVENUE', '计划收益', 1, '发电侧', '中长期+现货', NULL, NULL, '元', '汇总', '集团公司', 0, '年度计划收益目标', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (2, 'PLAN_ENERGY', '计划发电量', 1, '发电侧', '中长期+现货', NULL, NULL, 'MWh', '汇总', '集团公司', 0, '年度计划发电量目标', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (3, 'RATED_CAPACITY', '额定容量', 1, '发电侧', '现货市场', '电量', '机组参数', 'MW', '分时', 'bdss_basic_parameter.bas_unit.ratedCapacity', 0, '机组额定出力', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (4, 'MIN_TECH_OUTPUT', '最小技术出力', 1, '发电侧', '现货市场', '电量', '机组参数', 'MW', '分时', 'bdss_basic_parameter.bas_unit.minOutput', 0, '机组最小稳定出力', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (5, 'AUX_RATE', '厂用电率', 1, '发电侧', '现货市场', '电量', '机组参数', '%', '分时', 'bdss_basic_parameter.bas_unit.auxRate', 0, '厂用电量占发电量比例', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (6, 'RT_VAR_COST_PRICE', '实时单位变动成本', 1, '发电侧', '现货市场', '成本', '变动成本', '元/MWh', '分时', 'bdss_cost_manage.cost_unit_curve', 0, '实际出力代入变动成本曲线', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (7, 'BASE_CLEARING_ENERGY', '基数出清电量', 1, '发电侧', '中长期市场', '电量', '合约电量', 'MWh', '分时', 'bdss_transaction_manage.trxn_contract_match_month', 0, '基数(计划)出清电量', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (8, 'MLT_CLEARING_ENERGY', '中长期出清电量', 1, '发电侧', '中长期市场', '电量', '合约电量', 'MWh', '分时', 'bdss_transaction_manage.trxn_contract_match_month', 0, '中长期合约出清电量', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (9, 'DAM_CLEARING_ENERGY', '日前出清电量', 1, '发电侧', '现货市场', '电量', '日前电量', 'MWh', '分时', 'bdss_spot_market.spot_ahead_trade.power', 0, '日前市场出清电量', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (10, 'RTM_CLEARING_ENERGY', '实时出清电量', 1, '发电侧', '现货市场', '电量', '实时电量', 'MWh', '分时', 'bdss_spot_market.spot_real_trade.power', 0, '实时市场出清电量', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (11, 'ONLINE_ENERGY', '上网电量', 3, '发电侧', '现货市场', '电量', '上网电量', 'MWh', '分时', 'bdss_settlement_manage.sett_power_hour_unit', 0, '机组实际上网电量', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (12, 'BASE_CLEARING_PRICE', '基数出清电价', 1, '发电侧', '中长期市场', '电价', '合约电价', '元/MWh', '分时', 'bdss_transaction_manage.trxn_contract_match_month', 0, '基数出清价格', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (13, 'MLT_CLEARING_PRICE', '中长期出清电价', 1, '发电侧', '中长期市场', '电价', '合约电价', '元/MWh', '分时', 'bdss_transaction_manage.trxn_contract_match_month', 0, '中长期合约价格', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (14, 'DAM_CLEARING_PRICE', '日前出清电价', 1, '发电侧', '现货市场', '电价', '日前电价', '元/MWh', '分时', 'bdss_spot_market.spot_ahead_trade.price', 0, '日前市场出清电价', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (15, 'RTM_CLEARING_PRICE', '实时出清电价', 1, '发电侧', '现货市场', '电价', '实时电价', '元/MWh', '分时', 'bdss_spot_market.spot_real_trade.price', 0, '实时市场出清电价', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (16, 'BENCHMARK_PRICE', '基准价', 1, '发电侧', '现货市场', '电价', '基准价', '元/MWh', '分时', '手动维护', 0, '基准电价(手动)', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (17, 'ACTUAL_OUTPUT', '实际出力值', 1, '发电侧', '现货市场', '电量', '出力', 'MW', '分时', 'bdss_group_data.ha_ssfdjh', 0, '场站实际出力', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (18, 'BIDDING_SPACE', '竞价空间', 2, '发电侧', '现货市场', '电量', '竞价空间', 'MW', '分时', 'bdss_market_analysis.mkt_netload', 0, '市场可用竞价容量', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (19, 'INSTALLED_CAPACITY', '装机容量', 1, '发电侧', '容量市场', '容量', '装机', 'MW', '-', 'bdss_basic_parameter.bas_unit', 0, '机组装机容量', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (20, 'EFFECTIVE_CAPACITY', '有效容量', 1, '发电侧', '容量市场', '容量', '有效', 'MW', '-', 'bdss_basic_parameter.bas_unit', 0, '机组有效容量', 1, 1, 0);

-- 指标 #21: CAPACITY_FEE - 容量电费
INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (21, 'CAPACITY_FEE', '容量电费', 1, '发电侧', '容量市场', '电费', '容量', '元', '月', 'bdss_settlement_manage', 0, '容量市场电费', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (22, 'CAPACITY_PRICE', '容量电价', 1, '发电侧', '容量市场', '电价', '容量', '元/MWh', '月', 'bdss_settlement_manage', 0, '容量市场电价', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (23, 'AUX_FREQ_CLEARING', '调频出清', 1, '发电侧', '辅助服务市场', '电量', '调频', 'MW', '分时', 'bdss_settlement_manage', 0, '调频市场出清', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (24, 'AUX_FREQ_PRICE', '调频出清电价', 1, '发电侧', '辅助服务市场', '电价', '调频', '元/MWh', '分时', 'bdss_settlement_manage', 0, '调频出清价格', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (25, 'AUX_RESERVE_CLEARING', '备用出清', 1, '发电侧', '辅助服务市场', '电量', '备用', 'MW', '分时', 'bdss_settlement_manage', 0, '备用市场出清', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (26, 'AUX_RESERVE_PRICE', '备用出清电价', 1, '发电侧', '辅助服务市场', '电价', '备用', '元/MWh', '分时', 'bdss_settlement_manage', 0, '备选出清价格', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (27, 'AUX_ASSESS_FEE', '考核费用', 1, '发电侧', '辅助服务市场', '电费', '考核', '元', '分时', 'bdss_settlement_manage.sett_base_subject', 0, '辅助服务考核费用', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (28, 'AUX_RETURN_FEE', '返还费用', 1, '发电侧', '辅助服务市场', '电费', '返还', '元', '分时', 'bdss_settlement_manage.sett_base_subject', 0, '辅助服务返还费用', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (29, 'AUX_SHARE_FEE', '分摊费用', 1, '发电侧', '辅助服务市场', '电费', '分摊', '元', '分时', 'bdss_settlement_manage.sett_base_subject', 0, '辅助服务分摊费用', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (30, 'AUX_COMPENSATE_FEE', '补偿费用', 1, '发电侧', '辅助服务市场', '电费', '补偿', '元', '分时', 'bdss_settlement_manage.sett_base_subject', 0, '辅助服务补偿费用', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (31, 'INT_DAM_BID_OUTPUT', '省间日前中标出力', 1, '发电侧', '现货市场', '电量', '省间', 'MW', '分时', 'bdss_spot_market.spot_sjxh_inter_province_declare', 0, '省间日前中标出力', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (32, 'INT_RTM_BID_OUTPUT', '省间日内中标出力', 1, '发电侧', '现货市场', '电量', '省间', 'MW', '分时', 'bdss_spot_market.spot_sjxh_inter_province_declare', 0, '省间日内中标出力', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (33, 'INT_DAM_PRICE', '省间日前出清电价', 1, '发电侧', '现货市场', '电价', '省间', '元/MWh', '分时', 'bdss_spot_market.spot_sjxh_result_interprovincial_proveince', 0, '省间日前出清价', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (34, 'INT_RTM_PRICE', '省间日内出清电价', 1, '发电侧', '现货市场', '电价', '省间', '元/MWh', '分时', 'bdss_spot_market.spot_sjxh_result_interprovincial_proveince', 0, '省间日内出清价', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (35, 'GRN_CERT_ISSUE', '绿证应发量', 1, '发电侧', '绿色权益', '绿证', '应发', '个', '日', '需接入绿证系统', 0, '绿证应发量', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (36, 'GRN_CERT_GRANT', '绿证核发量', 1, '发电侧', '绿色权益', '绿证', '核发', '个', '日', '需接入绿证系统', 0, '绿证核发量', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (37, 'GRN_CERT_TRADE_VOL', '绿证交易量', 1, '发电侧', '绿色权益', '绿证', '交易', '个', '日', '需接入绿证系统', 0, '绿证交易量', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (38, 'GRN_CERT_TRADE_PRICE', '绿证交易价格', 1, '发电侧', '绿色权益', '绿证', '价格', '元/个', '日', '需接入绿证系统', 0, '绿证交易价格', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (39, 'MLT_CONTRACT_ENERGY', '合约出清电量', 2, '发电侧', '中长期市场', '电量', '合约电量', 'MWh', '分时', NULL, 1, '基数+中长期=合约电量', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (40, 'BASE_OUTPUT', '基数出力', 2, '发电侧', '中长期市场', '电量', '出力', 'MW', '分时', NULL, 1, '基数电力折算出力', 1, 1, 0);

-- 指标 #41: MLT_OUTPUT - 中长期出力
INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (41, 'MLT_OUTPUT', '中长期出力', 2, '发电侧', '中长期市场', '电量', '出力', 'MW', '分时', NULL, 1, '中长期电力折算出力', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (42, 'DAM_CLEARING_OUTPUT', '日前出清电力', 2, '发电侧', '现货市场', '电量', '日前出力', 'MW', '分时', 'bdss_spot_market.spot_ahead_trade', 1, '日前出清电力', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (43, 'RTM_CLEARING_OUTPUT', '实时出清电力', 2, '发电侧', '现货市场', '电量', '实时出力', 'MW', '分时', 'bdss_spot_market.spot_real_trade', 1, '实时出清电力', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (44, 'MLT_CONTRACT_PRICE', '合约电价', 2, '发电侧', '中长期市场', '电价', '合约电价', '元/MWh', '分时', NULL, 1, '合约加权电价=合约电费/合约电量', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (45, 'DAM_DEV_ENERGY', '日前偏差电量', 2, '发电侧', '现货市场', '电量', '日前偏差', 'MWh', '分时', NULL, 2, '日前出清-合约出清', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (46, 'RTM_DEV_ENERGY', '实时偏差电量', 2, '发电侧', '现货市场', '电量', '实时偏差', 'MWh', '分时', NULL, 2, '上网-日前出清', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (47, 'SPOT_DEV_ENERGY', '现货偏差电量', 2, '发电侧', '现货市场', '电量', '现货偏差', 'MWh', '分时', NULL, 2, '日前偏差+实时偏差', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (48, 'DAM_DEV_POS_ENERGY', '日前正偏差电量', 2, '发电侧', '现货市场', '电量', '日前正偏差', 'MWh', '分时', NULL, 2, '日前偏差>=0取正值', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (49, 'DAM_DEV_NEG_ENERGY', '日前负偏差电量', 2, '发电侧', '现货市场', '电量', '日前负偏差', 'MWh', '分时', NULL, 2, '日前偏差<0取负值', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (50, 'RTM_DEV_POS_ENERGY', '实时正偏差电量', 2, '发电侧', '现货市场', '电量', '实时正偏差', 'MWh', '分时', NULL, 2, '实时偏差>=0取正值', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (51, 'RTM_DEV_NEG_ENERGY', '实时负偏差电量', 2, '发电侧', '现货市场', '电量', '实时负偏差', 'MWh', '分时', NULL, 2, '实时偏差<0取负值', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (52, 'SPOT_DEV_POS_ENERGY', '现货正偏差电量', 2, '发电侧', '现货市场', '电量', '现货正偏差', 'MWh', '分时', NULL, 2, '现货偏差>=0取正值', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (53, 'SPOT_DEV_NEG_ENERGY', '现货负偏差电量', 2, '发电侧', '现货市场', '电量', '现货负偏差', 'MWh', '分时', NULL, 2, '现货偏差<0取负值', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (54, 'INT_DAM_ENERGY', '省间日前中标电量', 2, '发电侧', '现货市场', '电量', '省间日前', 'MWh', '分时', NULL, 1, '出力×4小时', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (55, 'INT_RTM_ENERGY', '省间日内中标电量', 2, '发电侧', '现货市场', '电量', '省间日内', 'MWh', '分时', NULL, 1, '出力×4小时', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (56, 'INT_SPOT_ENERGY', '省间现货电量', 2, '发电侧', '现货市场', '电量', '省间现货', 'MWh', '分时', NULL, 2, '日前+日内', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (57, 'GRN_CERT_FEE', '绿证费用', 2, '发电侧', '绿色权益', '绿证', '费用', '元', '日', NULL, 1, '绿证价格×交易量', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (58, 'BASE_FEE', '基数电费', 2, '发电侧', '中长期市场', '电费', '基数电费', '元', '分时', NULL, 3, '基数电价×电量', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (59, 'MLT_FEE', '中长期电费', 2, '发电侧', '中长期市场', '电费', '中长期电费', '元', '分时', NULL, 3, '中长期电价×电量', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (60, 'MLT_CONTRACT_FEE', '合约电费', 2, '发电侧', '中长期市场', '电费', '合约电费', '元', '分时', NULL, 3, '基数电费+中长期电费', 1, 1, 0);

-- 指标 #61: DAM_FULL_FEE - 日前全电量电费
INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (61, 'DAM_FULL_FEE', '日前全电量电费', 2, '发电侧', '现货市场', '电费', '日前全量', '元', '分时', NULL, 3, '日前出清电量×电价', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (62, 'RTM_FULL_FEE', '实时全电量电费', 2, '发电侧', '现货市场', '电费', '实时全量', '元', '分时', NULL, 3, '实时出清电量×电价', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (63, 'DAM_DEV_FEE', '日前偏差电费', 2, '发电侧', '现货市场', '电费', '日前偏差电费', '元', '分时', NULL, 3, '日前偏差电量×日前电价', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (64, 'RTM_DEV_FEE', '实时偏差电费', 2, '发电侧', '现货市场', '电费', '实时偏差电费', '元', '分时', NULL, 3, '实时偏差电量×实时电价', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (65, 'SPOT_DEV_FEE', '现货偏差电费', 2, '发电侧', '现货市场', '电费', '现货偏差电费', '元', '分时', NULL, 3, '日前偏差电费+实时偏差电费', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (66, 'DAM_DEV_POS_FEE', '日前正偏差电费', 2, '发电侧', '现货市场', '电费', '日前正偏差', '元', '分时', NULL, 3, '正偏差时取偏差电费', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (67, 'DAM_DEV_NEG_FEE', '日前负偏差电费', 2, '发电侧', '现货市场', '电费', '日前负偏差', '元', '分时', NULL, 3, '负偏差时取偏差电费', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (68, 'RTM_DEV_POS_FEE', '实时正偏差电费', 2, '发电侧', '现货市场', '电费', '实时正偏差', '元', '分时', NULL, 3, '正偏差时取偏差电费', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (69, 'RTM_DEV_NEG_FEE', '实时负偏差电费', 2, '发电侧', '现货市场', '电费', '实时负偏差', '元', '分时', NULL, 3, '负偏差时取偏差电费', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (70, 'SPOT_DEV_POS_FEE', '现货正偏差电费', 2, '发电侧', '现货市场', '电费', '现货正偏差', '元', '分时', NULL, 3, '正偏差取偏差电费', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (71, 'SPOT_DEV_NEG_FEE', '现货负偏差电费', 2, '发电侧', '现货市场', '电费', '现货负偏差', '元', '分时', NULL, 3, '负偏差取偏差电费', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (72, 'SPOT_FULL_FEE', '现货全电量电费', 2, '发电侧', '现货市场', '电费', '现货全量', '元', '分时', NULL, 3, '日前全量+实时偏差电费', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (73, 'TOTAL_FEE', '总电费', 2, '发电侧', '现货市场', '电费', '总电费', '元', '分时', NULL, 3, '合约+日前偏差+实时偏差', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (74, 'TOTAL_FEE_WITH_MKT', '总电费(含市场运行费)', 2, '发电侧', '现货市场', '电费', '含市场费', '元', '分时', 'bdss_settlement_manage.sett_unit_bill_day', 3, '取日结算单总电费', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (75, 'AVG_PRICE_WITH_MKT', '平均电价(含市场运行费)', 2, '发电侧', '现货市场', '电价', '含市场费', '元/MWh', '分时', NULL, 3, '含市场费总电费/上网电量', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (76, 'DAM_DEV_PRICE', '日前偏差电价', 2, '发电侧', '现货市场', '电价', '日前偏差电价', '元/MWh', '分时', NULL, 3, '日前偏差电费/电量', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (77, 'RTM_DEV_PRICE', '实时偏差电价', 2, '发电侧', '现货市场', '电价', '实时偏差电价', '元/MWh', '分时', NULL, 3, '实时偏差电费/电量', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (78, 'SPOT_DEV_PRICE', '现货偏差电价', 2, '发电侧', '现货市场', '电价', '现货偏差电价', '元/MWh', '分时', NULL, 3, '现货偏差电费/电量', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (79, 'DAM_DEV_POS_PRICE', '日前正偏差电价', 2, '发电侧', '现货市场', '电价', '日前正偏差', '元/MWh', '分时', NULL, 3, '正偏差电费/正偏差电量', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (80, 'DAM_DEV_NEG_PRICE', '日前负偏差电价', 2, '发电侧', '现货市场', '电价', '日前负偏差', '元/MWh', '分时', NULL, 3, '负偏差电费/负偏差电量', 1, 1, 0);

-- 指标 #81: RTM_DEV_POS_PRICE - 实时正偏差电价
INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (81, 'RTM_DEV_POS_PRICE', '实时正偏差电价', 2, '发电侧', '现货市场', '电价', '实时正偏差', '元/MWh', '分时', NULL, 3, '正偏差电费/正偏差电量', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (82, 'RTM_DEV_NEG_PRICE', '实时负偏差电价', 2, '发电侧', '现货市场', '电价', '实时负偏差', '元/MWh', '分时', NULL, 3, '负偏差电费/负偏差电量', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (83, 'SPOT_DEV_POS_PRICE', '现货正偏差电价', 2, '发电侧', '现货市场', '电价', '现货正偏差', '元/MWh', '分时', NULL, 3, '正偏差电费/正偏差电量', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (84, 'SPOT_DEV_NEG_PRICE', '现货负偏差电价', 2, '发电侧', '现货市场', '电价', '现货负偏差', '元/MWh', '分时', NULL, 3, '负偏差电费/负偏差电量', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (85, 'SPOT_AVG_PRICE', '现货均价', 2, '发电侧', '现货市场', '电价', '现货均价', '元/MWh', '分时', NULL, 3, '现货全量电费/上网电量', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (86, 'TOTAL_AVG_PRICE', '总平均电价', 2, '发电侧', '现货市场', '电价', '总平均', '元/MWh', '分时', NULL, 3, '总电费/上网电量', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (87, 'INT_DAM_FEE', '省间日前电费', 2, '发电侧', '现货市场', '电费', '省间日前', '元', '分时', NULL, 3, '省间日前电量×电价', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (88, 'INT_RTM_FEE', '省间日内电费', 2, '发电侧', '现货市场', '电费', '省间日内', '元', '分时', NULL, 3, '省间日内电量×电价', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (89, 'INT_SPOT_FEE', '省间现货电费', 2, '发电侧', '现货市场', '电费', '省间现货', '元', '分时', NULL, 3, '省间日前+日内电费', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (90, 'INT_SPOT_AVG_PRICE', '省间现货均价', 2, '发电侧', '现货市场', '电价', '省间均价', '元/MWh', '分时', NULL, 3, '省间电费/省间电量', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (91, 'BASE_CFD_FEE', '基数差价合约电费', 2, '发电侧', '中长期市场', '电费', '基数差价', '元', '分时', NULL, 4, '(合约价-现货价)×电量', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (92, 'MLT_CFD_FEE', '中长期差价合约电费', 2, '发电侧', '中长期市场', '电费', '中长期差价', '元', '分时', NULL, 4, '(合约价-现货价)×电量', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (93, 'CONTRACT_CFD_FEE', '合约差价合约电费', 2, '发电侧', '中长期市场', '电费', '合约差价', '元', '分时', NULL, 4, '基数差价+中长期差价', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (94, 'DAM_CFD_FEE', '日前差价合约电费', 2, '发电侧', '中长期市场', '电费', '日前差价', '元', '分时', NULL, 4, '日前偏差×(日前-实时)价差', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (95, 'BASE_DEGREE_DIFF_PRICE', '基数度电差价', 2, '发电侧', '中长期市场', '电价', '基数差价', '元/MWh', '分时', NULL, 4, '基数差价电费/基数电量', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (96, 'CONTRACT_DEGREE_DIFF_PRICE', '合约度电差价', 2, '发电侧', '中长期市场', '电价', '合约差价', '元/MWh', '分时', NULL, 4, '合约差价电费/合约电量', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (97, 'MLT_DEGREE_DIFF_PRICE', '中长期度电差价', 2, '发电侧', '中长期市场', '电价', '中长期差价', '元/MWh', '分时', NULL, 4, '中长期差价电费/中长期电量', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (98, 'DAM_RTM_SPREAD', '日前实时价差', 2, '发电侧', '现货市场', '电价', '日前实时价差', '元/MWh', '分时', NULL, 4, '日前差价/日前电量', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (99, 'INT_DAM_INC_FEE', '省间日前增收电费', 2, '发电侧', '现货市场', '电费', '省间增收', '元', '分时', NULL, 4, '省间电量×(省间-实时)价差', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (100, 'INT_RTM_INC_FEE', '省间日内增收电费', 2, '发电侧', '现货市场', '电费', '省间增收', '元', '分时', NULL, 4, '省间电量×(省间-实时)价差', 1, 1, 0);

-- 指标 #101: INT_SPOT_INC_FEE - 省间现货增收电费
INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (101, 'INT_SPOT_INC_FEE', '省间现货增收电费', 2, '发电侧', '现货市场', '电费', '省间增收', '元', '分时', NULL, 4, '省间日前+日增收', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (102, 'MLT_EXT_INC_FEE', '中长期对外增收电费', 2, '发电侧', '现货市场', '电费', '对外增收', '元', '分时', NULL, 4, '中长期电量×(合约-市场均价)', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (103, 'DAM_EXT_INC_FEE', '日前市场对外增收电费', 2, '发电侧', '现货市场', '电费', '对外增收', '元', '分时', NULL, 4, '日前偏差×(出清-统一出清)价差', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (104, 'RTM_EXT_INC_FEE', '实时市场对外增收电费', 2, '发电侧', '现货市场', '电费', '对外增收', '元', '分时', NULL, 4, '实时偏差×(出清-统一出清)价差', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (105, 'CONTRACT_VAR_COST', '合约变动成本额', 2, '发电侧', '中长期市场', '成本', '变动成本', '元', '分时', NULL, 5, '单位变动成本×合约电量', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (106, 'RTM_VAR_COST', '实时变动成本额', 2, '发电侧', '现货市场', '成本', '变动成本', '元', '分时', NULL, 5, '单位变动成本×上网电量', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (107, 'SPOT_VAR_COST', '现货变动成本额', 2, '发电侧', '现货市场', '成本', '变动成本', '元', '分时', NULL, 5, '实时变动-合约变动', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (108, 'CONTRACT_MARGIN', '合约边际贡献', 2, '发电侧', '中长期市场', '边际贡献', '合约边际', '元', '分时', NULL, 5, '合约电费-合约变动成本', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (109, 'DAM_DEV_MARGIN', '日前偏差边际贡献', 2, '发电侧', '现货市场', '边际贡献', '日前偏差', '元', '分时', NULL, 5, '日前偏差电费-偏差×变动成本', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (110, 'RTM_DEV_MARGIN', '实时偏差边际贡献', 2, '发电侧', '现货市场', '边际贡献', '实时偏差', '元', '分时', NULL, 5, '实时偏差电费-偏差×变动成本', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (111, 'SPOT_DEV_MARGIN', '现货偏差边际贡献', 2, '发电侧', '现货市场', '边际贡献', '现货偏差', '元', '分时', NULL, 5, '总边际-合约边际', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (112, 'RTM_FULL_MARGIN', '实时全电量边际贡献', 2, '发电侧', '现货市场', '边际贡献', '实时全量', '元', '分时', NULL, 5, '实时全量电费-变动成本', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (113, 'TOTAL_MARGIN', '总边际贡献', 2, '发电侧', '现货市场', '边际贡献', '总边际', '元', '分时', NULL, 5, '总电费-实时变动成本', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (114, 'TOTAL_MARGIN_WITH_MKT', '总边际贡献(含市场运行费)', 2, '发电侧', '现货市场', '边际贡献', '含市场费', '元', '分时', NULL, 5, '含市场费总电费-变动成本', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (115, 'SPOT_FULL_MARGIN', '现货全电量贡献', 2, '发电侧', '现货市场', '边际贡献', '现货全量', '元', '分时', NULL, 5, '现货全量电费-变动成本', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (116, 'SPOT_FULL_DEGREE_MARGIN', '现货全电量度电贡献', 2, '发电侧', '现货市场', '边际贡献', '度电贡献', '元/MWh', '分时', NULL, 5, '现货全量贡献/上网电量', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (117, 'RTM_FULL_DEGREE_MARGIN', '实时全电量度电边际贡献', 2, '发电侧', '现货市场', '边际贡献', '度电贡献', '元/MWh', '分时', NULL, 5, '实时全量边际/上网电量', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (118, 'DAM_DEV_POS_MARGIN', '日前正偏差贡献', 2, '发电侧', '现货市场', '边际贡献', '日前正偏差', '元', '分时', NULL, 5, '正偏差取偏差贡献', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (119, 'DAM_DEV_NEG_MARGIN', '日前负偏差贡献', 2, '发电侧', '现货市场', '边际贡献', '日前负偏差', '元', '分时', NULL, 5, '负偏差取偏差贡献', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (120, 'RTM_DEV_POS_MARGIN', '实时正偏差贡献', 2, '发电侧', '现货市场', '边际贡献', '实时正偏差', '元', '分时', NULL, 5, '正偏差取偏差贡献', 1, 1, 0);

-- 指标 #121: RTM_DEV_NEG_MARGIN - 实时负偏差贡献
INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (121, 'RTM_DEV_NEG_MARGIN', '实时负偏差贡献', 2, '发电侧', '现货市场', '边际贡献', '实时负偏差', '元', '分时', NULL, 5, '负偏差取偏差贡献', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (122, 'SPOT_DEV_POS_MARGIN', '现货正偏差贡献', 2, '发电侧', '现货市场', '边际贡献', '现货正偏差', '元', '分时', NULL, 5, '正偏差电费-变动成本', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (123, 'SPOT_DEV_NEG_MARGIN', '现货负偏差贡献', 2, '发电侧', '现货市场', '边际贡献', '现货负偏差', '元', '分时', NULL, 5, '负偏差电费-变动成本', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (124, 'BASE_LOAD_RATE', '基数负荷率', 2, '发电侧', '中长期市场', '负荷率', '基数', '%', '分时', NULL, 6, '基数电量/额定净容量', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (125, 'BASE_COVERAGE_RATE', '基数覆盖率', 2, '发电侧', '中长期市场', '覆盖率', '基数', '%', '分时', NULL, 6, '基数电量/上网电量', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (126, 'MLT_LOAD_RATE', '中长期合约负荷率', 2, '发电侧', '中长期市场', '负荷率', '中长期', '%', '分时', NULL, 6, '中长期电量/额定净容量', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (127, 'MLT_COVERAGE_RATE', '中长期合约覆盖率', 2, '发电侧', '中长期市场', '覆盖率', '中长期', '%', '分时', NULL, 6, '中长期电量/上网电量', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (128, 'CONTRACT_LOAD_RATE', '合约负荷率', 2, '发电侧', '中长期市场', '负荷率', '合约', '%', '分时', NULL, 6, '合约电量/额定净容量', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (129, 'CONTRACT_COVERAGE_RATE', '合约覆盖率', 2, '发电侧', '中长期市场', '覆盖率', '合约', '%', '分时', NULL, 6, '合约电量/上网电量', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (130, 'DAM_LOAD_RATE', '机组日前负荷率', 2, '发电侧', '现货市场', '负荷率', '日前', '%', '分时', NULL, 6, '日前出力/额定容量', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (131, 'DAM_AVG_LOAD_RATE', '日前负荷率', 2, '发电侧', '现货市场', '负荷率', '日前', '%', '分时', NULL, 6, '日前出力/额定容量', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (132, 'RTM_LOAD_RATE', '机组实时负荷率', 2, '发电侧', '现货市场', '负荷率', '实时', '%', '分时', NULL, 6, '实时出力/额定容量', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (133, 'RTM_AVG_LOAD_RATE', '实时负荷率', 2, '发电侧', '现货市场', '负荷率', '实时', '%', '分时', NULL, 6, '实际出力/额定容量', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (134, 'CAP_YEARLY_RECOVERY', '年累计回收情况', 2, '发电侧', '容量市场', '容量', '回收率', '%', '年', NULL, 6, '实收/应收', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (135, 'REVENUE_COMPLETION_RATE', '收入完成率', 2, '发电侧', '现货市场', '经营', '完成率', '%', '分时', NULL, 7, '实际收入/计划收入', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (136, 'ENERGY_COMPLETION_RATE', '发电量完成率', 2, '发电侧', '现货市场', '经营', '完成率', '%', '分时', NULL, 7, '实际发电量/计划发电量', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (137, 'UTILIZATION_HOURS', '可利用小时数', 2, '发电侧', '现货市场', '经营', '可利用小时', 'h', '分时', NULL, 7, '上网电量/装机容量', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (138, 'PER_UNIT_REVENUE', '度电收益', 2, '发电侧', '现货市场', '经营', '度电收益', '元/MWh', '分时', NULL, 7, '总电费/上网电量', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (139, 'ENERGY_YOY', '电量-同比', 2, '发电侧', '现货市场', '同比', '电量', '%', '分时', NULL, 8, '(本期-去年同期)/去年同期', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (140, 'FEE_YOY', '电费-同比', 2, '发电侧', '现货市场', '同比', '电费', '%', '分时', NULL, 8, '(本期-去年同期)/去年同期', 1, 1, 0);

-- 指标 #141: UTIL_HOURS_YOY - 可利用小时数-同比
INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (141, 'UTIL_HOURS_YOY', '可利用小时数-同比', 2, '发电侧', '现货市场', '同比', '可利用小时', '%', '分时', NULL, 8, '(本期-去年同期)/去年同期', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (142, 'REVENUE_YOY', '收益-同比', 2, '发电侧', '现货市场', '同比', '收益', '%', '分时', NULL, 8, '(本期-去年同期)/去年同期', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (143, 'UNIT_COST_YOY', '度电成本-同比', 2, '发电侧', '现货市场', '同比', '度电成本', '%', '分时', NULL, 8, '(本期-去年同期)/去年同期', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (144, 'UNIT_REVENUE_YOY', '度电收益-同比', 2, '发电侧', '现货市场', '同比', '度电收益', '%', '分时', NULL, 8, '(本期-去年同期)/去年同期', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (145, 'CERT_PRICE_YOY', '绿证价格-同比', 2, '发电侧', '现货市场', '同比', '绿证', '%', '分时', NULL, 8, '(本期-去年同期)/去年同期', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (146, 'CERT_VOL_YOY', '绿证个数-同比', 2, '发电侧', '现货市场', '同比', '绿证', '%', '分时', NULL, 8, '(本期-去年同期)/去年同期', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (147, 'ASSESS_YOY', '考核费用-同比', 2, '发电侧', '现货市场', '同比', '考核', '%', '分时', NULL, 8, '(本期-去年同期)/去年同期', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (148, 'COMPENSATE_YOY', '补偿费用-同比', 2, '发电侧', '现货市场', '同比', '补偿', '%', '分时', NULL, 8, '(本期-去年同期)/去年同期', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (149, 'SHARE_YOY', '分摊费用-同比', 2, '发电侧', '现货市场', '同比', '分摊', '%', '分时', NULL, 8, '(本期-去年同期)/去年同期', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (150, 'RETURN_YOY', '返还费用-同比', 2, '发电侧', '现货市场', '同比', '返还', '%', '分时', NULL, 8, '(本期-去年同期)/去年同期', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (151, 'ENERGY_MOM', '电量-环比', 2, '发电侧', '现货市场', '环比', '电量', '%', '分时', NULL, 8, '(本期-上期)/上期', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (152, 'FEE_MOM', '电费-环比', 2, '发电侧', '现货市场', '环比', '电费', '%', '分时', NULL, 8, '(本期-上期)/上期', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (153, 'UTIL_HOURS_MOM', '可利用小时数-环比', 2, '发电侧', '现货市场', '环比', '可利用小时', '%', '分时', NULL, 8, '(本期-上期)/上期', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (154, 'REVENUE_MOM', '收益-环比', 2, '发电侧', '现货市场', '环比', '收益', '%', '分时', NULL, 8, '(本期-上期)/上期', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (155, 'UNIT_COST_MOM', '度电成本-环比', 2, '发电侧', '现货市场', '环比', '度电成本', '%', '分时', NULL, 8, '(本期-上期)/上期', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (156, 'UNIT_REVENUE_MOM', '度电收益-环比', 2, '发电侧', '现货市场', '环比', '度电收益', '%', '分时', NULL, 8, '(本期-上期)/上期', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (157, 'CERT_PRICE_MOM', '绿证价格-环比', 2, '发电侧', '现货市场', '环比', '绿证', '%', '分时', NULL, 8, '(本期-上期)/上期', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (158, 'CERT_VOL_MOM', '绿证个数-环比', 2, '发电侧', '现货市场', '环比', '绿证', '%', '分时', NULL, 8, '(本期-上期)/上期', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (159, 'ASSESS_MOM', '考核费用-环比', 2, '发电侧', '现货市场', '环比', '考核', '%', '分时', NULL, 8, '(本期-上期)/上期', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (160, 'COMPENSATE_MOM', '补偿费用-环比', 2, '发电侧', '现货市场', '环比', '补偿', '%', '分时', NULL, 8, '(本期-上期)/上期', 1, 1, 0);

-- 指标 #161: SHARE_MOM - 分摊费用-环比
INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (161, 'SHARE_MOM', '分摊费用-环比', 2, '发电侧', '现货市场', '环比', '分摊', '%', '分时', NULL, 8, '(本期-上期)/上期', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (162, 'RETURN_MOM', '返还费用-环比', 2, '发电侧', '现货市场', '环比', '返还', '%', '分时', NULL, 8, '(本期-上期)/上期', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (163, 'REVENUE_TOP10', '收益TOP10', 2, '集团公司', '现货市场', '排名', '收益', '元', '分时', NULL, 9, '二级公司-电厂-交易单元排名', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (164, 'UNIT_REVENUE_TOP10', '度电收益TOP10', 2, '集团公司', '现货市场', '排名', '度电收益', '元/MWh', '分时', NULL, 9, '度电收益排名', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (165, 'ENERGY_TOP10', '发电量TOP10', 2, '集团公司', '现货市场', '排名', '发电量', 'MWh', '分时', NULL, 9, '发电量排名', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (166, 'UTIL_HOURS_TOP10', '可利用小时数TOP10', 2, '集团公司', '现货市场', '排名', '可利用小时', 'h', '分时', NULL, 9, '可利用小时排名', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (167, 'UNIT_COST_TOP10', '度电成本TOP10', 2, '集团公司', '现货市场', '排名', '度电成本', '元/MWh', '分时', NULL, 9, '度电成本排名(升序)', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (168, 'GRP_GREEN_ENERGY', '绿电', 2, '集团公司', '绿色权益', '绿电', '电量', 'MWh', '日/月/年', '需接入绿证系统', 7, '统计绿电合计值', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (169, 'GRP_GREEN_PRICE', '绿电电价', 2, '集团公司', '绿色权益', '绿电', '电价', '元/MWh', '日/月/年', '需接入绿证系统', 7, '绿电加权均价', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (170, 'GRP_CERT_COUNT', '绿证个数', 2, '集团公司', '绿色权益', '绿证', '个数', '个', '月/年', NULL, 7, '绿证总数', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (171, 'GRP_CERT_PRICE', '绿证价格', 2, '集团公司', '绿色权益', '绿证', '价格', '元/个', '月/年', '需接入绿证系统', 7, '绿证加权均价', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (172, 'GRP_MLT_ENERGY', '中长期合约电量(集团)', 2, '集团公司', '绿色权益', '中长期', '电量', 'MWh', '日/月/年', NULL, 7, '集团维度中长期电量', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (173, 'GRP_MLT_PRICE', '中长期合约电价(集团)', 2, '集团公司', '绿色权益', '中长期', '电价', '元/MWh', '日/月/年', NULL, 7, '集团维度中长期均价', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (174, 'GRP_MLT_FEE', '中长期合约电费(集团)', 2, '集团公司', '绿色权益', '中长期', '电费', '元', '日/月/年', NULL, 7, '集团维度中长期电费', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (175, 'GRP_BASE_ENERGY', '基数电量(集团)', 2, '集团公司', '现货市场', '电量', '基数', 'MWh', '日/月/年', NULL, 7, '集团基数电量汇总', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (176, 'GRP_BASE_PRICE', '基数电价(集团)', 2, '集团公司', '现货市场', '电价', '基数', '元/MWh', '日/月/年', NULL, 7, '集团基数加权均价', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (177, 'GRP_BASE_FEE', '基数电费(集团)', 2, '集团公司', '现货市场', '电费', '基数', '元', '日/月/年', NULL, 7, '集团基数电费汇总', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (178, 'GRP_DAM_DEV_ENERGY', '日前偏差电量(集团)', 2, '集团公司', '现货市场', '电量', '日前偏差', 'MWh', '日/月/年', NULL, 7, '集团日前偏差汇总', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (179, 'GRP_DAM_DEV_PRICE', '日前偏差电价(集团)', 2, '集团公司', '现货市场', '电价', '日前偏差', '元/MWh', '日/月/年', NULL, 7, '集团日前偏差均价', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (180, 'GRP_DAM_DEV_FEE', '日前偏差电费(集团)', 2, '集团公司', '现货市场', '电费', '日前偏差', '元', '日/月/年', NULL, 7, '集团日前偏差电费汇总', 1, 1, 0);

-- 指标 #181: GRP_RTM_DEV_ENERGY - 实时偏差电量(集团)
INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (181, 'GRP_RTM_DEV_ENERGY', '实时偏差电量(集团)', 2, '集团公司', '现货市场', '电量', '实时偏差', 'MWh', '日/月/年', NULL, 7, '集团实时偏差汇总', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (182, 'GRP_RTM_DEV_PRICE', '实时偏差电价(集团)', 2, '集团公司', '现货市场', '电价', '实时偏差', '元/MWh', '日/月/年', NULL, 7, '集团实时偏差均价', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (183, 'GRP_RTM_DEV_FEE', '实时偏差电费(集团)', 2, '集团公司', '现货市场', '电费', '实时偏差', '元', '日/月/年', NULL, 7, '集团实时偏差电费汇总', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (184, 'GRP_INT_ENERGY', '省间电量(集团)', 2, '集团公司', '现货市场', '电量', '省间', 'MWh', '日/月/年', NULL, 7, '集团省间电量汇总', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (185, 'GRP_INT_PRICE', '省间电价(集团)', 2, '集团公司', '现货市场', '电价', '省间', '元/MWh', '日/月/年', NULL, 7, '集团省间加权均价', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (186, 'GRP_INT_FEE', '省间电费(集团)', 2, '集团公司', '现货市场', '电费', '省间', '元', '日/月/年', NULL, 7, '集团省间电费汇总', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (187, 'GRP_PER_UNIT_REVENUE', '度电收益(集团)', 2, '集团公司', '现货市场', '经营', '度电收益', '元', '日/月/年', NULL, 7, '集团总电费/总上网', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (188, 'GRP_UTIL_HOURS', '可利用小时数(集团)', 2, '集团公司', '现货市场', '经营', '可利用小时', 'h', '日/月/年', NULL, 7, '集团总上网/总装机', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (189, 'GRP_ENERGY_COMPLETION', '计划发电量完成比(集团)', 2, '集团公司', '现货市场', '经营', '完成率', '%', '日/月/年', NULL, 7, '累计发电/计划', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (190, 'GRP_REVENUE_COMPLETION', '计划收益完成比(集团)', 2, '集团公司', '现货市场', '经营', '完成率', '%', '日/月/年', NULL, 7, '累计收益/计划', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (191, 'GRP_ASSESS_FEE', '考核费用(集团)', 2, '集团公司', '辅助服务市场', '电费', '考核', '元', '月/年', NULL, 7, '集团考核费用汇总', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (192, 'GRP_RETURN_FEE', '返还费用(集团)', 2, '集团公司', '辅助服务市场', '电费', '返还', '元', '月/年', NULL, 7, '集团返还费用汇总', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (193, 'GRP_SHARE_FEE', '分摊费用(集团)', 2, '集团公司', '辅助服务市场', '电费', '分摊', '元', '月/年', NULL, 7, '集团分摊费用汇总', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (194, 'GRP_COMPENSATE_FEE', '补偿费用(集团)', 2, '集团公司', '辅助服务市场', '电费', '补偿', '元', '月/年', NULL, 7, '集团补偿费用汇总', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (195, 'GRP_INSTALLED_CAP', '装机容量(集团)', 2, '集团公司', '容量市场', '容量', '装机', 'MW', '-', NULL, 7, '集团装机汇总', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (196, 'GRP_EFFECTIVE_CAP', '有效容量(集团)', 2, '集团公司', '容量市场', '容量', '有效', 'MW', '-', NULL, 7, '集团有效容量汇总', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (197, 'GRP_CAPACITY_FEE', '容量电费(集团)', 2, '集团公司', '容量市场', '电费', '容量', '元', '月/年', NULL, 7, '集团容量电费汇总', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (198, 'GRP_CAPACITY_PRICE', '容量电价(集团)', 2, '集团公司', '容量市场', '电价', '容量', '元/MW', '月/年', NULL, 7, '集团容量电价汇总', 1, 1, 0);

INSERT INTO ind_indicator_def (id, indicator_code, indicator_name, indicator_type, subject_type, market_type, category_l1, category_l2, unit, time_grain, data_source, calc_layer, description, status, tenant_id, del_flag)
VALUES (199, 'GRP_CAP_YEARLY_RECOVERY', '年累计回收情况(集团)', 2, '集团公司', '容量市场', '容量', '回收率', '元', '年', NULL, 7, '集团维度年累计回收', 1, 1, 0);

-- Total indicator definitions: 199

-- ============================================================
-- SECTION 3: 计算公式 ind_calc_formula
-- ============================================================

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (1, 18, 'BIDDING_SPACE', 1,
    '统调负荷-新能源出力+联络线-地方电厂-非市场化电量',
    NULL,
    '',
    0
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (2, 39, 'MLT_CONTRACT_ENERGY', 1,
    '{BASE_CLEARING_ENERGY} + {MLT_CLEARING_ENERGY}',
    '["BASE_CLEARING_ENERGY", "MLT_CLEARING_ENERGY"]',
    'BASE_CLEARING_ENERGY,MLT_CLEARING_ENERGY',
    1
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (3, 40, 'BASE_OUTPUT', 1,
    '{BASE_CLEARING_ENERGY} / (1 - {AUX_RATE}/100) / 4',
    '["BASE_CLEARING_ENERGY", "AUX_RATE"]',
    'BASE_CLEARING_ENERGY,AUX_RATE',
    1
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (4, 41, 'MLT_OUTPUT', 1,
    '{MLT_CLEARING_ENERGY} / (1 - {AUX_RATE}/100) / 4',
    '["MLT_CLEARING_ENERGY", "AUX_RATE"]',
    'MLT_CLEARING_ENERGY,AUX_RATE',
    1
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, condition_expr, true_value_expr, false_value)
VALUES (5, 44, 'MLT_CONTRACT_PRICE', 2,
    'IF({MLT_CONTRACT_ENERGY}<>0, {MLT_CONTRACT_FEE}/{MLT_CONTRACT_ENERGY}, 0)',
    '["MLT_CONTRACT_FEE", "MLT_CONTRACT_ENERGY"]',
    'MLT_CONTRACT_FEE,MLT_CONTRACT_ENERGY',
    1, '{MLT_CONTRACT_ENERGY}<>0', '{MLT_CONTRACT_FEE}/{MLT_CONTRACT_ENERGY}', '0'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (6, 45, 'DAM_DEV_ENERGY', 1,
    '{DAM_CLEARING_ENERGY} - {MLT_CONTRACT_ENERGY}',
    '["DAM_CLEARING_ENERGY", "MLT_CONTRACT_ENERGY"]',
    'DAM_CLEARING_ENERGY,MLT_CONTRACT_ENERGY',
    2
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (7, 46, 'RTM_DEV_ENERGY', 1,
    '{ONLINE_ENERGY} - {DAM_CLEARING_ENERGY}',
    '["ONLINE_ENERGY", "DAM_CLEARING_ENERGY"]',
    'ONLINE_ENERGY,DAM_CLEARING_ENERGY',
    2
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (8, 47, 'SPOT_DEV_ENERGY', 1,
    '{DAM_DEV_ENERGY} + {RTM_DEV_ENERGY}',
    '["DAM_DEV_ENERGY", "RTM_DEV_ENERGY"]',
    'DAM_DEV_ENERGY,RTM_DEV_ENERGY',
    2
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, condition_expr, true_value_expr, false_value)
VALUES (9, 48, 'DAM_DEV_POS_ENERGY', 2,
    'IF({DAM_DEV_ENERGY}>=0, {DAM_DEV_ENERGY}, 0)',
    '["DAM_DEV_ENERGY"]',
    'DAM_DEV_ENERGY',
    2, '{DAM_DEV_ENERGY}>=0', '{DAM_DEV_ENERGY}', '0'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, condition_expr, true_value_expr, false_value)
VALUES (10, 49, 'DAM_DEV_NEG_ENERGY', 2,
    'IF({DAM_DEV_ENERGY}<0, {DAM_DEV_ENERGY}, 0)',
    '["DAM_DEV_ENERGY"]',
    'DAM_DEV_ENERGY',
    2, '{DAM_DEV_ENERGY}<0', '{DAM_DEV_ENERGY}', '0'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, condition_expr, true_value_expr, false_value)
VALUES (11, 50, 'RTM_DEV_POS_ENERGY', 2,
    'IF({RTM_DEV_ENERGY}>=0, {RTM_DEV_ENERGY}, 0)',
    '["RTM_DEV_ENERGY"]',
    'RTM_DEV_ENERGY',
    2, '{RTM_DEV_ENERGY}>=0', '{RTM_DEV_ENERGY}', '0'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, condition_expr, true_value_expr, false_value)
VALUES (12, 51, 'RTM_DEV_NEG_ENERGY', 2,
    'IF({RTM_DEV_ENERGY}<0, {RTM_DEV_ENERGY}, 0)',
    '["RTM_DEV_ENERGY"]',
    'RTM_DEV_ENERGY',
    2, '{RTM_DEV_ENERGY}<0', '{RTM_DEV_ENERGY}', '0'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, condition_expr, true_value_expr, false_value)
VALUES (13, 52, 'SPOT_DEV_POS_ENERGY', 2,
    'IF({SPOT_DEV_ENERGY}>=0, {SPOT_DEV_ENERGY}, 0)',
    '["SPOT_DEV_ENERGY"]',
    'SPOT_DEV_ENERGY',
    2, '{SPOT_DEV_ENERGY}>=0', '{SPOT_DEV_ENERGY}', '0'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, condition_expr, true_value_expr, false_value)
VALUES (14, 53, 'SPOT_DEV_NEG_ENERGY', 2,
    'IF({SPOT_DEV_ENERGY}<0, {SPOT_DEV_ENERGY}, 0)',
    '["SPOT_DEV_ENERGY"]',
    'SPOT_DEV_ENERGY',
    2, '{SPOT_DEV_ENERGY}<0', '{SPOT_DEV_ENERGY}', '0'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (15, 54, 'INT_DAM_ENERGY', 1,
    '{INT_DAM_BID_OUTPUT} * 4',
    '["INT_DAM_BID_OUTPUT"]',
    'INT_DAM_BID_OUTPUT',
    1
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (16, 55, 'INT_RTM_ENERGY', 1,
    '{INT_RTM_BID_OUTPUT} * 4',
    '["INT_RTM_BID_OUTPUT"]',
    'INT_RTM_BID_OUTPUT',
    1
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (17, 56, 'INT_SPOT_ENERGY', 1,
    '{INT_DAM_ENERGY} + {INT_RTM_ENERGY}',
    '["INT_DAM_ENERGY", "INT_RTM_ENERGY"]',
    'INT_DAM_ENERGY,INT_RTM_ENERGY',
    2
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (18, 57, 'GRN_CERT_FEE', 1,
    '{GRN_CERT_TRADE_PRICE} * {GRN_CERT_TRADE_VOL}',
    '["GRN_CERT_TRADE_PRICE", "GRN_CERT_TRADE_VOL"]',
    'GRN_CERT_TRADE_PRICE,GRN_CERT_TRADE_VOL',
    1
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (19, 58, 'BASE_FEE', 1,
    '{BASE_CLEARING_PRICE} * {BASE_CLEARING_ENERGY}',
    '["BASE_CLEARING_PRICE", "BASE_CLEARING_ENERGY"]',
    'BASE_CLEARING_PRICE,BASE_CLEARING_ENERGY',
    3
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (20, 59, 'MLT_FEE', 1,
    '{MLT_CLEARING_PRICE} * {MLT_CLEARING_ENERGY}',
    '["MLT_CLEARING_PRICE", "MLT_CLEARING_ENERGY"]',
    'MLT_CLEARING_PRICE,MLT_CLEARING_ENERGY',
    3
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (21, 60, 'MLT_CONTRACT_FEE', 1,
    '{BASE_FEE} + {MLT_FEE}',
    '["BASE_FEE", "MLT_FEE"]',
    'BASE_FEE,MLT_FEE',
    3
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (22, 61, 'DAM_FULL_FEE', 1,
    '{DAM_CLEARING_ENERGY} * {DAM_CLEARING_PRICE}',
    '["DAM_CLEARING_ENERGY", "DAM_CLEARING_PRICE"]',
    'DAM_CLEARING_ENERGY,DAM_CLEARING_PRICE',
    3
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (23, 62, 'RTM_FULL_FEE', 1,
    '{RTM_CLEARING_ENERGY} * {RTM_CLEARING_PRICE}',
    '["RTM_CLEARING_ENERGY", "RTM_CLEARING_PRICE"]',
    'RTM_CLEARING_ENERGY,RTM_CLEARING_PRICE',
    3
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (24, 63, 'DAM_DEV_FEE', 1,
    '{DAM_DEV_ENERGY} * {DAM_CLEARING_PRICE}',
    '["DAM_DEV_ENERGY", "DAM_CLEARING_PRICE"]',
    'DAM_DEV_ENERGY,DAM_CLEARING_PRICE',
    3
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (25, 64, 'RTM_DEV_FEE', 1,
    '{RTM_DEV_ENERGY} * {RTM_CLEARING_PRICE}',
    '["RTM_DEV_ENERGY", "RTM_CLEARING_PRICE"]',
    'RTM_DEV_ENERGY,RTM_CLEARING_PRICE',
    3
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (26, 65, 'SPOT_DEV_FEE', 1,
    '{DAM_DEV_FEE} + {RTM_DEV_FEE}',
    '["DAM_DEV_FEE", "RTM_DEV_FEE"]',
    'DAM_DEV_FEE,RTM_DEV_FEE',
    3
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, condition_expr, true_value_expr, false_value)
VALUES (27, 66, 'DAM_DEV_POS_FEE', 2,
    'IF({DAM_DEV_ENERGY}>=0, {DAM_DEV_FEE}, 0)',
    '["DAM_DEV_ENERGY", "DAM_DEV_FEE"]',
    'DAM_DEV_ENERGY,DAM_DEV_FEE',
    3, '{DAM_DEV_ENERGY}>=0', '{DAM_DEV_FEE}', '0'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, condition_expr, true_value_expr, false_value)
VALUES (28, 67, 'DAM_DEV_NEG_FEE', 2,
    'IF({DAM_DEV_ENERGY}<0, {DAM_DEV_FEE}, 0)',
    '["DAM_DEV_ENERGY", "DAM_DEV_FEE"]',
    'DAM_DEV_ENERGY,DAM_DEV_FEE',
    3, '{DAM_DEV_ENERGY}<0', '{DAM_DEV_FEE}', '0'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, condition_expr, true_value_expr, false_value)
VALUES (29, 68, 'RTM_DEV_POS_FEE', 2,
    'IF({RTM_DEV_ENERGY}>=0, {RTM_DEV_FEE}, 0)',
    '["RTM_DEV_ENERGY", "RTM_DEV_FEE"]',
    'RTM_DEV_ENERGY,RTM_DEV_FEE',
    3, '{RTM_DEV_ENERGY}>=0', '{RTM_DEV_FEE}', '0'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, condition_expr, true_value_expr, false_value)
VALUES (30, 69, 'RTM_DEV_NEG_FEE', 2,
    'IF({RTM_DEV_ENERGY}<0, {RTM_DEV_FEE}, 0)',
    '["RTM_DEV_ENERGY", "RTM_DEV_FEE"]',
    'RTM_DEV_ENERGY,RTM_DEV_FEE',
    3, '{RTM_DEV_ENERGY}<0', '{RTM_DEV_FEE}', '0'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, condition_expr, true_value_expr, false_value)
VALUES (31, 70, 'SPOT_DEV_POS_FEE', 2,
    'IF({SPOT_DEV_ENERGY}>=0, {SPOT_DEV_FEE}, 0)',
    '["SPOT_DEV_ENERGY", "SPOT_DEV_FEE"]',
    'SPOT_DEV_ENERGY,SPOT_DEV_FEE',
    3, '{SPOT_DEV_ENERGY}>=0', '{SPOT_DEV_FEE}', '0'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, condition_expr, true_value_expr, false_value)
VALUES (32, 71, 'SPOT_DEV_NEG_FEE', 2,
    'IF({SPOT_DEV_ENERGY}<0, {SPOT_DEV_FEE}, 0)',
    '["SPOT_DEV_ENERGY", "SPOT_DEV_FEE"]',
    'SPOT_DEV_ENERGY,SPOT_DEV_FEE',
    3, '{SPOT_DEV_ENERGY}<0', '{SPOT_DEV_FEE}', '0'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (33, 72, 'SPOT_FULL_FEE', 1,
    '{DAM_FULL_FEE} + {RTM_DEV_ENERGY} * {RTM_CLEARING_PRICE}',
    '["DAM_FULL_FEE", "RTM_DEV_ENERGY", "RTM_CLEARING_PRICE"]',
    'DAM_FULL_FEE,RTM_DEV_ENERGY,RTM_CLEARING_PRICE',
    3
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (34, 73, 'TOTAL_FEE', 1,
    '{MLT_CONTRACT_FEE} + {DAM_DEV_FEE} + {RTM_DEV_FEE}',
    '["MLT_CONTRACT_FEE", "DAM_DEV_FEE", "RTM_DEV_FEE"]',
    'MLT_CONTRACT_FEE,DAM_DEV_FEE,RTM_DEV_FEE',
    3
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, condition_expr, true_value_expr, false_value)
VALUES (35, 75, 'AVG_PRICE_WITH_MKT', 2,
    'IF({ONLINE_ENERGY}<>0, {TOTAL_FEE_WITH_MKT}/{ONLINE_ENERGY}, 0)',
    '["TOTAL_FEE_WITH_MKT", "ONLINE_ENERGY"]',
    'TOTAL_FEE_WITH_MKT,ONLINE_ENERGY',
    3, '{ONLINE_ENERGY}<>0', '{TOTAL_FEE_WITH_MKT}/{ONLINE_ENERGY}', '0'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, condition_expr, true_value_expr, false_value)
VALUES (36, 76, 'DAM_DEV_PRICE', 2,
    'IF({DAM_DEV_ENERGY}<>0, {DAM_DEV_FEE}/{DAM_DEV_ENERGY}, 0)',
    '["DAM_DEV_FEE", "DAM_DEV_ENERGY"]',
    'DAM_DEV_FEE,DAM_DEV_ENERGY',
    3, '{DAM_DEV_ENERGY}<>0', '{DAM_DEV_FEE}/{DAM_DEV_ENERGY}', '0'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, condition_expr, true_value_expr, false_value)
VALUES (37, 77, 'RTM_DEV_PRICE', 2,
    'IF({RTM_DEV_ENERGY}<>0, {RTM_DEV_FEE}/{RTM_DEV_ENERGY}, 0)',
    '["RTM_DEV_FEE", "RTM_DEV_ENERGY"]',
    'RTM_DEV_FEE,RTM_DEV_ENERGY',
    3, '{RTM_DEV_ENERGY}<>0', '{RTM_DEV_FEE}/{RTM_DEV_ENERGY}', '0'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, condition_expr, true_value_expr, false_value)
VALUES (38, 78, 'SPOT_DEV_PRICE', 2,
    'IF({SPOT_DEV_ENERGY}<>0, {SPOT_DEV_FEE}/{SPOT_DEV_ENERGY}, 0)',
    '["SPOT_DEV_FEE", "SPOT_DEV_ENERGY"]',
    'SPOT_DEV_FEE,SPOT_DEV_ENERGY',
    3, '{SPOT_DEV_ENERGY}<>0', '{SPOT_DEV_FEE}/{SPOT_DEV_ENERGY}', '0'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, condition_expr, true_value_expr, false_value)
VALUES (39, 79, 'DAM_DEV_POS_PRICE', 2,
    'IF({DAM_DEV_POS_FEE}<>0, {DAM_DEV_POS_FEE}/{DAM_DEV_POS_ENERGY}, 0)',
    '["DAM_DEV_POS_FEE", "DAM_DEV_POS_ENERGY"]',
    'DAM_DEV_POS_FEE,DAM_DEV_POS_ENERGY',
    3, '{DAM_DEV_POS_FEE}<>0', '{DAM_DEV_POS_FEE}/{DAM_DEV_POS_ENERGY}', '0'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, condition_expr, true_value_expr, false_value)
VALUES (40, 80, 'DAM_DEV_NEG_PRICE', 2,
    'IF({DAM_DEV_NEG_FEE}<>0, {DAM_DEV_NEG_FEE}/{DAM_DEV_NEG_ENERGY}, 0)',
    '["DAM_DEV_NEG_FEE", "DAM_DEV_NEG_ENERGY"]',
    'DAM_DEV_NEG_FEE,DAM_DEV_NEG_ENERGY',
    3, '{DAM_DEV_NEG_FEE}<>0', '{DAM_DEV_NEG_FEE}/{DAM_DEV_NEG_ENERGY}', '0'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, condition_expr, true_value_expr, false_value)
VALUES (41, 81, 'RTM_DEV_POS_PRICE', 2,
    'IF({RTM_DEV_POS_FEE}<>0, {RTM_DEV_POS_FEE}/{RTM_DEV_POS_ENERGY}, 0)',
    '["RTM_DEV_POS_FEE", "RTM_DEV_POS_ENERGY"]',
    'RTM_DEV_POS_FEE,RTM_DEV_POS_ENERGY',
    3, '{RTM_DEV_POS_FEE}<>0', '{RTM_DEV_POS_FEE}/{RTM_DEV_POS_ENERGY}', '0'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, condition_expr, true_value_expr, false_value)
VALUES (42, 82, 'RTM_DEV_NEG_PRICE', 2,
    'IF({RTM_DEV_NEG_FEE}<>0, {RTM_DEV_NEG_FEE}/{RTM_DEV_NEG_ENERGY}, 0)',
    '["RTM_DEV_NEG_FEE", "RTM_DEV_NEG_ENERGY"]',
    'RTM_DEV_NEG_FEE,RTM_DEV_NEG_ENERGY',
    3, '{RTM_DEV_NEG_FEE}<>0', '{RTM_DEV_NEG_FEE}/{RTM_DEV_NEG_ENERGY}', '0'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, condition_expr, true_value_expr, false_value)
VALUES (43, 83, 'SPOT_DEV_POS_PRICE', 2,
    'IF({SPOT_DEV_POS_FEE}<>0, {SPOT_DEV_POS_FEE}/{SPOT_DEV_POS_ENERGY}, 0)',
    '["SPOT_DEV_POS_FEE", "SPOT_DEV_POS_ENERGY"]',
    'SPOT_DEV_POS_FEE,SPOT_DEV_POS_ENERGY',
    3, '{SPOT_DEV_POS_FEE}<>0', '{SPOT_DEV_POS_FEE}/{SPOT_DEV_POS_ENERGY}', '0'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, condition_expr, true_value_expr, false_value)
VALUES (44, 84, 'SPOT_DEV_NEG_PRICE', 2,
    'IF({SPOT_DEV_NEG_FEE}<>0, {SPOT_DEV_NEG_FEE}/{SPOT_DEV_NEG_ENERGY}, 0)',
    '["SPOT_DEV_NEG_FEE", "SPOT_DEV_NEG_ENERGY"]',
    'SPOT_DEV_NEG_FEE,SPOT_DEV_NEG_ENERGY',
    3, '{SPOT_DEV_NEG_FEE}<>0', '{SPOT_DEV_NEG_FEE}/{SPOT_DEV_NEG_ENERGY}', '0'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, condition_expr, true_value_expr, false_value)
VALUES (45, 85, 'SPOT_AVG_PRICE', 2,
    'IF({ONLINE_ENERGY}<>0, {SPOT_FULL_FEE}/{ONLINE_ENERGY}, 0)',
    '["SPOT_FULL_FEE", "ONLINE_ENERGY"]',
    'SPOT_FULL_FEE,ONLINE_ENERGY',
    3, '{ONLINE_ENERGY}<>0', '{SPOT_FULL_FEE}/{ONLINE_ENERGY}', '0'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, condition_expr, true_value_expr, false_value)
VALUES (46, 86, 'TOTAL_AVG_PRICE', 2,
    'IF({ONLINE_ENERGY}<>0, {TOTAL_FEE}/{ONLINE_ENERGY}, 0)',
    '["TOTAL_FEE", "ONLINE_ENERGY"]',
    'TOTAL_FEE,ONLINE_ENERGY',
    3, '{ONLINE_ENERGY}<>0', '{TOTAL_FEE}/{ONLINE_ENERGY}', '0'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (47, 87, 'INT_DAM_FEE', 1,
    '{INT_DAM_ENERGY} * {INT_DAM_PRICE}',
    '["INT_DAM_ENERGY", "INT_DAM_PRICE"]',
    'INT_DAM_ENERGY,INT_DAM_PRICE',
    3
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (48, 88, 'INT_RTM_FEE', 1,
    '{INT_RTM_ENERGY} * {INT_RTM_PRICE}',
    '["INT_RTM_ENERGY", "INT_RTM_PRICE"]',
    'INT_RTM_ENERGY,INT_RTM_PRICE',
    3
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (49, 89, 'INT_SPOT_FEE', 1,
    '{INT_DAM_FEE} + {INT_RTM_FEE}',
    '["INT_DAM_FEE", "INT_RTM_FEE"]',
    'INT_DAM_FEE,INT_RTM_FEE',
    3
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, condition_expr, true_value_expr, false_value)
VALUES (50, 90, 'INT_SPOT_AVG_PRICE', 2,
    'IF({INT_SPOT_ENERGY}<>0, {INT_SPOT_FEE}/{INT_SPOT_ENERGY}, 0)',
    '["INT_SPOT_FEE", "INT_SPOT_ENERGY"]',
    'INT_SPOT_FEE,INT_SPOT_ENERGY',
    3, '{INT_SPOT_ENERGY}<>0', '{INT_SPOT_FEE}/{INT_SPOT_ENERGY}', '0'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (51, 91, 'BASE_CFD_FEE', 1,
    '{BASE_CLEARING_ENERGY} * ({BASE_CLEARING_PRICE} - {DAM_CLEARING_PRICE})',
    '["BASE_CLEARING_ENERGY", "BASE_CLEARING_PRICE", "DAM_CLEARING_PRICE"]',
    'BASE_CLEARING_ENERGY,BASE_CLEARING_PRICE,DAM_CLEARING_PRICE',
    4
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (52, 92, 'MLT_CFD_FEE', 1,
    '{MLT_CLEARING_ENERGY} * ({MLT_CLEARING_PRICE} - {DAM_CLEARING_PRICE})',
    '["MLT_CLEARING_ENERGY", "MLT_CLEARING_PRICE", "DAM_CLEARING_PRICE"]',
    'MLT_CLEARING_ENERGY,MLT_CLEARING_PRICE,DAM_CLEARING_PRICE',
    4
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (53, 93, 'CONTRACT_CFD_FEE', 1,
    '{BASE_CFD_FEE} + {MLT_CFD_FEE}',
    '["BASE_CFD_FEE", "MLT_CFD_FEE"]',
    'BASE_CFD_FEE,MLT_CFD_FEE',
    4
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (54, 94, 'DAM_CFD_FEE', 1,
    '{DAM_DEV_ENERGY} * ({DAM_CLEARING_PRICE} - {RTM_CLEARING_PRICE})',
    '["DAM_DEV_ENERGY", "DAM_CLEARING_PRICE", "RTM_CLEARING_PRICE"]',
    'DAM_DEV_ENERGY,DAM_CLEARING_PRICE,RTM_CLEARING_PRICE',
    4
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, condition_expr, true_value_expr, false_value)
VALUES (55, 95, 'BASE_DEGREE_DIFF_PRICE', 2,
    'IF({BASE_CLEARING_ENERGY}<>0, {BASE_CFD_FEE}/{BASE_CLEARING_ENERGY}, 0)',
    '["BASE_CFD_FEE", "BASE_CLEARING_ENERGY"]',
    'BASE_CFD_FEE,BASE_CLEARING_ENERGY',
    4, '{BASE_CLEARING_ENERGY}<>0', '{BASE_CFD_FEE}/{BASE_CLEARING_ENERGY}', '0'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, condition_expr, true_value_expr, false_value)
VALUES (56, 96, 'CONTRACT_DEGREE_DIFF_PRICE', 2,
    'IF({MLT_CONTRACT_ENERGY}<>0, {CONTRACT_CFD_FEE}/{MLT_CONTRACT_ENERGY}, 0)',
    '["CONTRACT_CFD_FEE", "MLT_CONTRACT_ENERGY"]',
    'CONTRACT_CFD_FEE,MLT_CONTRACT_ENERGY',
    4, '{MLT_CONTRACT_ENERGY}<>0', '{CONTRACT_CFD_FEE}/{MLT_CONTRACT_ENERGY}', '0'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, condition_expr, true_value_expr, false_value)
VALUES (57, 97, 'MLT_DEGREE_DIFF_PRICE', 2,
    'IF({MLT_CLEARING_ENERGY}<>0, {MLT_CFD_FEE}/{MLT_CLEARING_ENERGY}, 0)',
    '["MLT_CFD_FEE", "MLT_CLEARING_ENERGY"]',
    'MLT_CFD_FEE,MLT_CLEARING_ENERGY',
    4, '{MLT_CLEARING_ENERGY}<>0', '{MLT_CFD_FEE}/{MLT_CLEARING_ENERGY}', '0'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, condition_expr, true_value_expr, false_value)
VALUES (58, 98, 'DAM_RTM_SPREAD', 2,
    'IF({DAM_CLEARING_ENERGY}<>0, {DAM_CFD_FEE}/{DAM_CLEARING_ENERGY}, 0)',
    '["DAM_CFD_FEE", "DAM_CLEARING_ENERGY"]',
    'DAM_CFD_FEE,DAM_CLEARING_ENERGY',
    4, '{DAM_CLEARING_ENERGY}<>0', '{DAM_CFD_FEE}/{DAM_CLEARING_ENERGY}', '0'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (59, 99, 'INT_DAM_INC_FEE', 1,
    '{INT_DAM_ENERGY} * ({INT_DAM_PRICE} - {RTM_CLEARING_PRICE})',
    '["INT_DAM_ENERGY", "INT_DAM_PRICE", "RTM_CLEARING_PRICE"]',
    'INT_DAM_ENERGY,INT_DAM_PRICE,RTM_CLEARING_PRICE',
    4
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (60, 100, 'INT_RTM_INC_FEE', 1,
    '{INT_RTM_ENERGY} * ({INT_RTM_PRICE} - {RTM_CLEARING_PRICE})',
    '["INT_RTM_ENERGY", "INT_RTM_PRICE", "RTM_CLEARING_PRICE"]',
    'INT_RTM_ENERGY,INT_RTM_PRICE,RTM_CLEARING_PRICE',
    4
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (61, 101, 'INT_SPOT_INC_FEE', 1,
    '{INT_DAM_INC_FEE} + {INT_RTM_INC_FEE}',
    '["INT_DAM_INC_FEE", "INT_RTM_INC_FEE"]',
    'INT_DAM_INC_FEE,INT_RTM_INC_FEE',
    4
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (62, 102, 'MLT_EXT_INC_FEE', 1,
    '{MLT_CONTRACT_ENERGY} * ({MLT_CONTRACT_PRICE} - {TOTAL_AVG_PRICE})',
    '["MLT_CONTRACT_ENERGY", "MLT_CONTRACT_PRICE", "TOTAL_AVG_PRICE"]',
    'MLT_CONTRACT_ENERGY,MLT_CONTRACT_PRICE,TOTAL_AVG_PRICE',
    4
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (63, 103, 'DAM_EXT_INC_FEE', 1,
    '{DAM_DEV_ENERGY} * ({DAM_CLEARING_PRICE} - {DAM_UNIFY_PRICE})',
    '["DAM_DEV_ENERGY", "DAM_CLEARING_PRICE"]',
    'DAM_DEV_ENERGY,DAM_CLEARING_PRICE',
    4
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (64, 104, 'RTM_EXT_INC_FEE', 1,
    '{RTM_DEV_ENERGY} * ({RTM_CLEARING_PRICE} - {RTM_UNIFY_PRICE})',
    '["RTM_DEV_ENERGY", "RTM_CLEARING_PRICE"]',
    'RTM_DEV_ENERGY,RTM_CLEARING_PRICE',
    4
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (65, 105, 'CONTRACT_VAR_COST', 1,
    '{RT_VAR_COST_PRICE} * {MLT_CONTRACT_ENERGY}',
    '["RT_VAR_COST_PRICE", "MLT_CONTRACT_ENERGY"]',
    'RT_VAR_COST_PRICE,MLT_CONTRACT_ENERGY',
    5
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (66, 106, 'RTM_VAR_COST', 1,
    '{RT_VAR_COST_PRICE} * {ONLINE_ENERGY}',
    '["RT_VAR_COST_PRICE", "ONLINE_ENERGY"]',
    'RT_VAR_COST_PRICE,ONLINE_ENERGY',
    5
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (67, 107, 'SPOT_VAR_COST', 1,
    '{RTM_VAR_COST} - {CONTRACT_VAR_COST}',
    '["RTM_VAR_COST", "CONTRACT_VAR_COST"]',
    'RTM_VAR_COST,CONTRACT_VAR_COST',
    5
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (68, 108, 'CONTRACT_MARGIN', 1,
    '{MLT_CONTRACT_FEE} - {CONTRACT_VAR_COST}',
    '["MLT_CONTRACT_FEE", "CONTRACT_VAR_COST"]',
    'MLT_CONTRACT_FEE,CONTRACT_VAR_COST',
    5
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (69, 109, 'DAM_DEV_MARGIN', 1,
    '{DAM_DEV_FEE} - {DAM_DEV_ENERGY} * {RT_VAR_COST_PRICE}',
    '["DAM_DEV_FEE", "DAM_DEV_ENERGY", "RT_VAR_COST_PRICE"]',
    'DAM_DEV_FEE,DAM_DEV_ENERGY,RT_VAR_COST_PRICE',
    5
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (70, 110, 'RTM_DEV_MARGIN', 1,
    '{RTM_DEV_FEE} - {RTM_DEV_ENERGY} * {RT_VAR_COST_PRICE}',
    '["RTM_DEV_FEE", "RTM_DEV_ENERGY", "RT_VAR_COST_PRICE"]',
    'RTM_DEV_FEE,RTM_DEV_ENERGY,RT_VAR_COST_PRICE',
    5
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (71, 111, 'SPOT_DEV_MARGIN', 1,
    '{TOTAL_MARGIN} - {CONTRACT_MARGIN}',
    '["TOTAL_MARGIN", "CONTRACT_MARGIN"]',
    'TOTAL_MARGIN,CONTRACT_MARGIN',
    5
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (72, 112, 'RTM_FULL_MARGIN', 1,
    '{RTM_FULL_FEE} - {RTM_VAR_COST}',
    '["RTM_FULL_FEE", "RTM_VAR_COST"]',
    'RTM_FULL_FEE,RTM_VAR_COST',
    5
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (73, 113, 'TOTAL_MARGIN', 1,
    '{TOTAL_FEE} - {RTM_VAR_COST}',
    '["TOTAL_FEE", "RTM_VAR_COST"]',
    'TOTAL_FEE,RTM_VAR_COST',
    5
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (74, 114, 'TOTAL_MARGIN_WITH_MKT', 1,
    '{TOTAL_FEE_WITH_MKT} - {RTM_VAR_COST}',
    '["TOTAL_FEE_WITH_MKT", "RTM_VAR_COST"]',
    'TOTAL_FEE_WITH_MKT,RTM_VAR_COST',
    5
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (75, 115, 'SPOT_FULL_MARGIN', 1,
    '{SPOT_FULL_FEE} - {RTM_VAR_COST}',
    '["SPOT_FULL_FEE", "RTM_VAR_COST"]',
    'SPOT_FULL_FEE,RTM_VAR_COST',
    5
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, condition_expr, true_value_expr, false_value)
VALUES (76, 116, 'SPOT_FULL_DEGREE_MARGIN', 2,
    'IF({ONLINE_ENERGY}<>0, {SPOT_FULL_MARGIN}/{ONLINE_ENERGY}, 0)',
    '["SPOT_FULL_MARGIN", "ONLINE_ENERGY"]',
    'SPOT_FULL_MARGIN,ONLINE_ENERGY',
    5, '{ONLINE_ENERGY}<>0', '{SPOT_FULL_MARGIN}/{ONLINE_ENERGY}', '0'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, condition_expr, true_value_expr, false_value)
VALUES (77, 117, 'RTM_FULL_DEGREE_MARGIN', 2,
    'IF({ONLINE_ENERGY}<>0, {RTM_FULL_MARGIN}/{ONLINE_ENERGY}, 0)',
    '["RTM_FULL_MARGIN", "ONLINE_ENERGY"]',
    'RTM_FULL_MARGIN,ONLINE_ENERGY',
    5, '{ONLINE_ENERGY}<>0', '{RTM_FULL_MARGIN}/{ONLINE_ENERGY}', '0'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, condition_expr, true_value_expr, false_value)
VALUES (78, 118, 'DAM_DEV_POS_MARGIN', 2,
    'IF({DAM_DEV_ENERGY}>=0, {DAM_DEV_MARGIN}, 0)',
    '["DAM_DEV_ENERGY", "DAM_DEV_MARGIN"]',
    'DAM_DEV_ENERGY,DAM_DEV_MARGIN',
    5, '{DAM_DEV_ENERGY}>=0', '{DAM_DEV_MARGIN}', '0'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, condition_expr, true_value_expr, false_value)
VALUES (79, 119, 'DAM_DEV_NEG_MARGIN', 2,
    'IF({DAM_DEV_ENERGY}<0, {DAM_DEV_MARGIN}, 0)',
    '["DAM_DEV_ENERGY", "DAM_DEV_MARGIN"]',
    'DAM_DEV_ENERGY,DAM_DEV_MARGIN',
    5, '{DAM_DEV_ENERGY}<0', '{DAM_DEV_MARGIN}', '0'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, condition_expr, true_value_expr, false_value)
VALUES (80, 120, 'RTM_DEV_POS_MARGIN', 2,
    'IF({RTM_DEV_ENERGY}>=0, {RTM_DEV_MARGIN}, 0)',
    '["RTM_DEV_ENERGY", "RTM_DEV_MARGIN"]',
    'RTM_DEV_ENERGY,RTM_DEV_MARGIN',
    5, '{RTM_DEV_ENERGY}>=0', '{RTM_DEV_MARGIN}', '0'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, condition_expr, true_value_expr, false_value)
VALUES (81, 121, 'RTM_DEV_NEG_MARGIN', 2,
    'IF({RTM_DEV_ENERGY}<0, {RTM_DEV_MARGIN}, 0)',
    '["RTM_DEV_ENERGY", "RTM_DEV_MARGIN"]',
    'RTM_DEV_ENERGY,RTM_DEV_MARGIN',
    5, '{RTM_DEV_ENERGY}<0', '{RTM_DEV_MARGIN}', '0'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, condition_expr, true_value_expr, false_value)
VALUES (82, 122, 'SPOT_DEV_POS_MARGIN', 2,
    'IF({SPOT_DEV_ENERGY}>=0, {SPOT_DEV_POS_FEE}-IF({SPOT_DEV_ENERGY}>=0,{SPOT_VAR_COST},0), 0)',
    '["SPOT_DEV_ENERGY", "SPOT_DEV_POS_FEE", "SPOT_VAR_COST"]',
    'SPOT_DEV_ENERGY,SPOT_DEV_POS_FEE,SPOT_VAR_COST',
    5, '{SPOT_DEV_ENERGY}>=0', '{SPOT_DEV_POS_FEE}-IF({SPOT_DEV_ENERGY}>=0,{SPOT_VAR_COST},0)', '0'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, condition_expr, true_value_expr, false_value)
VALUES (83, 123, 'SPOT_DEV_NEG_MARGIN', 2,
    'IF({SPOT_DEV_ENERGY}<0, {SPOT_DEV_NEG_FEE}-IF({SPOT_DEV_ENERGY}<0,{SPOT_VAR_COST},0), 0)',
    '["SPOT_DEV_ENERGY", "SPOT_DEV_NEG_FEE", "SPOT_VAR_COST"]',
    'SPOT_DEV_ENERGY,SPOT_DEV_NEG_FEE,SPOT_VAR_COST',
    5, '{SPOT_DEV_ENERGY}<0', '{SPOT_DEV_NEG_FEE}-IF({SPOT_DEV_ENERGY}<0,{SPOT_VAR_COST},0)', '0'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (84, 124, 'BASE_LOAD_RATE', 1,
    '{BASE_CLEARING_ENERGY} / ({RATED_CAPACITY} * (1-{AUX_RATE}/100) * 4) * 100',
    '["BASE_CLEARING_ENERGY", "RATED_CAPACITY", "AUX_RATE"]',
    'BASE_CLEARING_ENERGY,RATED_CAPACITY,AUX_RATE',
    6
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (85, 125, 'BASE_COVERAGE_RATE', 1,
    '{BASE_CLEARING_ENERGY} / {ONLINE_ENERGY} * 100',
    '["BASE_CLEARING_ENERGY", "ONLINE_ENERGY"]',
    'BASE_CLEARING_ENERGY,ONLINE_ENERGY',
    6
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (86, 126, 'MLT_LOAD_RATE', 1,
    '{MLT_CLEARING_ENERGY} / ({RATED_CAPACITY} * (1-{AUX_RATE}/100) * 4) * 100',
    '["MLT_CLEARING_ENERGY", "RATED_CAPACITY", "AUX_RATE"]',
    'MLT_CLEARING_ENERGY,RATED_CAPACITY,AUX_RATE',
    6
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (87, 127, 'MLT_COVERAGE_RATE', 1,
    '{MLT_CLEARING_ENERGY} / {ONLINE_ENERGY} * 100',
    '["MLT_CLEARING_ENERGY", "ONLINE_ENERGY"]',
    'MLT_CLEARING_ENERGY,ONLINE_ENERGY',
    6
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (88, 128, 'CONTRACT_LOAD_RATE', 1,
    '{MLT_CONTRACT_ENERGY} / ({RATED_CAPACITY} * (1-{AUX_RATE}/100) * 4) * 100',
    '["MLT_CONTRACT_ENERGY", "RATED_CAPACITY", "AUX_RATE"]',
    'MLT_CONTRACT_ENERGY,RATED_CAPACITY,AUX_RATE',
    6
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (89, 129, 'CONTRACT_COVERAGE_RATE', 1,
    '{MLT_CONTRACT_ENERGY} / {ONLINE_ENERGY} * 100',
    '["MLT_CONTRACT_ENERGY", "ONLINE_ENERGY"]',
    'MLT_CONTRACT_ENERGY,ONLINE_ENERGY',
    6
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (90, 130, 'DAM_LOAD_RATE', 1,
    '{DAM_CLEARING_OUTPUT} / {RATED_CAPACITY} * 100',
    '["DAM_CLEARING_OUTPUT", "RATED_CAPACITY"]',
    'DAM_CLEARING_OUTPUT,RATED_CAPACITY',
    6
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (91, 131, 'DAM_AVG_LOAD_RATE', 1,
    '{DAM_CLEARING_OUTPUT} / {RATED_CAPACITY} * 100',
    '["DAM_CLEARING_OUTPUT", "RATED_CAPACITY"]',
    'DAM_CLEARING_OUTPUT,RATED_CAPACITY',
    6
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (92, 132, 'RTM_LOAD_RATE', 1,
    '{RTM_CLEARING_OUTPUT} / {RATED_CAPACITY} * 100',
    '["RTM_CLEARING_OUTPUT", "RATED_CAPACITY"]',
    'RTM_CLEARING_OUTPUT,RATED_CAPACITY',
    6
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (93, 133, 'RTM_AVG_LOAD_RATE', 1,
    '{ACTUAL_OUTPUT} / {RATED_CAPACITY} * 100',
    '["ACTUAL_OUTPUT", "RATED_CAPACITY"]',
    'ACTUAL_OUTPUT,RATED_CAPACITY',
    6
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (94, 134, 'CAP_YEARLY_RECOVERY', 1,
    '实际回收电费/应收电费*100',
    '["CAPACITY_FEE"]',
    'CAPACITY_FEE',
    6
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (95, 135, 'REVENUE_COMPLETION_RATE', 1,
    '{TOTAL_FEE} / {PLAN_REVENUE} * 100',
    '["TOTAL_FEE", "PLAN_REVENUE"]',
    'TOTAL_FEE,PLAN_REVENUE',
    7
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (96, 136, 'ENERGY_COMPLETION_RATE', 1,
    '{ONLINE_ENERGY} / {PLAN_ENERGY} * 100',
    '["ONLINE_ENERGY", "PLAN_ENERGY"]',
    'ONLINE_ENERGY,PLAN_ENERGY',
    7
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (97, 137, 'UTILIZATION_HOURS', 1,
    '{ONLINE_ENERGY} / {INSTALLED_CAPACITY}',
    '["ONLINE_ENERGY", "INSTALLED_CAPACITY"]',
    'ONLINE_ENERGY,INSTALLED_CAPACITY',
    7
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (98, 138, 'PER_UNIT_REVENUE', 1,
    '{TOTAL_FEE} / {ONLINE_ENERGY}',
    '["TOTAL_FEE", "ONLINE_ENERGY"]',
    'TOTAL_FEE,ONLINE_ENERGY',
    7
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, yoy_mom_config)
VALUES (99, 139, 'ENERGY_YOY', 4,
    'YOY({ONLINE_ENERGY})',
    '["ONLINE_ENERGY"]',
    'ONLINE_ENERGY',
    8, '{"baseCode": "ONLINE_ENERGY", "compareType": "YOY", "offset": -365}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, yoy_mom_config)
VALUES (100, 140, 'FEE_YOY', 4,
    'YOY({TOTAL_FEE})',
    '["TOTAL_FEE"]',
    'TOTAL_FEE',
    8, '{"baseCode": "TOTAL_FEE", "compareType": "YOY", "offset": -365}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, yoy_mom_config)
VALUES (101, 141, 'UTIL_HOURS_YOY', 4,
    'YOY({UTILIZATION_HOURS})',
    '["UTILIZATION_HOURS"]',
    'UTILIZATION_HOURS',
    8, '{"baseCode": "UTILIZATION_HOURS", "compareType": "YOY", "offset": -365}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, yoy_mom_config)
VALUES (102, 142, 'REVENUE_YOY', 4,
    'YOY({TOTAL_MARGIN})',
    '["TOTAL_MARGIN"]',
    'TOTAL_MARGIN',
    8, '{"baseCode": "TOTAL_MARGIN", "compareType": "YOY", "offset": -365}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, yoy_mom_config)
VALUES (103, 143, 'UNIT_COST_YOY', 4,
    'YOY({RT_VAR_COST_PRICE})',
    '["RT_VAR_COST_PRICE"]',
    'RT_VAR_COST_PRICE',
    8, '{"baseCode": "RT_VAR_COST_PRICE", "compareType": "YOY", "offset": -365}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, yoy_mom_config)
VALUES (104, 144, 'UNIT_REVENUE_YOY', 4,
    'YOY({PER_UNIT_REVENUE})',
    '["PER_UNIT_REVENUE"]',
    'PER_UNIT_REVENUE',
    8, '{"baseCode": "PER_UNIT_REVENUE", "compareType": "YOY", "offset": -365}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, yoy_mom_config)
VALUES (105, 145, 'CERT_PRICE_YOY', 4,
    'YOY({GRN_CERT_TRADE_PRICE})',
    '["GRN_CERT_TRADE_PRICE"]',
    'GRN_CERT_TRADE_PRICE',
    8, '{"baseCode": "GRN_CERT_TRADE_PRICE", "compareType": "YOY", "offset": -365}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, yoy_mom_config)
VALUES (106, 146, 'CERT_VOL_YOY', 4,
    'YOY({GRN_CERT_TRADE_VOL})',
    '["GRN_CERT_TRADE_VOL"]',
    'GRN_CERT_TRADE_VOL',
    8, '{"baseCode": "GRN_CERT_TRADE_VOL", "compareType": "YOY", "offset": -365}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, yoy_mom_config)
VALUES (107, 147, 'ASSESS_YOY', 4,
    'YOY({AUX_ASSESS_FEE})',
    '["AUX_ASSESS_FEE"]',
    'AUX_ASSESS_FEE',
    8, '{"baseCode": "AUX_ASSESS_FEE", "compareType": "YOY", "offset": -365}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, yoy_mom_config)
VALUES (108, 148, 'COMPENSATE_YOY', 4,
    'YOY({AUX_COMPENSATE_FEE})',
    '["AUX_COMPENSATE_FEE"]',
    'AUX_COMPENSATE_FEE',
    8, '{"baseCode": "AUX_COMPENSATE_FEE", "compareType": "YOY", "offset": -365}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, yoy_mom_config)
VALUES (109, 149, 'SHARE_YOY', 4,
    'YOY({AUX_SHARE_FEE})',
    '["AUX_SHARE_FEE"]',
    'AUX_SHARE_FEE',
    8, '{"baseCode": "AUX_SHARE_FEE", "compareType": "YOY", "offset": -365}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, yoy_mom_config)
VALUES (110, 150, 'RETURN_YOY', 4,
    'YOY({AUX_RETURN_FEE})',
    '["AUX_RETURN_FEE"]',
    'AUX_RETURN_FEE',
    8, '{"baseCode": "AUX_RETURN_FEE", "compareType": "YOY", "offset": -365}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, yoy_mom_config)
VALUES (111, 151, 'ENERGY_MOM', 4,
    'MOM({ONLINE_ENERGY})',
    '["ONLINE_ENERGY"]',
    'ONLINE_ENERGY',
    8, '{"baseCode": "ONLINE_ENERGY", "compareType": "MOM", "offset": -1}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, yoy_mom_config)
VALUES (112, 152, 'FEE_MOM', 4,
    'MOM({TOTAL_FEE})',
    '["TOTAL_FEE"]',
    'TOTAL_FEE',
    8, '{"baseCode": "TOTAL_FEE", "compareType": "MOM", "offset": -1}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, yoy_mom_config)
VALUES (113, 153, 'UTIL_HOURS_MOM', 4,
    'MOM({UTILIZATION_HOURS})',
    '["UTILIZATION_HOURS"]',
    'UTILIZATION_HOURS',
    8, '{"baseCode": "UTILIZATION_HOURS", "compareType": "MOM", "offset": -1}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, yoy_mom_config)
VALUES (114, 154, 'REVENUE_MOM', 4,
    'MOM({TOTAL_MARGIN})',
    '["TOTAL_MARGIN"]',
    'TOTAL_MARGIN',
    8, '{"baseCode": "TOTAL_MARGIN", "compareType": "MOM", "offset": -1}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, yoy_mom_config)
VALUES (115, 155, 'UNIT_COST_MOM', 4,
    'MOM({RT_VAR_COST_PRICE})',
    '["RT_VAR_COST_PRICE"]',
    'RT_VAR_COST_PRICE',
    8, '{"baseCode": "RT_VAR_COST_PRICE", "compareType": "MOM", "offset": -1}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, yoy_mom_config)
VALUES (116, 156, 'UNIT_REVENUE_MOM', 4,
    'MOM({PER_UNIT_REVENUE})',
    '["PER_UNIT_REVENUE"]',
    'PER_UNIT_REVENUE',
    8, '{"baseCode": "PER_UNIT_REVENUE", "compareType": "MOM", "offset": -1}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, yoy_mom_config)
VALUES (117, 157, 'CERT_PRICE_MOM', 4,
    'MOM({GRN_CERT_TRADE_PRICE})',
    '["GRN_CERT_TRADE_PRICE"]',
    'GRN_CERT_TRADE_PRICE',
    8, '{"baseCode": "GRN_CERT_TRADE_PRICE", "compareType": "MOM", "offset": -1}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, yoy_mom_config)
VALUES (118, 158, 'CERT_VOL_MOM', 4,
    'MOM({GRN_CERT_TRADE_VOL})',
    '["GRN_CERT_TRADE_VOL"]',
    'GRN_CERT_TRADE_VOL',
    8, '{"baseCode": "GRN_CERT_TRADE_VOL", "compareType": "MOM", "offset": -1}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, yoy_mom_config)
VALUES (119, 159, 'ASSESS_MOM', 4,
    'MOM({AUX_ASSESS_FEE})',
    '["AUX_ASSESS_FEE"]',
    'AUX_ASSESS_FEE',
    8, '{"baseCode": "AUX_ASSESS_FEE", "compareType": "MOM", "offset": -1}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, yoy_mom_config)
VALUES (120, 160, 'COMPENSATE_MOM', 4,
    'MOM({AUX_COMPENSATE_FEE})',
    '["AUX_COMPENSATE_FEE"]',
    'AUX_COMPENSATE_FEE',
    8, '{"baseCode": "AUX_COMPENSATE_FEE", "compareType": "MOM", "offset": -1}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, yoy_mom_config)
VALUES (121, 161, 'SHARE_MOM', 4,
    'MOM({AUX_SHARE_FEE})',
    '["AUX_SHARE_FEE"]',
    'AUX_SHARE_FEE',
    8, '{"baseCode": "AUX_SHARE_FEE", "compareType": "MOM", "offset": -1}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, yoy_mom_config)
VALUES (122, 162, 'RETURN_MOM', 4,
    'MOM({AUX_RETURN_FEE})',
    '["AUX_RETURN_FEE"]',
    'AUX_RETURN_FEE',
    8, '{"baseCode": "AUX_RETURN_FEE", "compareType": "MOM", "offset": -1}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, rank_config)
VALUES (123, 163, 'REVENUE_TOP10', 5,
    'RANK({TOTAL_FEE}, 10, DESC)',
    '["TOTAL_FEE"]',
    'TOTAL_FEE',
    9, '{"topN": 10, "order": "DESC", "groupBy": "group_company,plant,unit"}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, rank_config)
VALUES (124, 164, 'UNIT_REVENUE_TOP10', 5,
    'RANK({PER_UNIT_REVENUE}, 10, DESC)',
    '["PER_UNIT_REVENUE"]',
    'PER_UNIT_REVENUE',
    9, '{"topN": 10, "order": "DESC", "groupBy": "group_company,plant,unit"}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, rank_config)
VALUES (125, 165, 'ENERGY_TOP10', 5,
    'RANK({ONLINE_ENERGY}, 10, DESC)',
    '["ONLINE_ENERGY"]',
    'ONLINE_ENERGY',
    9, '{"topN": 10, "order": "DESC", "groupBy": "group_company,plant,unit"}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, rank_config)
VALUES (126, 166, 'UTIL_HOURS_TOP10', 5,
    'RANK({UTILIZATION_HOURS}, 10, DESC)',
    '["UTILIZATION_HOURS"]',
    'UTILIZATION_HOURS',
    9, '{"topN": 10, "order": "DESC", "groupBy": "group_company,plant,unit"}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, rank_config)
VALUES (127, 167, 'UNIT_COST_TOP10', 5,
    'RANK({RT_VAR_COST_PRICE}, 10, ASC)',
    '["RT_VAR_COST_PRICE"]',
    'RT_VAR_COST_PRICE',
    9, '{"topN": 10, "order": "ASC", "groupBy": "group_company,plant,unit"}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (128, 168, 'GRP_GREEN_ENERGY', 1,
    'SUM(GRN_ENERGY)',
    NULL,
    '',
    7
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order)
VALUES (129, 170, 'GRP_CERT_COUNT', 1,
    'SUM({GRN_CERT_TRADE_VOL})',
    '["GRN_CERT_TRADE_VOL"]',
    'GRN_CERT_TRADE_VOL',
    7
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, agg_config)
VALUES (130, 172, 'GRP_MLT_ENERGY', 3,
    'AGG_SUM({MLT_CONTRACT_ENERGY})',
    '["MLT_CONTRACT_ENERGY"]',
    'MLT_CONTRACT_ENERGY',
    7, '{"func": "SUM", "groupFields": ["unit_id"], "timeGrain": "daily"}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, agg_config)
VALUES (131, 173, 'GRP_MLT_PRICE', 3,
    'AGG_AVG({MLT_CONTRACT_PRICE})',
    '["MLT_CONTRACT_PRICE"]',
    'MLT_CONTRACT_PRICE',
    7, '{"func": "AVG", "groupFields": ["unit_id"], "timeGrain": "daily"}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, agg_config)
VALUES (132, 174, 'GRP_MLT_FEE', 3,
    'AGG_SUM({MLT_CONTRACT_FEE})',
    '["MLT_CONTRACT_FEE"]',
    'MLT_CONTRACT_FEE',
    7, '{"func": "SUM", "groupFields": ["unit_id"], "timeGrain": "daily"}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, agg_config)
VALUES (133, 175, 'GRP_BASE_ENERGY', 3,
    'AGG_SUM({BASE_CLEARING_ENERGY})',
    '["BASE_CLEARING_ENERGY"]',
    'BASE_CLEARING_ENERGY',
    7, '{"func": "SUM", "groupFields": ["unit_id"], "timeGrain": "daily"}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, agg_config)
VALUES (134, 176, 'GRP_BASE_PRICE', 3,
    'AGG_AVG({BASE_CLEARING_PRICE})',
    '["BASE_CLEARING_PRICE"]',
    'BASE_CLEARING_PRICE',
    7, '{"func": "AVG", "groupFields": ["unit_id"], "timeGrain": "daily"}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, agg_config)
VALUES (135, 177, 'GRP_BASE_FEE', 3,
    'AGG_SUM({BASE_FEE})',
    '["BASE_FEE"]',
    'BASE_FEE',
    7, '{"func": "SUM", "groupFields": ["unit_id"], "timeGrain": "daily"}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, agg_config)
VALUES (136, 178, 'GRP_DAM_DEV_ENERGY', 3,
    'AGG_SUM({DAM_DEV_ENERGY})',
    '["DAM_DEV_ENERGY"]',
    'DAM_DEV_ENERGY',
    7, '{"func": "SUM", "groupFields": ["unit_id"], "timeGrain": "daily"}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, agg_config)
VALUES (137, 179, 'GRP_DAM_DEV_PRICE', 3,
    'AGG_AVG({DAM_DEV_PRICE})',
    '["DAM_DEV_PRICE"]',
    'DAM_DEV_PRICE',
    7, '{"func": "AVG", "groupFields": ["unit_id"], "timeGrain": "daily"}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, agg_config)
VALUES (138, 180, 'GRP_DAM_DEV_FEE', 3,
    'AGG_SUM({DAM_DEV_FEE})',
    '["DAM_DEV_FEE"]',
    'DAM_DEV_FEE',
    7, '{"func": "SUM", "groupFields": ["unit_id"], "timeGrain": "daily"}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, agg_config)
VALUES (139, 181, 'GRP_RTM_DEV_ENERGY', 3,
    'AGG_SUM({RTM_DEV_ENERGY})',
    '["RTM_DEV_ENERGY"]',
    'RTM_DEV_ENERGY',
    7, '{"func": "SUM", "groupFields": ["unit_id"], "timeGrain": "daily"}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, agg_config)
VALUES (140, 182, 'GRP_RTM_DEV_PRICE', 3,
    'AGG_AVG({RTM_DEV_PRICE})',
    '["RTM_DEV_PRICE"]',
    'RTM_DEV_PRICE',
    7, '{"func": "AVG", "groupFields": ["unit_id"], "timeGrain": "daily"}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, agg_config)
VALUES (141, 183, 'GRP_RTM_DEV_FEE', 3,
    'AGG_SUM({RTM_DEV_FEE})',
    '["RTM_DEV_FEE"]',
    'RTM_DEV_FEE',
    7, '{"func": "SUM", "groupFields": ["unit_id"], "timeGrain": "daily"}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, agg_config)
VALUES (142, 184, 'GRP_INT_ENERGY', 3,
    'AGG_SUM({INT_SPOT_ENERGY})',
    '["INT_SPOT_ENERGY"]',
    'INT_SPOT_ENERGY',
    7, '{"func": "SUM", "groupFields": ["unit_id"], "timeGrain": "daily"}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, agg_config)
VALUES (143, 185, 'GRP_INT_PRICE', 3,
    'AGG_AVG({INT_SPOT_AVG_PRICE})',
    '["INT_SPOT_AVG_PRICE"]',
    'INT_SPOT_AVG_PRICE',
    7, '{"func": "AVG", "groupFields": ["unit_id"], "timeGrain": "daily"}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, agg_config)
VALUES (144, 186, 'GRP_INT_FEE', 3,
    'AGG_SUM({INT_SPOT_FEE})',
    '["INT_SPOT_FEE"]',
    'INT_SPOT_FEE',
    7, '{"func": "SUM", "groupFields": ["unit_id"], "timeGrain": "daily"}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, agg_config)
VALUES (145, 187, 'GRP_PER_UNIT_REVENUE', 3,
    'AGG_SUM({TOTAL_FEE})/AGG_SUM({ONLINE_ENERGY})',
    '["TOTAL_FEE", "ONLINE_ENERGY"]',
    'TOTAL_FEE,ONLINE_ENERGY',
    7, '{"func": "SUM", "groupFields": ["unit_id"], "timeGrain": "daily"}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, agg_config)
VALUES (146, 188, 'GRP_UTIL_HOURS', 3,
    'AGG_SUM({ONLINE_ENERGY})/AGG_SUM({INSTALLED_CAPACITY})',
    '["ONLINE_ENERGY", "INSTALLED_CAPACITY"]',
    'ONLINE_ENERGY,INSTALLED_CAPACITY',
    7, '{"func": "SUM", "groupFields": ["unit_id"], "timeGrain": "daily"}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, agg_config)
VALUES (147, 189, 'GRP_ENERGY_COMPLETION', 3,
    'AGG_SUM({ONLINE_ENERGY})/{PLAN_ENERGY}*100',
    '["ONLINE_ENERGY", "PLAN_ENERGY"]',
    'ONLINE_ENERGY,PLAN_ENERGY',
    7, '{"func": "SUM", "groupFields": ["unit_id"], "timeGrain": "daily"}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, agg_config)
VALUES (148, 190, 'GRP_REVENUE_COMPLETION', 3,
    'AGG_SUM({TOTAL_FEE})/{PLAN_REVENUE}*100',
    '["TOTAL_FEE", "PLAN_REVENUE"]',
    'TOTAL_FEE,PLAN_REVENUE',
    7, '{"func": "SUM", "groupFields": ["unit_id"], "timeGrain": "daily"}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, agg_config)
VALUES (149, 191, 'GRP_ASSESS_FEE', 3,
    'AGG_SUM({AUX_ASSESS_FEE})',
    '["AUX_ASSESS_FEE"]',
    'AUX_ASSESS_FEE',
    7, '{"func": "SUM", "groupFields": ["unit_id"], "timeGrain": "daily"}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, agg_config)
VALUES (150, 192, 'GRP_RETURN_FEE', 3,
    'AGG_SUM({AUX_RETURN_FEE})',
    '["AUX_RETURN_FEE"]',
    'AUX_RETURN_FEE',
    7, '{"func": "SUM", "groupFields": ["unit_id"], "timeGrain": "daily"}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, agg_config)
VALUES (151, 193, 'GRP_SHARE_FEE', 3,
    'AGG_SUM({AUX_SHARE_FEE})',
    '["AUX_SHARE_FEE"]',
    'AUX_SHARE_FEE',
    7, '{"func": "SUM", "groupFields": ["unit_id"], "timeGrain": "daily"}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, agg_config)
VALUES (152, 194, 'GRP_COMPENSATE_FEE', 3,
    'AGG_SUM({AUX_COMPENSATE_FEE})',
    '["AUX_COMPENSATE_FEE"]',
    'AUX_COMPENSATE_FEE',
    7, '{"func": "SUM", "groupFields": ["unit_id"], "timeGrain": "daily"}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, agg_config)
VALUES (153, 195, 'GRP_INSTALLED_CAP', 3,
    'AGG_SUM({INSTALLED_CAPACITY})',
    '["INSTALLED_CAPACITY"]',
    'INSTALLED_CAPACITY',
    7, '{"func": "SUM", "groupFields": ["unit_id"], "timeGrain": "daily"}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, agg_config)
VALUES (154, 196, 'GRP_EFFECTIVE_CAP', 3,
    'AGG_SUM({EFFECTIVE_CAPACITY})',
    '["EFFECTIVE_CAPACITY"]',
    'EFFECTIVE_CAPACITY',
    7, '{"func": "SUM", "groupFields": ["unit_id"], "timeGrain": "daily"}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, agg_config)
VALUES (155, 197, 'GRP_CAPACITY_FEE', 3,
    'AGG_SUM({CAPACITY_FEE})',
    '["CAPACITY_FEE"]',
    'CAPACITY_FEE',
    7, '{"func": "SUM", "groupFields": ["unit_id"], "timeGrain": "daily"}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, agg_config)
VALUES (156, 198, 'GRP_CAPACITY_PRICE', 3,
    'AGG_AVG({CAPACITY_PRICE})',
    '["CAPACITY_PRICE"]',
    'CAPACITY_PRICE',
    7, '{"func": "AVG", "groupFields": ["unit_id"], "timeGrain": "daily"}'
);

INSERT INTO ind_calc_formula (id, indicator_id, indicator_code, formula_type, formula_expr, deps, dep_codes, calc_order, agg_config)
VALUES (157, 199, 'GRP_CAP_YEARLY_RECOVERY', 3,
    'AGG_SUM(实收)/AGG_SUM(应收)',
    '["CAPACITY_FEE"]',
    'CAPACITY_FEE',
    7, '{"func": "SUM", "groupFields": ["unit_id"], "timeGrain": "daily"}'
);

-- Total calc formulas: 157

-- ============================================================
-- SECTION 4: 数据源映射 ind_data_source
-- ============================================================

INSERT INTO ind_data_source (id, indicator_id, indicator_code, source_type, source_db, source_table, source_field, status, tenant_id, del_flag)
VALUES (1, 3, 'RATED_CAPACITY', 1, 'bdss_basic_parameter', 'bas_unit', 'ratedCapacity', 1, 1, 0);

INSERT INTO ind_data_source (id, indicator_id, indicator_code, source_type, source_db, source_table, source_field, status, tenant_id, del_flag)
VALUES (2, 4, 'MIN_TECH_OUTPUT', 1, 'bdss_basic_parameter', 'bas_unit', 'minOutput', 1, 1, 0);

INSERT INTO ind_data_source (id, indicator_id, indicator_code, source_type, source_db, source_table, source_field, status, tenant_id, del_flag)
VALUES (3, 5, 'AUX_RATE', 1, 'bdss_basic_parameter', 'bas_unit', 'auxRate', 1, 1, 0);

INSERT INTO ind_data_source (id, indicator_id, indicator_code, source_type, source_db, source_table, source_field, status, tenant_id, del_flag)
VALUES (4, 6, 'RT_VAR_COST_PRICE', 1, 'bdss_cost_manage', 'cost_unit_curve', '', 1, 1, 0);

INSERT INTO ind_data_source (id, indicator_id, indicator_code, source_type, source_db, source_table, source_field, status, tenant_id, del_flag)
VALUES (5, 7, 'BASE_CLEARING_ENERGY', 1, 'bdss_transaction_manage', 'trxn_contract_match_month', '', 1, 1, 0);

INSERT INTO ind_data_source (id, indicator_id, indicator_code, source_type, source_db, source_table, source_field, status, tenant_id, del_flag)
VALUES (6, 8, 'MLT_CLEARING_ENERGY', 1, 'bdss_transaction_manage', 'trxn_contract_match_month', '', 1, 1, 0);

INSERT INTO ind_data_source (id, indicator_id, indicator_code, source_type, source_db, source_table, source_field, status, tenant_id, del_flag)
VALUES (7, 9, 'DAM_CLEARING_ENERGY', 1, 'bdss_spot_market', 'spot_ahead_trade', 'power', 1, 1, 0);

INSERT INTO ind_data_source (id, indicator_id, indicator_code, source_type, source_db, source_table, source_field, status, tenant_id, del_flag)
VALUES (8, 10, 'RTM_CLEARING_ENERGY', 1, 'bdss_spot_market', 'spot_real_trade', 'power', 1, 1, 0);

INSERT INTO ind_data_source (id, indicator_id, indicator_code, source_type, source_db, source_table, source_field, status, tenant_id, del_flag)
VALUES (9, 11, 'ONLINE_ENERGY', 1, 'bdss_settlement_manage', 'sett_power_hour_unit', '', 1, 1, 0);

INSERT INTO ind_data_source (id, indicator_id, indicator_code, source_type, source_db, source_table, source_field, status, tenant_id, del_flag)
VALUES (10, 12, 'BASE_CLEARING_PRICE', 1, 'bdss_transaction_manage', 'trxn_contract_match_month', '', 1, 1, 0);

INSERT INTO ind_data_source (id, indicator_id, indicator_code, source_type, source_db, source_table, source_field, status, tenant_id, del_flag)
VALUES (11, 13, 'MLT_CLEARING_PRICE', 1, 'bdss_transaction_manage', 'trxn_contract_match_month', '', 1, 1, 0);

INSERT INTO ind_data_source (id, indicator_id, indicator_code, source_type, source_db, source_table, source_field, status, tenant_id, del_flag)
VALUES (12, 14, 'DAM_CLEARING_PRICE', 1, 'bdss_spot_market', 'spot_ahead_trade', 'price', 1, 1, 0);

INSERT INTO ind_data_source (id, indicator_id, indicator_code, source_type, source_db, source_table, source_field, status, tenant_id, del_flag)
VALUES (13, 15, 'RTM_CLEARING_PRICE', 1, 'bdss_spot_market', 'spot_real_trade', 'price', 1, 1, 0);

INSERT INTO ind_data_source (id, indicator_id, indicator_code, source_type, source_db, source_table, source_field, status, tenant_id, del_flag)
VALUES (14, 17, 'ACTUAL_OUTPUT', 1, 'bdss_group_data', 'ha_ssfdjh', '', 1, 1, 0);

INSERT INTO ind_data_source (id, indicator_id, indicator_code, source_type, source_db, source_table, source_field, status, tenant_id, del_flag)
VALUES (15, 18, 'BIDDING_SPACE', 1, 'bdss_market_analysis', 'mkt_netload', '', 1, 1, 0);

INSERT INTO ind_data_source (id, indicator_id, indicator_code, source_type, source_db, source_table, source_field, status, tenant_id, del_flag)
VALUES (16, 19, 'INSTALLED_CAPACITY', 1, 'bdss_basic_parameter', 'bas_unit', '', 1, 1, 0);

INSERT INTO ind_data_source (id, indicator_id, indicator_code, source_type, source_db, source_table, source_field, status, tenant_id, del_flag)
VALUES (17, 20, 'EFFECTIVE_CAPACITY', 1, 'bdss_basic_parameter', 'bas_unit', '', 1, 1, 0);

INSERT INTO ind_data_source (id, indicator_id, indicator_code, source_type, source_db, source_table, source_field, status, tenant_id, del_flag)
VALUES (18, 27, 'AUX_ASSESS_FEE', 1, 'bdss_settlement_manage', 'sett_base_subject', '', 1, 1, 0);

INSERT INTO ind_data_source (id, indicator_id, indicator_code, source_type, source_db, source_table, source_field, status, tenant_id, del_flag)
VALUES (19, 28, 'AUX_RETURN_FEE', 1, 'bdss_settlement_manage', 'sett_base_subject', '', 1, 1, 0);

INSERT INTO ind_data_source (id, indicator_id, indicator_code, source_type, source_db, source_table, source_field, status, tenant_id, del_flag)
VALUES (20, 29, 'AUX_SHARE_FEE', 1, 'bdss_settlement_manage', 'sett_base_subject', '', 1, 1, 0);

INSERT INTO ind_data_source (id, indicator_id, indicator_code, source_type, source_db, source_table, source_field, status, tenant_id, del_flag)
VALUES (21, 30, 'AUX_COMPENSATE_FEE', 1, 'bdss_settlement_manage', 'sett_base_subject', '', 1, 1, 0);

INSERT INTO ind_data_source (id, indicator_id, indicator_code, source_type, source_db, source_table, source_field, status, tenant_id, del_flag)
VALUES (22, 31, 'INT_DAM_BID_OUTPUT', 1, 'bdss_spot_market', 'spot_sjxh_inter_province_declare', '', 1, 1, 0);

INSERT INTO ind_data_source (id, indicator_id, indicator_code, source_type, source_db, source_table, source_field, status, tenant_id, del_flag)
VALUES (23, 32, 'INT_RTM_BID_OUTPUT', 1, 'bdss_spot_market', 'spot_sjxh_inter_province_declare', '', 1, 1, 0);

INSERT INTO ind_data_source (id, indicator_id, indicator_code, source_type, source_db, source_table, source_field, status, tenant_id, del_flag)
VALUES (24, 33, 'INT_DAM_PRICE', 1, 'bdss_spot_market', 'spot_sjxh_result_interprovincial_proveince', '', 1, 1, 0);

INSERT INTO ind_data_source (id, indicator_id, indicator_code, source_type, source_db, source_table, source_field, status, tenant_id, del_flag)
VALUES (25, 34, 'INT_RTM_PRICE', 1, 'bdss_spot_market', 'spot_sjxh_result_interprovincial_proveince', '', 1, 1, 0);

INSERT INTO ind_data_source (id, indicator_id, indicator_code, source_type, source_db, source_table, source_field, status, tenant_id, del_flag)
VALUES (26, 42, 'DAM_CLEARING_OUTPUT', 1, 'bdss_spot_market', 'spot_ahead_trade', '', 1, 1, 0);

INSERT INTO ind_data_source (id, indicator_id, indicator_code, source_type, source_db, source_table, source_field, status, tenant_id, del_flag)
VALUES (27, 43, 'RTM_CLEARING_OUTPUT', 1, 'bdss_spot_market', 'spot_real_trade', '', 1, 1, 0);

INSERT INTO ind_data_source (id, indicator_id, indicator_code, source_type, source_db, source_table, source_field, status, tenant_id, del_flag)
VALUES (28, 74, 'TOTAL_FEE_WITH_MKT', 1, 'bdss_settlement_manage', 'sett_unit_bill_day', '', 1, 1, 0);

-- Total data source mappings: 28

-- ============================================================
-- SECTION 5: 指标-维度关联 ind_indicator_dimension
-- ============================================================

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (1, 1, 'PLAN_REVENUE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (2, 1, 'PLAN_REVENUE', 71, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (3, 2, 'PLAN_ENERGY', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (4, 2, 'PLAN_ENERGY', 71, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (5, 3, 'RATED_CAPACITY', 1, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (6, 3, 'RATED_CAPACITY', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (7, 3, 'RATED_CAPACITY', 71, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (8, 4, 'MIN_TECH_OUTPUT', 1, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (9, 4, 'MIN_TECH_OUTPUT', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (10, 4, 'MIN_TECH_OUTPUT', 71, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (11, 5, 'AUX_RATE', 1, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (12, 5, 'AUX_RATE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (13, 5, 'AUX_RATE', 71, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (14, 6, 'RT_VAR_COST_PRICE', 20, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (15, 6, 'RT_VAR_COST_PRICE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (16, 6, 'RT_VAR_COST_PRICE', 71, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (17, 7, 'BASE_CLEARING_ENERGY', 2, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (18, 7, 'BASE_CLEARING_ENERGY', 55, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (19, 7, 'BASE_CLEARING_ENERGY', 71, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (20, 8, 'MLT_CLEARING_ENERGY', 2, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (21, 8, 'MLT_CLEARING_ENERGY', 55, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (22, 8, 'MLT_CLEARING_ENERGY', 71, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (23, 9, 'DAM_CLEARING_ENERGY', 1, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (24, 9, 'DAM_CLEARING_ENERGY', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (25, 9, 'DAM_CLEARING_ENERGY', 71, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (26, 10, 'RTM_CLEARING_ENERGY', 1, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (27, 10, 'RTM_CLEARING_ENERGY', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (28, 10, 'RTM_CLEARING_ENERGY', 71, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (29, 11, 'ONLINE_ENERGY', 1, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (30, 11, 'ONLINE_ENERGY', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (31, 11, 'ONLINE_ENERGY', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (32, 12, 'BASE_CLEARING_PRICE', 9, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (33, 12, 'BASE_CLEARING_PRICE', 56, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (34, 12, 'BASE_CLEARING_PRICE', 71, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (35, 13, 'MLT_CLEARING_PRICE', 9, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (36, 13, 'MLT_CLEARING_PRICE', 56, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (37, 13, 'MLT_CLEARING_PRICE', 71, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (38, 14, 'DAM_CLEARING_PRICE', 7, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (39, 14, 'DAM_CLEARING_PRICE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (40, 14, 'DAM_CLEARING_PRICE', 71, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (41, 15, 'RTM_CLEARING_PRICE', 7, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (42, 15, 'RTM_CLEARING_PRICE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (43, 15, 'RTM_CLEARING_PRICE', 71, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (44, 16, 'BENCHMARK_PRICE', 7, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (45, 16, 'BENCHMARK_PRICE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (46, 16, 'BENCHMARK_PRICE', 71, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (47, 17, 'ACTUAL_OUTPUT', 1, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (48, 17, 'ACTUAL_OUTPUT', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (49, 17, 'ACTUAL_OUTPUT', 71, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (50, 18, 'BIDDING_SPACE', 1, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (51, 18, 'BIDDING_SPACE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (52, 18, 'BIDDING_SPACE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (53, 19, 'INSTALLED_CAPACITY', 47, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (54, 19, 'INSTALLED_CAPACITY', 68, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (55, 19, 'INSTALLED_CAPACITY', 71, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (56, 20, 'EFFECTIVE_CAPACITY', 46, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (57, 20, 'EFFECTIVE_CAPACITY', 68, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (58, 20, 'EFFECTIVE_CAPACITY', 71, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (59, 21, 'CAPACITY_FEE', 46, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (60, 21, 'CAPACITY_FEE', 68, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (61, 21, 'CAPACITY_FEE', 71, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (62, 22, 'CAPACITY_PRICE', 46, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (63, 22, 'CAPACITY_PRICE', 68, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (64, 22, 'CAPACITY_PRICE', 71, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (65, 23, 'AUX_FREQ_CLEARING', 40, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (66, 23, 'AUX_FREQ_CLEARING', 67, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (67, 23, 'AUX_FREQ_CLEARING', 71, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (68, 24, 'AUX_FREQ_PRICE', 40, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (69, 24, 'AUX_FREQ_PRICE', 67, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (70, 24, 'AUX_FREQ_PRICE', 71, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (71, 25, 'AUX_RESERVE_CLEARING', 41, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (72, 25, 'AUX_RESERVE_CLEARING', 67, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (73, 25, 'AUX_RESERVE_CLEARING', 71, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (74, 26, 'AUX_RESERVE_PRICE', 41, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (75, 26, 'AUX_RESERVE_PRICE', 67, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (76, 26, 'AUX_RESERVE_PRICE', 71, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (77, 27, 'AUX_ASSESS_FEE', 42, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (78, 27, 'AUX_ASSESS_FEE', 67, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (79, 27, 'AUX_ASSESS_FEE', 71, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (80, 28, 'AUX_RETURN_FEE', 43, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (81, 28, 'AUX_RETURN_FEE', 67, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (82, 28, 'AUX_RETURN_FEE', 71, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (83, 29, 'AUX_SHARE_FEE', 44, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (84, 29, 'AUX_SHARE_FEE', 67, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (85, 29, 'AUX_SHARE_FEE', 71, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (86, 30, 'AUX_COMPENSATE_FEE', 45, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (87, 30, 'AUX_COMPENSATE_FEE', 67, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (88, 30, 'AUX_COMPENSATE_FEE', 71, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (89, 31, 'INT_DAM_BID_OUTPUT', 1, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (90, 31, 'INT_DAM_BID_OUTPUT', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (91, 31, 'INT_DAM_BID_OUTPUT', 71, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (92, 32, 'INT_RTM_BID_OUTPUT', 1, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (93, 32, 'INT_RTM_BID_OUTPUT', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (94, 32, 'INT_RTM_BID_OUTPUT', 71, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (95, 33, 'INT_DAM_PRICE', 7, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (96, 33, 'INT_DAM_PRICE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (97, 33, 'INT_DAM_PRICE', 71, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (98, 34, 'INT_RTM_PRICE', 7, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (99, 34, 'INT_RTM_PRICE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (100, 34, 'INT_RTM_PRICE', 71, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (101, 35, 'GRN_CERT_ISSUE', 52, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (102, 35, 'GRN_CERT_ISSUE', 69, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (103, 35, 'GRN_CERT_ISSUE', 71, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (104, 36, 'GRN_CERT_GRANT', 52, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (105, 36, 'GRN_CERT_GRANT', 69, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (106, 36, 'GRN_CERT_GRANT', 71, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (107, 37, 'GRN_CERT_TRADE_VOL', 52, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (108, 37, 'GRN_CERT_TRADE_VOL', 69, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (109, 37, 'GRN_CERT_TRADE_VOL', 71, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (110, 38, 'GRN_CERT_TRADE_PRICE', 52, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (111, 38, 'GRN_CERT_TRADE_PRICE', 69, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (112, 38, 'GRN_CERT_TRADE_PRICE', 71, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (113, 39, 'MLT_CONTRACT_ENERGY', 2, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (114, 39, 'MLT_CONTRACT_ENERGY', 55, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (115, 39, 'MLT_CONTRACT_ENERGY', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (116, 40, 'BASE_OUTPUT', 1, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (117, 40, 'BASE_OUTPUT', 54, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (118, 40, 'BASE_OUTPUT', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (119, 41, 'MLT_OUTPUT', 1, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (120, 41, 'MLT_OUTPUT', 54, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (121, 41, 'MLT_OUTPUT', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (122, 42, 'DAM_CLEARING_OUTPUT', 1, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (123, 42, 'DAM_CLEARING_OUTPUT', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (124, 42, 'DAM_CLEARING_OUTPUT', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (125, 43, 'RTM_CLEARING_OUTPUT', 1, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (126, 43, 'RTM_CLEARING_OUTPUT', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (127, 43, 'RTM_CLEARING_OUTPUT', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (128, 44, 'MLT_CONTRACT_PRICE', 9, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (129, 44, 'MLT_CONTRACT_PRICE', 56, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (130, 44, 'MLT_CONTRACT_PRICE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (131, 45, 'DAM_DEV_ENERGY', 1, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (132, 45, 'DAM_DEV_ENERGY', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (133, 45, 'DAM_DEV_ENERGY', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (134, 46, 'RTM_DEV_ENERGY', 1, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (135, 46, 'RTM_DEV_ENERGY', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (136, 46, 'RTM_DEV_ENERGY', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (137, 47, 'SPOT_DEV_ENERGY', 1, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (138, 47, 'SPOT_DEV_ENERGY', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (139, 47, 'SPOT_DEV_ENERGY', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (140, 48, 'DAM_DEV_POS_ENERGY', 1, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (141, 48, 'DAM_DEV_POS_ENERGY', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (142, 48, 'DAM_DEV_POS_ENERGY', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (143, 49, 'DAM_DEV_NEG_ENERGY', 1, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (144, 49, 'DAM_DEV_NEG_ENERGY', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (145, 49, 'DAM_DEV_NEG_ENERGY', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (146, 50, 'RTM_DEV_POS_ENERGY', 1, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (147, 50, 'RTM_DEV_POS_ENERGY', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (148, 50, 'RTM_DEV_POS_ENERGY', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (149, 51, 'RTM_DEV_NEG_ENERGY', 1, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (150, 51, 'RTM_DEV_NEG_ENERGY', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (151, 51, 'RTM_DEV_NEG_ENERGY', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (152, 52, 'SPOT_DEV_POS_ENERGY', 1, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (153, 52, 'SPOT_DEV_POS_ENERGY', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (154, 52, 'SPOT_DEV_POS_ENERGY', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (155, 53, 'SPOT_DEV_NEG_ENERGY', 1, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (156, 53, 'SPOT_DEV_NEG_ENERGY', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (157, 53, 'SPOT_DEV_NEG_ENERGY', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (158, 54, 'INT_DAM_ENERGY', 1, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (159, 54, 'INT_DAM_ENERGY', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (160, 54, 'INT_DAM_ENERGY', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (161, 55, 'INT_RTM_ENERGY', 1, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (162, 55, 'INT_RTM_ENERGY', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (163, 55, 'INT_RTM_ENERGY', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (164, 56, 'INT_SPOT_ENERGY', 1, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (165, 56, 'INT_SPOT_ENERGY', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (166, 56, 'INT_SPOT_ENERGY', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (167, 57, 'GRN_CERT_FEE', 52, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (168, 57, 'GRN_CERT_FEE', 69, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (169, 57, 'GRN_CERT_FEE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (170, 58, 'BASE_FEE', 13, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (171, 58, 'BASE_FEE', 54, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (172, 58, 'BASE_FEE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (173, 59, 'MLT_FEE', 13, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (174, 59, 'MLT_FEE', 54, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (175, 59, 'MLT_FEE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (176, 60, 'MLT_CONTRACT_FEE', 14, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (177, 60, 'MLT_CONTRACT_FEE', 57, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (178, 60, 'MLT_CONTRACT_FEE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (179, 61, 'DAM_FULL_FEE', 13, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (180, 61, 'DAM_FULL_FEE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (181, 61, 'DAM_FULL_FEE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (182, 62, 'RTM_FULL_FEE', 13, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (183, 62, 'RTM_FULL_FEE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (184, 62, 'RTM_FULL_FEE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (185, 63, 'DAM_DEV_FEE', 13, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (186, 63, 'DAM_DEV_FEE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (187, 63, 'DAM_DEV_FEE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (188, 64, 'RTM_DEV_FEE', 13, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (189, 64, 'RTM_DEV_FEE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (190, 64, 'RTM_DEV_FEE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (191, 65, 'SPOT_DEV_FEE', 13, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (192, 65, 'SPOT_DEV_FEE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (193, 65, 'SPOT_DEV_FEE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (194, 66, 'DAM_DEV_POS_FEE', 13, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (195, 66, 'DAM_DEV_POS_FEE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (196, 66, 'DAM_DEV_POS_FEE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (197, 67, 'DAM_DEV_NEG_FEE', 13, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (198, 67, 'DAM_DEV_NEG_FEE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (199, 67, 'DAM_DEV_NEG_FEE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (200, 68, 'RTM_DEV_POS_FEE', 13, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (201, 68, 'RTM_DEV_POS_FEE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (202, 68, 'RTM_DEV_POS_FEE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (203, 69, 'RTM_DEV_NEG_FEE', 13, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (204, 69, 'RTM_DEV_NEG_FEE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (205, 69, 'RTM_DEV_NEG_FEE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (206, 70, 'SPOT_DEV_POS_FEE', 13, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (207, 70, 'SPOT_DEV_POS_FEE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (208, 70, 'SPOT_DEV_POS_FEE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (209, 71, 'SPOT_DEV_NEG_FEE', 13, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (210, 71, 'SPOT_DEV_NEG_FEE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (211, 71, 'SPOT_DEV_NEG_FEE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (212, 72, 'SPOT_FULL_FEE', 13, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (213, 72, 'SPOT_FULL_FEE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (214, 72, 'SPOT_FULL_FEE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (215, 73, 'TOTAL_FEE', 13, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (216, 73, 'TOTAL_FEE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (217, 73, 'TOTAL_FEE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (218, 74, 'TOTAL_FEE_WITH_MKT', 13, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (219, 74, 'TOTAL_FEE_WITH_MKT', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (220, 74, 'TOTAL_FEE_WITH_MKT', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (221, 75, 'AVG_PRICE_WITH_MKT', 7, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (222, 75, 'AVG_PRICE_WITH_MKT', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (223, 75, 'AVG_PRICE_WITH_MKT', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (224, 76, 'DAM_DEV_PRICE', 7, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (225, 76, 'DAM_DEV_PRICE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (226, 76, 'DAM_DEV_PRICE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (227, 77, 'RTM_DEV_PRICE', 7, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (228, 77, 'RTM_DEV_PRICE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (229, 77, 'RTM_DEV_PRICE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (230, 78, 'SPOT_DEV_PRICE', 7, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (231, 78, 'SPOT_DEV_PRICE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (232, 78, 'SPOT_DEV_PRICE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (233, 79, 'DAM_DEV_POS_PRICE', 7, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (234, 79, 'DAM_DEV_POS_PRICE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (235, 79, 'DAM_DEV_POS_PRICE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (236, 80, 'DAM_DEV_NEG_PRICE', 7, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (237, 80, 'DAM_DEV_NEG_PRICE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (238, 80, 'DAM_DEV_NEG_PRICE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (239, 81, 'RTM_DEV_POS_PRICE', 7, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (240, 81, 'RTM_DEV_POS_PRICE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (241, 81, 'RTM_DEV_POS_PRICE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (242, 82, 'RTM_DEV_NEG_PRICE', 7, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (243, 82, 'RTM_DEV_NEG_PRICE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (244, 82, 'RTM_DEV_NEG_PRICE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (245, 83, 'SPOT_DEV_POS_PRICE', 7, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (246, 83, 'SPOT_DEV_POS_PRICE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (247, 83, 'SPOT_DEV_POS_PRICE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (248, 84, 'SPOT_DEV_NEG_PRICE', 7, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (249, 84, 'SPOT_DEV_NEG_PRICE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (250, 84, 'SPOT_DEV_NEG_PRICE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (251, 85, 'SPOT_AVG_PRICE', 7, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (252, 85, 'SPOT_AVG_PRICE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (253, 85, 'SPOT_AVG_PRICE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (254, 86, 'TOTAL_AVG_PRICE', 7, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (255, 86, 'TOTAL_AVG_PRICE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (256, 86, 'TOTAL_AVG_PRICE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (257, 87, 'INT_DAM_FEE', 13, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (258, 87, 'INT_DAM_FEE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (259, 87, 'INT_DAM_FEE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (260, 88, 'INT_RTM_FEE', 13, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (261, 88, 'INT_RTM_FEE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (262, 88, 'INT_RTM_FEE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (263, 89, 'INT_SPOT_FEE', 13, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (264, 89, 'INT_SPOT_FEE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (265, 89, 'INT_SPOT_FEE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (266, 90, 'INT_SPOT_AVG_PRICE', 7, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (267, 90, 'INT_SPOT_AVG_PRICE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (268, 90, 'INT_SPOT_AVG_PRICE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (269, 91, 'BASE_CFD_FEE', 13, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (270, 91, 'BASE_CFD_FEE', 54, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (271, 91, 'BASE_CFD_FEE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (272, 92, 'MLT_CFD_FEE', 13, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (273, 92, 'MLT_CFD_FEE', 54, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (274, 92, 'MLT_CFD_FEE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (275, 93, 'CONTRACT_CFD_FEE', 13, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (276, 93, 'CONTRACT_CFD_FEE', 54, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (277, 93, 'CONTRACT_CFD_FEE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (278, 94, 'DAM_CFD_FEE', 13, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (279, 94, 'DAM_CFD_FEE', 54, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (280, 94, 'DAM_CFD_FEE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (281, 95, 'BASE_DEGREE_DIFF_PRICE', 7, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (282, 95, 'BASE_DEGREE_DIFF_PRICE', 54, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (283, 95, 'BASE_DEGREE_DIFF_PRICE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (284, 96, 'CONTRACT_DEGREE_DIFF_PRICE', 7, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (285, 96, 'CONTRACT_DEGREE_DIFF_PRICE', 54, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (286, 96, 'CONTRACT_DEGREE_DIFF_PRICE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (287, 97, 'MLT_DEGREE_DIFF_PRICE', 7, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (288, 97, 'MLT_DEGREE_DIFF_PRICE', 54, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (289, 97, 'MLT_DEGREE_DIFF_PRICE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (290, 98, 'DAM_RTM_SPREAD', 7, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (291, 98, 'DAM_RTM_SPREAD', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (292, 98, 'DAM_RTM_SPREAD', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (293, 99, 'INT_DAM_INC_FEE', 13, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (294, 99, 'INT_DAM_INC_FEE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (295, 99, 'INT_DAM_INC_FEE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (296, 100, 'INT_RTM_INC_FEE', 13, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (297, 100, 'INT_RTM_INC_FEE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (298, 100, 'INT_RTM_INC_FEE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (299, 101, 'INT_SPOT_INC_FEE', 13, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (300, 101, 'INT_SPOT_INC_FEE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (301, 101, 'INT_SPOT_INC_FEE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (302, 102, 'MLT_EXT_INC_FEE', 13, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (303, 102, 'MLT_EXT_INC_FEE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (304, 102, 'MLT_EXT_INC_FEE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (305, 103, 'DAM_EXT_INC_FEE', 13, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (306, 103, 'DAM_EXT_INC_FEE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (307, 103, 'DAM_EXT_INC_FEE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (308, 104, 'RTM_EXT_INC_FEE', 13, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (309, 104, 'RTM_EXT_INC_FEE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (310, 104, 'RTM_EXT_INC_FEE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (311, 105, 'CONTRACT_VAR_COST', 20, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (312, 105, 'CONTRACT_VAR_COST', 54, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (313, 105, 'CONTRACT_VAR_COST', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (314, 106, 'RTM_VAR_COST', 20, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (315, 106, 'RTM_VAR_COST', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (316, 106, 'RTM_VAR_COST', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (317, 107, 'SPOT_VAR_COST', 20, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (318, 107, 'SPOT_VAR_COST', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (319, 107, 'SPOT_VAR_COST', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (320, 108, 'CONTRACT_MARGIN', 26, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (321, 108, 'CONTRACT_MARGIN', 54, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (322, 108, 'CONTRACT_MARGIN', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (323, 109, 'DAM_DEV_MARGIN', 25, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (324, 109, 'DAM_DEV_MARGIN', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (325, 109, 'DAM_DEV_MARGIN', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (326, 110, 'RTM_DEV_MARGIN', 25, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (327, 110, 'RTM_DEV_MARGIN', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (328, 110, 'RTM_DEV_MARGIN', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (329, 111, 'SPOT_DEV_MARGIN', 25, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (330, 111, 'SPOT_DEV_MARGIN', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (331, 111, 'SPOT_DEV_MARGIN', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (332, 112, 'RTM_FULL_MARGIN', 25, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (333, 112, 'RTM_FULL_MARGIN', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (334, 112, 'RTM_FULL_MARGIN', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (335, 113, 'TOTAL_MARGIN', 25, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (336, 113, 'TOTAL_MARGIN', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (337, 113, 'TOTAL_MARGIN', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (338, 114, 'TOTAL_MARGIN_WITH_MKT', 25, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (339, 114, 'TOTAL_MARGIN_WITH_MKT', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (340, 114, 'TOTAL_MARGIN_WITH_MKT', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (341, 115, 'SPOT_FULL_MARGIN', 25, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (342, 115, 'SPOT_FULL_MARGIN', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (343, 115, 'SPOT_FULL_MARGIN', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (344, 116, 'SPOT_FULL_DEGREE_MARGIN', 29, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (345, 116, 'SPOT_FULL_DEGREE_MARGIN', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (346, 116, 'SPOT_FULL_DEGREE_MARGIN', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (347, 117, 'RTM_FULL_DEGREE_MARGIN', 29, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (348, 117, 'RTM_FULL_DEGREE_MARGIN', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (349, 117, 'RTM_FULL_DEGREE_MARGIN', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (350, 118, 'DAM_DEV_POS_MARGIN', 25, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (351, 118, 'DAM_DEV_POS_MARGIN', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (352, 118, 'DAM_DEV_POS_MARGIN', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (353, 119, 'DAM_DEV_NEG_MARGIN', 25, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (354, 119, 'DAM_DEV_NEG_MARGIN', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (355, 119, 'DAM_DEV_NEG_MARGIN', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (356, 120, 'RTM_DEV_POS_MARGIN', 25, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (357, 120, 'RTM_DEV_POS_MARGIN', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (358, 120, 'RTM_DEV_POS_MARGIN', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (359, 121, 'RTM_DEV_NEG_MARGIN', 25, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (360, 121, 'RTM_DEV_NEG_MARGIN', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (361, 121, 'RTM_DEV_NEG_MARGIN', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (362, 122, 'SPOT_DEV_POS_MARGIN', 25, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (363, 122, 'SPOT_DEV_POS_MARGIN', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (364, 122, 'SPOT_DEV_POS_MARGIN', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (365, 123, 'SPOT_DEV_NEG_MARGIN', 25, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (366, 123, 'SPOT_DEV_NEG_MARGIN', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (367, 123, 'SPOT_DEV_NEG_MARGIN', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (368, 124, 'BASE_LOAD_RATE', 23, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (369, 124, 'BASE_LOAD_RATE', 54, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (370, 124, 'BASE_LOAD_RATE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (371, 125, 'BASE_COVERAGE_RATE', 24, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (372, 125, 'BASE_COVERAGE_RATE', 54, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (373, 125, 'BASE_COVERAGE_RATE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (374, 126, 'MLT_LOAD_RATE', 23, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (375, 126, 'MLT_LOAD_RATE', 54, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (376, 126, 'MLT_LOAD_RATE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (377, 127, 'MLT_COVERAGE_RATE', 24, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (378, 127, 'MLT_COVERAGE_RATE', 54, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (379, 127, 'MLT_COVERAGE_RATE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (380, 128, 'CONTRACT_LOAD_RATE', 23, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (381, 128, 'CONTRACT_LOAD_RATE', 54, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (382, 128, 'CONTRACT_LOAD_RATE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (383, 129, 'CONTRACT_COVERAGE_RATE', 24, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (384, 129, 'CONTRACT_COVERAGE_RATE', 54, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (385, 129, 'CONTRACT_COVERAGE_RATE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (386, 130, 'DAM_LOAD_RATE', 23, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (387, 130, 'DAM_LOAD_RATE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (388, 130, 'DAM_LOAD_RATE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (389, 131, 'DAM_AVG_LOAD_RATE', 23, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (390, 131, 'DAM_AVG_LOAD_RATE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (391, 131, 'DAM_AVG_LOAD_RATE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (392, 132, 'RTM_LOAD_RATE', 23, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (393, 132, 'RTM_LOAD_RATE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (394, 132, 'RTM_LOAD_RATE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (395, 133, 'RTM_AVG_LOAD_RATE', 23, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (396, 133, 'RTM_AVG_LOAD_RATE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (397, 133, 'RTM_AVG_LOAD_RATE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (398, 134, 'CAP_YEARLY_RECOVERY', 46, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (399, 134, 'CAP_YEARLY_RECOVERY', 68, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (400, 134, 'CAP_YEARLY_RECOVERY', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (401, 135, 'REVENUE_COMPLETION_RATE', 31, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (402, 135, 'REVENUE_COMPLETION_RATE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (403, 135, 'REVENUE_COMPLETION_RATE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (404, 136, 'ENERGY_COMPLETION_RATE', 31, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (405, 136, 'ENERGY_COMPLETION_RATE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (406, 136, 'ENERGY_COMPLETION_RATE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (407, 137, 'UTILIZATION_HOURS', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (408, 137, 'UTILIZATION_HOURS', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (409, 138, 'PER_UNIT_REVENUE', 33, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (410, 138, 'PER_UNIT_REVENUE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (411, 138, 'PER_UNIT_REVENUE', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (412, 139, 'ENERGY_YOY', 1, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (413, 139, 'ENERGY_YOY', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (414, 139, 'ENERGY_YOY', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (415, 140, 'FEE_YOY', 13, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (416, 140, 'FEE_YOY', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (417, 140, 'FEE_YOY', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (418, 141, 'UTIL_HOURS_YOY', 35, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (419, 141, 'UTIL_HOURS_YOY', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (420, 141, 'UTIL_HOURS_YOY', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (421, 142, 'REVENUE_YOY', 35, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (422, 142, 'REVENUE_YOY', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (423, 142, 'REVENUE_YOY', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (424, 143, 'UNIT_COST_YOY', 21, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (425, 143, 'UNIT_COST_YOY', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (426, 143, 'UNIT_COST_YOY', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (427, 144, 'UNIT_REVENUE_YOY', 33, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (428, 144, 'UNIT_REVENUE_YOY', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (429, 144, 'UNIT_REVENUE_YOY', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (430, 145, 'CERT_PRICE_YOY', 52, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (431, 145, 'CERT_PRICE_YOY', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (432, 145, 'CERT_PRICE_YOY', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (433, 146, 'CERT_VOL_YOY', 52, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (434, 146, 'CERT_VOL_YOY', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (435, 146, 'CERT_VOL_YOY', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (436, 147, 'ASSESS_YOY', 42, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (437, 147, 'ASSESS_YOY', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (438, 147, 'ASSESS_YOY', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (439, 148, 'COMPENSATE_YOY', 45, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (440, 148, 'COMPENSATE_YOY', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (441, 148, 'COMPENSATE_YOY', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (442, 149, 'SHARE_YOY', 44, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (443, 149, 'SHARE_YOY', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (444, 149, 'SHARE_YOY', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (445, 150, 'RETURN_YOY', 43, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (446, 150, 'RETURN_YOY', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (447, 150, 'RETURN_YOY', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (448, 151, 'ENERGY_MOM', 1, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (449, 151, 'ENERGY_MOM', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (450, 151, 'ENERGY_MOM', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (451, 152, 'FEE_MOM', 13, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (452, 152, 'FEE_MOM', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (453, 152, 'FEE_MOM', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (454, 153, 'UTIL_HOURS_MOM', 36, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (455, 153, 'UTIL_HOURS_MOM', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (456, 153, 'UTIL_HOURS_MOM', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (457, 154, 'REVENUE_MOM', 36, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (458, 154, 'REVENUE_MOM', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (459, 154, 'REVENUE_MOM', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (460, 155, 'UNIT_COST_MOM', 21, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (461, 155, 'UNIT_COST_MOM', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (462, 155, 'UNIT_COST_MOM', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (463, 156, 'UNIT_REVENUE_MOM', 33, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (464, 156, 'UNIT_REVENUE_MOM', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (465, 156, 'UNIT_REVENUE_MOM', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (466, 157, 'CERT_PRICE_MOM', 52, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (467, 157, 'CERT_PRICE_MOM', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (468, 157, 'CERT_PRICE_MOM', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (469, 158, 'CERT_VOL_MOM', 52, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (470, 158, 'CERT_VOL_MOM', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (471, 158, 'CERT_VOL_MOM', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (472, 159, 'ASSESS_MOM', 42, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (473, 159, 'ASSESS_MOM', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (474, 159, 'ASSESS_MOM', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (475, 160, 'COMPENSATE_MOM', 45, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (476, 160, 'COMPENSATE_MOM', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (477, 160, 'COMPENSATE_MOM', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (478, 161, 'SHARE_MOM', 44, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (479, 161, 'SHARE_MOM', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (480, 161, 'SHARE_MOM', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (481, 162, 'RETURN_MOM', 43, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (482, 162, 'RETURN_MOM', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (483, 162, 'RETURN_MOM', 72, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (484, 163, 'REVENUE_TOP10', 37, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (485, 163, 'REVENUE_TOP10', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (486, 163, 'REVENUE_TOP10', 74, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (487, 164, 'UNIT_REVENUE_TOP10', 33, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (488, 164, 'UNIT_REVENUE_TOP10', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (489, 164, 'UNIT_REVENUE_TOP10', 74, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (490, 165, 'ENERGY_TOP10', 37, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (491, 165, 'ENERGY_TOP10', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (492, 165, 'ENERGY_TOP10', 74, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (493, 166, 'UTIL_HOURS_TOP10', 37, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (494, 166, 'UTIL_HOURS_TOP10', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (495, 166, 'UTIL_HOURS_TOP10', 74, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (496, 167, 'UNIT_COST_TOP10', 21, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (497, 167, 'UNIT_COST_TOP10', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (498, 167, 'UNIT_COST_TOP10', 74, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (499, 168, 'GRP_GREEN_ENERGY', 1, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (500, 168, 'GRP_GREEN_ENERGY', 69, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (501, 168, 'GRP_GREEN_ENERGY', 77, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (502, 169, 'GRP_GREEN_PRICE', 7, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (503, 169, 'GRP_GREEN_PRICE', 69, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (504, 169, 'GRP_GREEN_PRICE', 77, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (505, 170, 'GRP_CERT_COUNT', 52, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (506, 170, 'GRP_CERT_COUNT', 69, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (507, 170, 'GRP_CERT_COUNT', 77, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (508, 171, 'GRP_CERT_PRICE', 52, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (509, 171, 'GRP_CERT_PRICE', 69, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (510, 171, 'GRP_CERT_PRICE', 77, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (511, 172, 'GRP_MLT_ENERGY', 1, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (512, 172, 'GRP_MLT_ENERGY', 69, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (513, 172, 'GRP_MLT_ENERGY', 77, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (514, 173, 'GRP_MLT_PRICE', 7, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (515, 173, 'GRP_MLT_PRICE', 69, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (516, 173, 'GRP_MLT_PRICE', 77, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (517, 174, 'GRP_MLT_FEE', 13, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (518, 174, 'GRP_MLT_FEE', 69, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (519, 174, 'GRP_MLT_FEE', 77, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (520, 175, 'GRP_BASE_ENERGY', 1, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (521, 175, 'GRP_BASE_ENERGY', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (522, 175, 'GRP_BASE_ENERGY', 74, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (523, 176, 'GRP_BASE_PRICE', 7, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (524, 176, 'GRP_BASE_PRICE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (525, 176, 'GRP_BASE_PRICE', 74, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (526, 177, 'GRP_BASE_FEE', 13, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (527, 177, 'GRP_BASE_FEE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (528, 177, 'GRP_BASE_FEE', 74, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (529, 178, 'GRP_DAM_DEV_ENERGY', 1, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (530, 178, 'GRP_DAM_DEV_ENERGY', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (531, 178, 'GRP_DAM_DEV_ENERGY', 74, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (532, 179, 'GRP_DAM_DEV_PRICE', 7, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (533, 179, 'GRP_DAM_DEV_PRICE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (534, 179, 'GRP_DAM_DEV_PRICE', 74, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (535, 180, 'GRP_DAM_DEV_FEE', 13, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (536, 180, 'GRP_DAM_DEV_FEE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (537, 180, 'GRP_DAM_DEV_FEE', 74, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (538, 181, 'GRP_RTM_DEV_ENERGY', 1, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (539, 181, 'GRP_RTM_DEV_ENERGY', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (540, 181, 'GRP_RTM_DEV_ENERGY', 74, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (541, 182, 'GRP_RTM_DEV_PRICE', 7, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (542, 182, 'GRP_RTM_DEV_PRICE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (543, 182, 'GRP_RTM_DEV_PRICE', 74, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (544, 183, 'GRP_RTM_DEV_FEE', 13, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (545, 183, 'GRP_RTM_DEV_FEE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (546, 183, 'GRP_RTM_DEV_FEE', 74, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (547, 184, 'GRP_INT_ENERGY', 1, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (548, 184, 'GRP_INT_ENERGY', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (549, 184, 'GRP_INT_ENERGY', 74, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (550, 185, 'GRP_INT_PRICE', 7, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (551, 185, 'GRP_INT_PRICE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (552, 185, 'GRP_INT_PRICE', 74, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (553, 186, 'GRP_INT_FEE', 13, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (554, 186, 'GRP_INT_FEE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (555, 186, 'GRP_INT_FEE', 74, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (556, 187, 'GRP_PER_UNIT_REVENUE', 33, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (557, 187, 'GRP_PER_UNIT_REVENUE', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (558, 187, 'GRP_PER_UNIT_REVENUE', 74, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (559, 188, 'GRP_UTIL_HOURS', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (560, 188, 'GRP_UTIL_HOURS', 74, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (561, 189, 'GRP_ENERGY_COMPLETION', 31, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (562, 189, 'GRP_ENERGY_COMPLETION', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (563, 189, 'GRP_ENERGY_COMPLETION', 74, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (564, 190, 'GRP_REVENUE_COMPLETION', 31, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (565, 190, 'GRP_REVENUE_COMPLETION', 60, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (566, 190, 'GRP_REVENUE_COMPLETION', 74, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (567, 191, 'GRP_ASSESS_FEE', 42, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (568, 191, 'GRP_ASSESS_FEE', 67, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (569, 191, 'GRP_ASSESS_FEE', 75, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (570, 192, 'GRP_RETURN_FEE', 43, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (571, 192, 'GRP_RETURN_FEE', 67, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (572, 192, 'GRP_RETURN_FEE', 75, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (573, 193, 'GRP_SHARE_FEE', 44, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (574, 193, 'GRP_SHARE_FEE', 67, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (575, 193, 'GRP_SHARE_FEE', 75, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (576, 194, 'GRP_COMPENSATE_FEE', 45, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (577, 194, 'GRP_COMPENSATE_FEE', 67, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (578, 194, 'GRP_COMPENSATE_FEE', 75, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (579, 195, 'GRP_INSTALLED_CAP', 47, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (580, 195, 'GRP_INSTALLED_CAP', 68, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (581, 195, 'GRP_INSTALLED_CAP', 76, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (582, 196, 'GRP_EFFECTIVE_CAP', 46, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (583, 196, 'GRP_EFFECTIVE_CAP', 68, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (584, 196, 'GRP_EFFECTIVE_CAP', 76, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (585, 197, 'GRP_CAPACITY_FEE', 46, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (586, 197, 'GRP_CAPACITY_FEE', 68, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (587, 197, 'GRP_CAPACITY_FEE', 76, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (588, 198, 'GRP_CAPACITY_PRICE', 46, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (589, 198, 'GRP_CAPACITY_PRICE', 68, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (590, 198, 'GRP_CAPACITY_PRICE', 76, 'SUBJECT', 3, 1);

INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (591, 199, 'GRP_CAP_YEARLY_RECOVERY', 46, 'BUSINESS', 1, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (592, 199, 'GRP_CAP_YEARLY_RECOVERY', 68, 'MARKET', 2, 1);
INSERT INTO ind_indicator_dimension (id, indicator_id, indicator_code, dimension_id, dim_type, sort_order, tenant_id)
VALUES (593, 199, 'GRP_CAP_YEARLY_RECOVERY', 76, 'SUBJECT', 3, 1);

-- Total dimension associations: 593
