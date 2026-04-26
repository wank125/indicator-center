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
import { getDimensionTree, getKpi, getTimeseries, getDaily, getMonthly, getCompare } from '@/api/request'
import {
  MOCK_DIMENSION_TREE,
  MOCK_KPI,
  generateMockTimeseries,
  generateMockDaily,
  generateMockCompare,
} from '@/api/mock-data'

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
      dimensionTree.value = await getDimensionTree(dimensionType.value, tenantId.value)
    } catch {
      dimensionTree.value = MOCK_DIMENSION_TREE
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
      } as any)
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
      } as any)
    } catch {
      dailyData.value = generateMockDaily()
    } finally {
      dataLoading.value = false
    }
  }

  async function loadMonthly(code: string, startMonth: string, endMonth: string) {
    dataLoading.value = true
    try {
      monthlyData.value = await getMonthly({
        indicatorCode: code,
        unitId: selectedUnitId.value,
        startMonth: startMonth.slice(0, 7),
        endMonth: endMonth.slice(0, 7),
      } as any)
    } catch {
      monthlyData.value = []
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
      } as any)
    } catch {
      compareData.value = generateMockCompare()
    }
  }

  // ─── KPI ────────────────────────────
  const kpiList = ref<KpiData[]>([])
  const kpiLoading = ref(false)

  async function loadKpi() {
    kpiLoading.value = true
    try {
      kpiList.value = await getKpi(tenantId.value as number)
    } catch {
      kpiList.value = MOCK_KPI
    } finally {
      kpiLoading.value = false
    }
  }

  // ─── 省网/日期 ──────────────────────
  const selectedProvince = ref<number | string>('')
  const tenantId = ref<number | undefined>(undefined)
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
    loadMonthly,
    loadCompare,
    kpiList,
    kpiLoading,
    loadKpi,
    selectedProvince,
    tenantId,
    selectedDate,
    initDefaultDate,
  }
})

function formatDate(d: Date): string {
  const y = d.getFullYear()
  const m = String(d.getMonth() + 1).padStart(2, '0')
  const day = String(d.getDate()).padStart(2, '0')
  return `${y}-${m}-${day}`
}

function addDays(d: Date, n: number): Date {
  const r = new Date(d)
  r.setDate(r.getDate() + n)
  return r
}
