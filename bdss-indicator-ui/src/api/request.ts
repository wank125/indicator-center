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
  CalcDetailLog,
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

export function getCalcDetail(taskId: number): Promise<CalcDetailLog[]> {
  return request.get(`/qctc/indicator/calc/log/${taskId}/detail`)
}

// ─── 公式配置 ───────────────────────────
export interface FormulaData {
  id?: number
  indicatorCode: string
  formulaType: number
  formulaExpr: string
  deps?: string
  depCodes?: string
  calcOrder?: number
  conditionExpr?: string
  trueValueExpr?: string
  falseValue?: string
  status?: number
}

export function getFormulaList(indicatorCode?: string): Promise<FormulaData[]> {
  return request.get('/qctc/indicator/formula/list', { params: { indicatorCode } })
}

export function getFormulaByCode(indicatorCode: string): Promise<FormulaData> {
  return request.get(`/qctc/indicator/formula/code/${indicatorCode}`)
}

export function saveFormula(data: FormulaData): Promise<void> {
  return request.post('/qctc/indicator/formula', data)
}

export function updateFormula(id: number, data: FormulaData): Promise<void> {
  return request.put(`/qctc/indicator/formula/${id}`, data)
}

export function validateFormula(data: FormulaData): Promise<boolean> {
  return request.post('/qctc/indicator/formula/validate', data)
}

// ─── 数据源映射 ─────────────────────────
export interface SourceMappingData {
  id?: number
  indicatorCode: string
  sourceType?: number
  sourceDb: string
  sourceTable: string
  sourceField: string
  filterCondition?: string
  dateField?: string
  timeField?: string
  tenantField?: string
  status?: number
}

export function getSourceMappings(indicatorCode?: string): Promise<SourceMappingData[]> {
  return request.get('/qctc/indicator/source/list', { params: { indicatorCode } })
}

export function saveSourceMapping(data: SourceMappingData): Promise<void> {
  return request.post('/qctc/indicator/source', data)
}

export function updateSourceMapping(id: number, data: SourceMappingData): Promise<void> {
  return request.put(`/qctc/indicator/source/${id}`, data)
}

export function deleteSourceMapping(id: number): Promise<void> {
  return request.delete(`/qctc/indicator/source/${id}`)
}

export function testSourceMapping(id: number): Promise<boolean> {
  return request.post(`/qctc/indicator/source/${id}/test`)
}
