import type {
  IndicatorDef,
  TreeNode,
  KpiData,
  TimeseriesPoint,
  DailyData,
  CompareData,
  CalcTaskLog,
  CalcDetailLog,
} from '@/types/indicator'

// ─── 指标定义（完整 Mock） ─────────────────────────
export const MOCK_INDICATORS: IndicatorDef[] = [
  { id: 1, indicatorCode: 'DAM_CLEARING_PRICE', indicatorName: '日前出清电价', indicatorType: 1, marketType: 'SPOT', subjectType: 'UNIT', categoryL1: '电价', categoryL2: '出清', unit: '元/MWh', timeGrain: 'timeseries', calcLayer: 0, status: 1, tenantId: 1 },
  { id: 2, indicatorCode: 'RTM_CLEARING_PRICE', indicatorName: '实时出清电价', indicatorType: 1, marketType: 'SPOT', subjectType: 'UNIT', categoryL1: '电价', categoryL2: '出清', unit: '元/MWh', timeGrain: 'timeseries', calcLayer: 0, status: 1, tenantId: 1 },
  { id: 3, indicatorCode: 'DAM_CLEARING_ENERGY', indicatorName: '日前出清电量', indicatorType: 1, marketType: 'SPOT', subjectType: 'UNIT', categoryL1: '电量', categoryL2: '出清', unit: 'MWh', timeGrain: 'timeseries', calcLayer: 0, status: 1, tenantId: 1 },
  { id: 4, indicatorCode: 'RTM_CLEARING_ENERGY', indicatorName: '实时出清电量', indicatorType: 1, marketType: 'SPOT', subjectType: 'UNIT', categoryL1: '电量', categoryL2: '出清', unit: 'MWh', timeGrain: 'timeseries', calcLayer: 0, status: 1, tenantId: 1 },
  { id: 5, indicatorCode: 'DAM_DEV_ENERGY', indicatorName: '日前偏差电量', indicatorType: 2, marketType: 'SPOT', subjectType: 'UNIT', categoryL1: '电量', categoryL2: '偏差', unit: 'MWh', timeGrain: 'timeseries', calcLayer: 2, status: 1, tenantId: 1 },
  { id: 6, indicatorCode: 'DAM_DEV_POS_ENERGY', indicatorName: '日前正偏差电量', indicatorType: 3, marketType: 'SPOT', subjectType: 'UNIT', categoryL1: '电量', categoryL2: '偏差', unit: 'MWh', timeGrain: 'timeseries', calcLayer: 2, status: 1, tenantId: 1 },
  { id: 7, indicatorCode: 'DAM_DEV_NEG_ENERGY', indicatorName: '日前负偏差电量', indicatorType: 3, marketType: 'SPOT', subjectType: 'UNIT', categoryL1: '电量', categoryL2: '偏差', unit: 'MWh', timeGrain: 'timeseries', calcLayer: 2, status: 1, tenantId: 1 },
  { id: 8, indicatorCode: 'RTM_DEV_ENERGY', indicatorName: '实时偏差电量', indicatorType: 2, marketType: 'SPOT', subjectType: 'UNIT', categoryL1: '电量', categoryL2: '偏差', unit: 'MWh', timeGrain: 'timeseries', calcLayer: 2, status: 1, tenantId: 1 },
  { id: 9, indicatorCode: 'MLT_CONTRACT_ENERGY', indicatorName: '中长期合约电量', indicatorType: 1, marketType: 'MLT', subjectType: 'UNIT', categoryL1: '电量', categoryL2: '合约', unit: 'MWh', timeGrain: 'daily', calcLayer: 0, status: 1, tenantId: 1 },
  { id: 10, indicatorCode: 'MLT_CONTRACT_PRICE', indicatorName: '中长期合约电价', indicatorType: 1, marketType: 'MLT', subjectType: 'UNIT', categoryL1: '电价', categoryL2: '合约', unit: '元/MWh', timeGrain: 'daily', calcLayer: 0, status: 1, tenantId: 1 },
  { id: 11, indicatorCode: 'ONLINE_ENERGY', indicatorName: '上网电量', indicatorType: 1, marketType: 'ALL', subjectType: 'UNIT', categoryL1: '电量', categoryL2: '结算', unit: 'MWh', timeGrain: 'timeseries', calcLayer: 0, status: 1, tenantId: 1 },
  { id: 12, indicatorCode: 'SPOT_FULL_FEE', indicatorName: '现货电费', indicatorType: 2, marketType: 'SPOT', subjectType: 'UNIT', categoryL1: '电费', categoryL2: '现货', unit: '元', timeGrain: 'daily', calcLayer: 1, status: 1, tenantId: 1 },
  { id: 13, indicatorCode: 'TOTAL_AVG_PRICE', indicatorName: '度电价格', indicatorType: 3, marketType: 'ALL', subjectType: 'UNIT', categoryL1: '电价', categoryL2: '综合', unit: '元/MWh', timeGrain: 'daily', calcLayer: 3, status: 0, tenantId: 1 },
  { id: 14, indicatorCode: 'TOTAL_MARGIN', indicatorName: '总边际贡献', indicatorType: 3, marketType: 'ALL', subjectType: 'UNIT', categoryL1: '边际', categoryL2: '综合', unit: '元', timeGrain: 'daily', calcLayer: 3, status: 0, tenantId: 1 },
  { id: 15, indicatorCode: 'CONTRACT_COVERAGE', indicatorName: '合约覆盖率', indicatorType: 3, marketType: 'MLT', subjectType: 'UNIT', categoryL1: '比率', categoryL2: '合约', unit: '%', timeGrain: 'daily', calcLayer: 2, status: 1, tenantId: 1 },
  { id: 16, indicatorCode: 'LOAD_RATE', indicatorName: '负荷率', indicatorType: 3, marketType: 'ALL', subjectType: 'UNIT', categoryL1: '比率', categoryL2: '运行', unit: '%', timeGrain: 'timeseries', calcLayer: 2, status: 1, tenantId: 1 },
  { id: 17, indicatorCode: 'PER_UNIT_REVENUE', indicatorName: '度电收益', indicatorType: 3, marketType: 'ALL', subjectType: 'UNIT', categoryL1: '电费', categoryL2: '综合', unit: '元/MWh', timeGrain: 'daily', calcLayer: 3, status: 0, tenantId: 1 },
  { id: 18, indicatorCode: 'RT_VAR_COST_PRICE', indicatorName: '实时变动成本', indicatorType: 1, marketType: 'SPOT', subjectType: 'UNIT', categoryL1: '成本', categoryL2: '变动', unit: '元/MWh', timeGrain: 'timeseries', calcLayer: 0, status: 1, tenantId: 1 },
  { id: 19, indicatorCode: 'RATED_CAPACITY', indicatorName: '额定容量', indicatorType: 1, marketType: 'ALL', subjectType: 'UNIT', categoryL1: '参数', categoryL2: '机组', unit: 'MW', timeGrain: 'daily', calcLayer: 0, status: 1, tenantId: 1 },
  { id: 20, indicatorCode: 'BASE_CLEARING_ENERGY', indicatorName: '基数出清电量', indicatorType: 1, marketType: 'MLT', subjectType: 'UNIT', categoryL1: '电量', categoryL2: '合约', unit: 'MWh', timeGrain: 'daily', calcLayer: 0, status: 1, tenantId: 1 },
]

// ─── 指标选项（用于下拉选择器） ─────────────────────
export const MOCK_INDICATOR_OPTIONS = MOCK_INDICATORS.map((i) => ({
  code: i.indicatorCode,
  name: i.indicatorName,
  unit: i.unit,
}))

// ─── 计算类指标（公式编辑器可选） ─────────────────────
export const MOCK_CALC_INDICATORS = MOCK_INDICATORS
  .filter((i) => i.indicatorType === 2 || i.indicatorType === 3)
  .map((i) => ({ code: i.indicatorCode, name: i.indicatorName }))

// ─── 原始类指标（公式编辑器依赖） ─────────────────────
export const MOCK_RAW_INDICATORS = MOCK_INDICATORS
  .filter((i) => i.indicatorType === 1)
  .map((i) => ({ code: i.indicatorCode, name: i.indicatorName, layer: i.calcLayer }))

// ─── KPI 数据 ────────────────────────────────────────
export const MOCK_KPI: KpiData[] = [
  { code: 'MLT_CONTRACT_ENERGY', label: '中长期电量', value: 1234.5, unit: 'MWh', changeRate: 5.2, changeType: 'yoy', changeDirection: 'up' },
  { code: 'ONLINE_ENERGY', label: '上网电量', value: 987.6, unit: 'MWh', changeRate: -1.3, changeType: 'mom', changeDirection: 'down' },
  { code: 'SPOT_FULL_FEE', label: '现货电费', value: 256780, unit: '元', changeRate: 8.7, changeType: 'yoy', changeDirection: 'up' },
  { code: 'TOTAL_AVG_PRICE', label: '度电价格', value: 312.5, unit: '元/MWh', changeRate: 3.1, changeType: 'yoy', changeDirection: 'up' },
  { code: 'TOTAL_MARGIN', label: '总边际贡献', value: 89450, unit: '元', changeRate: 12.3, changeType: 'yoy', changeDirection: 'up' },
]

// ─── 维度树 ──────────────────────────────────────────
export const MOCK_DIMENSION_TREE: TreeNode[] = [
  {
    id: 1, dimType: 'BUSINESS', dimCode: 'ENERGY', dimName: '电量', parentId: null,
    children: [
      { id: 11, dimType: 'BUSINESS', dimCode: 'CONTRACT_ENERGY', dimName: '合约电量', parentId: 1 },
      { id: 12, dimType: 'BUSINESS', dimCode: 'SPOT_ENERGY', dimName: '现货电量', parentId: 1 },
      { id: 13, dimType: 'BUSINESS', dimCode: 'DEVIATION_ENERGY', dimName: '偏差电量', parentId: 1 },
    ],
  },
  {
    id: 2, dimType: 'BUSINESS', dimCode: 'PRICE', dimName: '电价', parentId: null,
    children: [
      { id: 21, dimType: 'BUSINESS', dimCode: 'CLEARING_PRICE', dimName: '出清电价', parentId: 2 },
      { id: 22, dimType: 'BUSINESS', dimCode: 'DEVIATION_PRICE', dimName: '偏差电价', parentId: 2 },
      { id: 23, dimType: 'BUSINESS', dimCode: 'COMPOSITE_PRICE', dimName: '综合电价', parentId: 2 },
    ],
  },
  {
    id: 3, dimType: 'BUSINESS', dimCode: 'FEE', dimName: '电费', parentId: null,
    children: [
      { id: 31, dimType: 'BUSINESS', dimCode: 'CONTRACT_FEE', dimName: '合约电费', parentId: 3 },
      { id: 32, dimType: 'BUSINESS', dimCode: 'DEVIATION_FEE', dimName: '偏差电费', parentId: 3 },
      { id: 33, dimType: 'BUSINESS', dimCode: 'CFD_FEE', dimName: '差价合约', parentId: 3 },
    ],
  },
  { id: 4, dimType: 'BUSINESS', dimCode: 'MARGIN', dimName: '边际贡献', parentId: null },
  { id: 5, dimType: 'BUSINESS', dimCode: 'RATE', dimName: '负荷率/覆盖率', parentId: null },
]

// ─── 数据源映射 ──────────────────────────────────────
export const MOCK_SOURCE_MAPPINGS = [
  { id: 1, sourceName: '机组参数', sourceDb: 'bdss_basic_parameter', sourceTable: 'bas_unit', indicatorCode: 'RATED_CAPACITY', fieldName: 'ratedCapacity', extractType: 'DIRECT', schedule: 'DAILY', status: 1 },
  { id: 2, sourceName: '变动成本', sourceDb: 'bdss_cost_manage', sourceTable: 'cost_unit_curve', indicatorCode: 'RT_VAR_COST_PRICE', fieldName: 'price', extractType: 'DIRECT', schedule: 'DAILY', status: 1 },
  { id: 3, sourceName: '合约匹配', sourceDb: 'bdss_transaction_manage', sourceTable: 'trxn_contract_match_month', indicatorCode: 'BASE_CLEARING_ENERGY', fieldName: 'power', extractType: 'DIRECT', schedule: 'DAILY', status: 1 },
  { id: 4, sourceName: '日前出清', sourceDb: 'bdss_spot_market', sourceTable: 'spot_ahead_trade', indicatorCode: 'DAM_CLEARING_ENERGY', fieldName: 'power', extractType: 'DIRECT', schedule: 'HOURLY', status: 1 },
  { id: 5, sourceName: '实时出清', sourceDb: 'bdss_spot_market', sourceTable: 'spot_real_trade', indicatorCode: 'RTM_CLEARING_ENERGY', fieldName: 'power', extractType: 'DIRECT', schedule: 'HOURLY', status: 1 },
  { id: 6, sourceName: '上网电量', sourceDb: 'bdss_settlement_manage', sourceTable: 'sett_power_hour_unit', indicatorCode: 'ONLINE_ENERGY', fieldName: 'power', extractType: 'DIRECT', schedule: 'HOURLY', status: 1 },
  { id: 7, sourceName: '集团发电', sourceDb: 'bdss_group_data', sourceTable: 'ha_ssfdjh', indicatorCode: 'ACTUAL_OUTPUT', fieldName: 'value', extractType: 'DIRECT', schedule: 'DAILY', status: 1 },
  { id: 8, sourceName: '市场分析', sourceDb: 'bdss_market_analysis', sourceTable: 'mkt_netload', indicatorCode: 'BIDDING_SPACE', fieldName: 'value', extractType: 'DIRECT', schedule: 'DAILY', status: 0 },
]

// ─── 计算任务日志 ────────────────────────────────────
export const MOCK_CALC_TASKS: CalcTaskLog[] = [
  { id: 1, tradeDate: '2026-04-24', tenantId: 1, totalCount: 90, successCount: 85, failCount: 3, skipCount: 2, duration: 12450, status: 'SUCCESS', createTime: '2026-04-24 08:30:00' },
  { id: 2, tradeDate: '2026-04-23', tenantId: 1, totalCount: 90, successCount: 88, failCount: 1, skipCount: 1, duration: 10200, status: 'SUCCESS', createTime: '2026-04-23 08:15:00' },
  { id: 3, tradeDate: '2026-04-22', tenantId: 1, totalCount: 90, successCount: 78, failCount: 10, skipCount: 2, duration: 15600, status: 'FAILED', createTime: '2026-04-22 08:20:00' },
  { id: 4, tradeDate: '2026-04-21', tenantId: 1, totalCount: 90, successCount: 90, failCount: 0, skipCount: 0, duration: 9800, status: 'SUCCESS', createTime: '2026-04-21 08:10:00' },
  { id: 5, tradeDate: '2026-04-20', tenantId: 1, totalCount: 90, successCount: 82, failCount: 5, skipCount: 3, duration: 11200, status: 'SUCCESS', createTime: '2026-04-20 08:25:00' },
]

export const MOCK_CALC_DETAILS: CalcDetailLog[] = [
  { id: 1, taskId: 1, indicatorCode: 'DAM_CLEARING_ENERGY', indicatorName: '日前出清电量', calcLayer: 0, status: 'SUCCESS', affectedRows: 96, duration: 320, errorMsg: null },
  { id: 2, taskId: 1, indicatorCode: 'RTM_CLEARING_ENERGY', indicatorName: '实时出清电量', calcLayer: 0, status: 'SUCCESS', affectedRows: 96, duration: 280, errorMsg: null },
  { id: 3, taskId: 1, indicatorCode: 'DAM_DEV_ENERGY', indicatorName: '日前偏差电量', calcLayer: 2, status: 'SUCCESS', affectedRows: 96, duration: 450, errorMsg: null },
  { id: 4, taskId: 1, indicatorCode: 'SPOT_FULL_FEE', indicatorName: '现货电费', calcLayer: 1, status: 'SUCCESS', affectedRows: 96, duration: 380, errorMsg: null },
  { id: 5, taskId: 1, indicatorCode: 'TOTAL_AVG_PRICE', indicatorName: '度电价格', calcLayer: 3, status: 'FAILED', affectedRows: 0, duration: 120, errorMsg: '除零错误: ONLINE_ENERGY 为 null' },
  { id: 6, taskId: 1, indicatorCode: 'TOTAL_MARGIN', indicatorName: '总边际贡献', calcLayer: 3, status: 'FAILED', affectedRows: 0, duration: 80, errorMsg: '依赖指标 TOTAL_AVG_PRICE 计算失败' },
]

// ─── 时序数据生成器 ──────────────────────────────────
function pad(n: number): string { return String(n).padStart(2, '0') }
function toLocalDate(d: Date): string { return `${d.getFullYear()}-${pad(d.getMonth() + 1)}-${pad(d.getDate())}` }
function toLocalMonth(d: Date): string { return `${d.getFullYear()}-${pad(d.getMonth() + 1)}` }

export function generateMockTimeseries(): TimeseriesPoint[] {
  const today = toLocalDate(new Date())
  return Array.from({ length: 96 }, (_, i) => ({
    date: today,
    timePoint: i + 1,
    value: Math.round((200 + Math.sin(i / 10) * 80 + Math.random() * 30) * 100) / 100,
  }))
}

export function generateMockDaily(): DailyData[] {
  return Array.from({ length: 30 }, (_, i) => {
    const d = new Date()
    d.setDate(d.getDate() - 29 + i)
    return {
      date: toLocalDate(d),
      value: Math.round((800 + Math.random() * 600) * 100) / 100,
    }
  })
}

export function generateMockCompare(): CompareData[] {
  return Array.from({ length: 12 }, (_, i) => {
    const d = new Date()
    d.setMonth(d.getMonth() - 11 + i)
    return {
      period: toLocalMonth(d),
      value: Math.round((500 + Math.random() * 400) * 100) / 100,
      compareValue: Math.round((480 + Math.random() * 400) * 100) / 100,
      changeRate: Math.round((Math.random() * 30 - 10) * 10) / 10,
    }
  })
}

// ─── Dashboard 图表 Mock ────────────────────────────
export const MOCK_DEVIATION_DATA = [
  { name: '日前偏差电量', today: '+45.2', yesterday: '+38.7', changeRate: '↑16.8%', todayColor: 'text-success', changeColor: 'text-success' },
  { name: '实时偏差电量', today: '-12.3', yesterday: '-8.5', changeRate: '↓44.7%', todayColor: 'text-error', changeColor: 'text-error' },
  { name: '日前偏差电价', today: '+12.5', yesterday: '+8.3', changeRate: '↑50.6%', todayColor: 'text-success', changeColor: 'text-success' },
  { name: '综合电价偏差', today: '-5.2', yesterday: '-3.1', changeRate: '↓67.7%', todayColor: 'text-error', changeColor: 'text-error' },
  { name: '合约覆盖率', today: '78.5%', yesterday: '80.2%', changeRate: '↓2.1%', todayColor: 'text-warning', changeColor: 'text-warning' },
]

export function generate96TimePoints(): string[] {
  return Array.from({ length: 96 }, (_, i) => {
    const h = Math.floor((i + 1) / 4)
    const m = ((i + 1) % 4) * 15
    return `${String(h).padStart(2, '0')}:${String(m).padStart(2, '0')}`
  })
}

export function generateLast30Days(): string[] {
  return Array.from({ length: 30 }, (_, i) => {
    const d = new Date()
    d.setDate(d.getDate() - 29 + i)
    return `${d.getMonth() + 1}/${d.getDate()}`
  })
}
