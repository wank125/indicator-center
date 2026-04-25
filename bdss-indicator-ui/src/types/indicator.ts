/** 指标数据类型 */
export interface IndicatorDef {
  id: number
  indicatorCode: string
  indicatorName: string
  indicatorType: number // 1=原始 2=计算 3=派生
  marketType: string
  subjectType: string
  categoryL1: string
  categoryL2: string
  unit: string
  timeGrain: string
  calcLayer: number
  status: number
  tenantId: number
}

/** 维度树节点 */
export interface TreeNode {
  id: number
  dimType: string
  dimCode: string
  dimName: string
  parentId: number | null
  children?: TreeNode[]
}

/** 分时数据点 */
export interface TimeseriesPoint {
  date: string
  timePoint: number
  value: number | null
}

/** 日维度数据 */
export interface DailyData {
  date: string
  value: number | null
}

/** 月维度数据 */
export interface MonthlyData {
  month: string
  value: number | null
  yearCumulative: number | null
}

/** 同环比数据 */
export interface CompareData {
  period: string
  value: number | null
  compareValue: number | null
  changeRate: number | null
}

/** 排名数据 */
export interface RankData {
  rank: number
  entityName: string
  value: number | null
  changeDirection?: 'up' | 'down' | 'same'
}

/** 查询参数 */
export interface TimeseriesParams {
  indicatorCode: string
  unitId?: string
  startDate: string
  endDate: string
  dataType?: number
}

export interface DailyParams {
  indicatorCode: string
  unitId?: string
  startDate: string
  endDate: string
}

export interface MonthlyParams {
  indicatorCode: string
  unitId?: string
  startMonth: string
  endMonth: string
}

export interface CompareParams {
  indicatorCode: string
  unitId?: string
  compareType: 'yoy' | 'mom'
  periods?: number
}

export interface RankParams {
  indicatorCode: string
  rankBy: string
  topN?: number
  period?: string
}

export interface BatchQueryReq {
  codes: string[]
  unitId?: string
  startDate: string
  endDate: string
  grain: 'timeseries' | 'daily' | 'monthly'
}

export interface CalcTriggerReq {
  indicatorCodes?: string[]
  tradeDate: string
  forceRecalc?: boolean
}

export interface CalcLogParams {
  tenantId?: number
  tradeDate?: string
  status?: string
  calcLayer?: number
  pageNum?: number
  pageSize?: number
}

/** 计算日志明细 */
export interface CalcDetailLog {
  id: number
  taskId: number
  indicatorCode: string
  indicatorName: string
  calcLayer: number
  status: string
  affectedRows: number
  duration: number
  errorMsg: string | null
}

/** 计算任务日志 */
export interface CalcTaskLog {
  id: number
  tradeDate: string
  tenantId: number
  totalCount: number
  successCount: number
  failCount: number
  skipCount: number
  duration: number
  status: string
  createTime: string
}

/** KPI卡片数据 */
export interface KpiData {
  code: string
  label: string
  value: number | null
  unit: string
  changeRate: number | null
  changeType: 'yoy' | 'mom'
  changeDirection: 'up' | 'down' | 'flat'
}

/** 粒度类型 */
export type GrainType = 'timeseries' | 'daily' | 'monthly'
