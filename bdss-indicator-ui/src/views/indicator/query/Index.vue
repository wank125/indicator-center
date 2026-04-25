<template>
  <div class="page-container query-page">
    <el-container>
      <!-- 左侧指标树 -->
      <el-aside width="240px" class="tree-aside">
        <IndicatorTree
          :dim-type="dimType"
          :filter="treeFilter"
          :tree-data="store.dimensionTree"
          @update:dim-type="handleDimChange"
          @update:filter="treeFilter = $event"
          @node-click="handleNodeClick"
        />
      </el-aside>

      <!-- 右侧查询区域 -->
      <el-main class="query-main">
        <!-- 工具栏 -->
        <Toolbar
          :indicator-code="store.selectedCode"
          :date-range="queryDateRange"
          :grain="store.queryParams.grain"
          :loading="store.dataLoading"
          @update:indicator-code="store.setSelectedCode($event || '')"
          @update:date-range="queryDateRange = $event"
          @update:grain="store.queryParams.grain = $event"
          @query="handleQuery"
          @export="handleExport"
          @multi-query="multiDialogVisible = true"
        />

        <!-- 图表区域 -->
        <div class="card-section">
          <IndicatorChart
            title="指标趋势"
            v-model:chart-type="chartType"
            :x-data="chartXData"
            :y-data="chartYData"
          />
        </div>

        <!-- 同环比对比 -->
        <div class="card-section">
          <CompareTable v-model:compare-type="compareType" :data="store.compareData" />
        </div>

        <!-- 明细表格 -->
        <div class="card-section">
          <DataTable :data="tableData" />
        </div>
      </el-main>
    </el-container>

    <!-- 多指标对比弹窗 -->
    <MultiQueryDialog v-model="multiDialogVisible" />
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import IndicatorTree from './IndicatorTree.vue'
import Toolbar from './Toolbar.vue'
import IndicatorChart from './IndicatorChart.vue'
import CompareTable from './CompareTable.vue'
import DataTable from './DataTable.vue'
import MultiQueryDialog from './MultiQueryDialog.vue'
import { useIndicatorStore } from '@/stores/indicator'
import { MOCK_INDICATOR_OPTIONS } from '@/api/mock-data'

const store = useIndicatorStore()

const dimType = ref<'BUSINESS' | 'MARKET' | 'SUBJECT'>('BUSINESS')
const treeFilter = ref('')
const queryDateRange = ref<string[]>([])
const chartType = ref<'line' | 'bar' | 'area'>('line')
const compareType = ref<'yoy' | 'mom'>('yoy')
const multiDialogVisible = ref(false)

const tableData = computed(() => {
  if (store.queryParams.grain === 'timeseries') return store.timeseriesData
  return store.dailyData
})

const chartXData = computed(() => {
  const data = store.queryParams.grain === 'timeseries' ? store.timeseriesData : store.dailyData
  return data.map((d: any) => d.date || d.timePoint)
})

const chartYData = computed(() => {
  const data = store.queryParams.grain === 'timeseries' ? store.timeseriesData : store.dailyData
  return data.map((d: any) => d.value)
})

function handleDimChange(type: 'BUSINESS' | 'MARKET' | 'SUBJECT') {
  dimType.value = type
  store.loadDimensionTree(type)
}

function handleNodeClick(data: any) {
  // 维度树叶子节点是分类（如 CLEARING_PRICE），不是指标编码（如 DAM_CLEARING_PRICE）
  // 只有当 dimCode 能匹配到真实指标编码时才触发查询
  const matched = MOCK_INDICATOR_OPTIONS.find((o) => o.code === data.dimCode)
  if (matched) {
    store.setSelectedCode(matched.code)
    handleQuery()
  }
}

async function handleQuery() {
  if (!store.selectedCode) return
  const [start, end] = queryDateRange.value.length === 2
    ? queryDateRange.value
    : [store.queryParams.startDate, store.queryParams.endDate]
  if (store.queryParams.grain === 'timeseries') {
    await store.loadTimeseries(store.selectedCode, start, end)
  } else {
    await store.loadDaily(store.selectedCode, start, end)
  }
  store.loadCompare(store.selectedCode, compareType.value)
}

function handleExport() {
  // TODO: 接入后端导出接口
}

onMounted(() => {
  store.initDefaultDate()
  queryDateRange.value = [store.queryParams.startDate, store.queryParams.endDate]
  store.loadDimensionTree(dimType.value)
})
</script>

<style scoped lang="scss">
.query-page {
  .el-container { gap: 12px; }
  .tree-aside {
    background: var(--color-card); border-radius: var(--radius-card);
    padding: 12px; height: calc(100vh - 120px); overflow-y: auto;
  }
  .query-main { padding: 0; overflow: visible; }
}
</style>
