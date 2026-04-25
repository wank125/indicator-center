import { ref } from 'vue'
import { defineStore } from 'pinia'
import type {
  TreeNode,
  GrainType,
  TimeseriesPoint,
  DailyData,
  MonthlyData,
  CompareData,
  KpiData,
} from '@/types/indicator'
import { getDimensionTree, getKpi, getTimeseries, getDaily, getCompare } from '@/api/request'

export const useIndicatorStore = defineStore('indicator', () => {
  // ─── 维度树 ─────────────────────────
  const dimensionType = ref<'BUSINESS' | 'MARKET' | 'SUBJECT'>('BUSINESS')
  const dimensionTree = ref<TreeNode[]>([])
  const selectedDimension = ref<string | null>(null)
  const treeLoading = ref(false)

  async function loadDimensionTree(type?: 'BUSINESS' | 'MARKET' | 'SUBJECT') {
    if (type) dimensionType.value = type
    treeLoading.value = true
    try {
      dimensionTree.value = await getDimensionTree(dimensionType.value)
    } catch {
      dimensionTree.value = getMockDimensionTree()
    } finally {
      treeLoading.value = false
    }
  }

  // ─── 当前查询 ───────────────────────
  const selectedCode = ref<string | null>(null)
  const selectedUnitId = ref<string>('ALL')
  const queryParams = ref({
    indicatorCodes: [] as string[],
    startDate: '',
    endDate: '',
    grain: 'daily' as GrainType,
    unitId: 'ALL',
    dataType: 1,
  })

  function setSelectedCode(code: string) {
    selectedCode.value = code
    queryParams.value.indicatorCodes = [code]
  }

  // ─── 数据缓存 ───────────────────────
  const timeseriesData = ref<TimeseriesPoint[]>([])
  const dailyData = ref<DailyData[]>([])
  const monthlyData = ref<MonthlyData[]>([])
  const compareData = ref<CompareData[]>([])
  const dataLoading = ref(false)

  async function loadTimeseries(code: string, startDate: string, endDate: string) {
    dataLoading.value = true
    try {
      timeseriesData.value = await getTimeseries({
        indicatorCode: code,
        unitId: selectedUnitId.value,
        startDate,
        endDate,
      })
    } catch {
      timeseriesData.value = generateMockTimeseries()
    } finally {
      dataLoading.value = false
    }
  }

  async function loadDaily(code: string, startDate: string, endDate: string) {
    dataLoading.value = true
    try {
      dailyData.value = await getDaily({
        indicatorCode: code,
        unitId: selectedUnitId.value,
        startDate,
        endDate,
      })
    } catch {
      dailyData.value = generateMockDaily()
    } finally {
      dataLoading.value = false
    }
  }

  async function loadCompare(code: string, type: 'yoy' | 'mom') {
    try {
      compareData.value = await getCompare({
        indicatorCode: code,
        unitId: selectedUnitId.value,
        compareType: type,
      })
    } catch {
      compareData.value = []
    }
  }

  // ─── KPI ────────────────────────────
  const kpiList = ref<KpiData[]>([])
  const kpiLoading = ref(false)

  async function loadKpi() {
    kpiLoading.value = true
    try {
      kpiList.value = await getKpi()
    } catch {
      kpiList.value = getMockKpi()
    } finally {
      kpiLoading.value = false
    }
  }

  // ─── 省网/日期 ──────────────────────
  const selectedProvince = ref<string>('')
  const selectedDate = ref<string>('')

  function initDefaultDate() {
    const yesterday = new Date()
    yesterday.setDate(yesterday.getDate() - 1)
    selectedDate.value = formatDate(yesterday)
    queryParams.value.startDate = formatDate(addDays(yesterday, -30))
    queryParams.value.endDate = selectedDate.value
  }

  return {
    dimensionType,
    dimensionTree,
    selectedDimension,
    treeLoading,
    loadDimensionTree,
    selectedCode,
    selectedUnitId,
    queryParams,
    setSelectedCode,
    timeseriesData,
    dailyData,
    monthlyData,
    compareData,
    dataLoading,
    loadTimeseries,
    loadDaily,
    loadCompare,
    kpiList,
    kpiLoading,
    loadKpi,
    selectedProvince,
    selectedDate,
    initDefaultDate,
  }
})

// ─── 工具函数 ─────────────────────────
function formatDate(d: Date): string {
  return d.toISOString().slice(0, 10)
}

function addDays(d: Date, n: number): Date {
  const r = new Date(d)
  r.setDate(r.getDate() + n)
  return r
}

// ─── Mock 数据 ────────────────────────
function getMockKpi(): KpiData[] {
  return [
    { code: 'MLT_CONTRACT_ENERGY', label: '中长期电量', value: 1234.5, unit: 'MWh', changeRate: 5.2, changeType: 'yoy', changeDirection: 'up' },
    { code: 'TOTAL_ONLINE_ENERGY', label: '上网电量', value: 987.6, unit: 'MWh', changeRate: -1.3, changeType: 'mom', changeDirection: 'down' },
    { code: 'SPOT_FULL_FEE', label: '现货电费', value: 256780, unit: '元', changeRate: 8.7, changeType: 'yoy', changeDirection: 'up' },
    { code: 'TOTAL_AVG_PRICE', label: '度电价格', value: 312.5, unit: '元/MWh', changeRate: 3.1, changeType: 'yoy', changeDirection: 'up' },
    { code: 'TOTAL_MARGIN', label: '总边际贡献', value: 89450, unit: '元', changeRate: 12.3, changeType: 'yoy', changeDirection: 'up' },
  ]
}

function getMockDimensionTree(): TreeNode[] {
  return [
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
    {
      id: 4, dimType: 'BUSINESS', dimCode: 'MARGIN', dimName: '边际贡献', parentId: null },
    {
      id: 5, dimType: 'BUSINESS', dimCode: 'RATE', dimName: '负荷率/覆盖率', parentId: null },
  ]
}

function generateMockTimeseries(): TimeseriesPoint[] {
  const today = new Date().toISOString().slice(0, 10)
  return Array.from({ length: 96 }, (_, i) => ({
    date: today,
    timePoint: i + 1,
    value: Math.round((200 + Math.sin(i / 10) * 80 + Math.random() * 30) * 100) / 100,
  }))
}

function generateMockDaily(): DailyData[] {
  return Array.from({ length: 30 }, (_, i) => {
    const d = new Date()
    d.setDate(d.getDate() - 29 + i)
    return {
      date: d.toISOString().slice(0, 10),
      value: Math.round((800 + Math.random() * 600) * 100) / 100,
    }
  })
}
