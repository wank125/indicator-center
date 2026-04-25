import axios from 'axios'
import type {
  TimeseriesParams,
  DailyParams,
  MonthlyParams,
  CompareParams,
  RankParams,
  BatchQueryReq,
  CalcTriggerReq,
  CalcLogParams,
  KpiData,
  TimeseriesPoint,
  DailyData,
  MonthlyData,
  CompareData,
  RankData,
  IndicatorDef,
  TreeNode,
  CalcTaskLog,
} from '@/types/indicator'

const request = axios.create({
  baseURL: '',
  timeout: 30000,
})

request.interceptors.response.use(
  (res) => {
    const data = res.data
    if (data.code === 200 || data.code === 0) {
      return data.data
    }
    return Promise.reject(new Error(data.msg || '请求失败'))
  },
  (err) => Promise.reject(err),
)

// ─── KPI ────────────────────────────────
export function getKpi(tenantId?: number): Promise<KpiData[]> {
  return request.get('/qctc/indicator/data/kpi', { params: { tenantId } })
}

// ─── 指标定义 ───────────────────────────
export function getDefinitions(params?: Record<string, any>): Promise<{ list: IndicatorDef[]; total: number }> {
  return request.get('/qctc/indicator/definitions', { params })
}

export function getDefinition(code: string): Promise<IndicatorDef> {
  return request.get(`/qctc/indicator/definitions/${code}`)
}

export function createDefinition(data: Partial<IndicatorDef>): Promise<void> {
  return request.post('/qctc/indicator/definitions', data)
}

export function updateDefinition(code: string, data: Partial<IndicatorDef>): Promise<void> {
  return request.put(`/qctc/indicator/definitions/${code}`, data)
}

export function deleteDefinition(code: string): Promise<void> {
  return request.delete(`/qctc/indicator/definitions/${code}`)
}

// ─── 维度树 ─────────────────────────────
export function getDimensionTree(dimType: string, tenantId?: number): Promise<TreeNode[]> {
  return request.get('/qctc/indicator/dimensions/tree', { params: { dimType, tenantId } })
}

// ─── 数据查询 ───────────────────────────
export function getTimeseries(params: TimeseriesParams): Promise<TimeseriesPoint[]> {
  return request.get('/qctc/indicator/data/timeseries', { params })
}

export function getDaily(params: DailyParams): Promise<DailyData[]> {
  return request.get('/qctc/indicator/data/daily', { params })
}

export function getMonthly(params: MonthlyParams): Promise<MonthlyData[]> {
  return request.get('/qctc/indicator/data/monthly', { params })
}

export function getCompare(params: CompareParams): Promise<CompareData[]> {
  return request.get('/qctc/indicator/data/compare', { params })
}

export function getRank(params: RankParams): Promise<RankData[]> {
  return request.get('/qctc/indicator/data/rank', { params })
}

export function batchQuery(req: BatchQueryReq): Promise<Record<string, DailyData[]>> {
  return request.post('/qctc/indicator/data/batch', req)
}

// ─── 计算任务 ───────────────────────────
export function triggerCalc(req: CalcTriggerReq): Promise<CalcTaskLog> {
  return request.post('/qctc/indicator/calc/trigger', req)
}

export function getCalcStatus(taskId: number): Promise<CalcTaskLog> {
  return request.get(`/qctc/indicator/calc/status/${taskId}`)
}

export function getCalcLog(params: CalcLogParams): Promise<{ list: CalcTaskLog[]; total: number }> {
  return request.get('/qctc/indicator/calc/log', {
    params: {
      tenantId: params.tenantId,
      page: params.pageNum || 1,
      size: params.pageSize || 20,
    },
  })
}
