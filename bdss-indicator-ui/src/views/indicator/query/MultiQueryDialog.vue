<template>
  <el-dialog v-model="visible" title="多指标对比" width="900px" destroy-on-close @open="handleOpen">
    <div class="multi-query-content">
      <!-- 指标选择行 -->
      <div class="indicator-selector">
        <div v-for="(item, idx) in selectedIndicators" :key="idx" class="indicator-chip">
          <el-tag closable :type="tagColors[idx]" @close="removeIndicator(idx)">
            {{ item.name }} ({{ item.code }})
          </el-tag>
        </div>
        <el-select
          v-if="selectedIndicators.length < 5"
          v-model="addingCode"
          placeholder="+ 添加指标"
          filterable
          size="small"
          style="width: 200px"
          @change="addIndicator"
        >
          <el-option
            v-for="opt in availableOptions"
            :key="opt.code"
            :label="`${opt.name} (${opt.code})`"
            :value="opt.code"
          />
        </el-select>
        <span class="hint">最多 5 个指标</span>
      </div>

      <!-- 时间范围 + 粒度 -->
      <el-row :gutter="12" style="margin-bottom: 16px">
        <el-col :span="12">
          <DateRangePicker v-model="dateRange" />
        </el-col>
        <el-col :span="6">
          <GrainSwitch v-model="grain" />
        </el-col>
        <el-col :span="6" style="text-align: right">
          <el-button type="primary" size="small" :loading="loading" @click="executeQuery">查询对比</el-button>
        </el-col>
      </el-row>

      <!-- 叠加图表 -->
      <div ref="chartRef" class="multi-chart"></div>

      <!-- 对比表格 -->
      <el-table v-if="tableData.length" :data="tableData" size="small" stripe max-height="300" style="margin-top: 16px">
        <el-table-column prop="date" label="日期" width="140" fixed />
        <el-table-column
          v-for="ind in selectedIndicators"
          :key="ind.code"
          :label="ind.name"
          align="right"
          width="140"
        >
          <template #default="{ row }">{{ row[ind.code] ?? '--' }}</template>
        </el-table-column>
      </el-table>
      <el-empty v-else description="添加指标后点击查询" :image-size="60" />
    </div>
  </el-dialog>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import * as echarts from 'echarts'
import DateRangePicker from '../components/DateRangePicker.vue'
import GrainSwitch from '../components/GrainSwitch.vue'
import { MOCK_INDICATOR_OPTIONS, generateMockDaily } from '@/api/mock-data'
import type { GrainType } from '@/types/indicator'

const props = defineProps<{ modelValue: boolean }>()
const emit = defineEmits<{ 'update:modelValue': [v: boolean] }>()

const visible = computed({
  get: () => props.modelValue,
  set: (v) => emit('update:modelValue', v),
})

const tagColors = ['', 'success', 'warning', 'danger', 'info']
const loading = ref(false)
const addingCode = ref('')
const grain = ref<GrainType>('daily')
const dateRange = ref<string[]>([])
const chartRef = ref<HTMLElement>()
let chart: echarts.ECharts | null = null

interface SelectedIndicator { code: string; name: string; unit: string }
const selectedIndicators = ref<SelectedIndicator[]>([])

const availableOptions = computed(() => {
  const used = new Set(selectedIndicators.value.map((i) => i.code))
  return MOCK_INDICATOR_OPTIONS.filter((o) => !used.has(o.code))
})

const tableData = ref<Array<Record<string, any>>>([])

function handleOpen() {
  if (!dateRange.value.length) {
    const end = new Date()
    const start = new Date()
    start.setDate(start.getDate() - 30)
    function toLocalDate(d: Date): string {
      return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, '0')}-${String(d.getDate()).padStart(2, '0')}`
    }
    dateRange.value = [toLocalDate(start), toLocalDate(end)]
  }
}

function addIndicator(code: string) {
  const opt = MOCK_INDICATOR_OPTIONS.find((o) => o.code === code)
  if (!opt) return
  selectedIndicators.value.push({ code: opt.code, name: opt.name, unit: opt.unit })
  addingCode.value = ''
}

function removeIndicator(idx: number) {
  selectedIndicators.value.splice(idx, 1)
}

async function executeQuery() {
  if (!selectedIndicators.value.length) return
  loading.value = true

  // Generate mock data for each indicator
  const seriesData: Record<string, number[]> = {}
  const dates: string[] = []
  const mockDaily = generateMockDaily()

  mockDaily.forEach((d, i) => {
    dates.push(d.date)
    selectedIndicators.value.forEach((ind) => {
      if (!seriesData[ind.code]) seriesData[ind.code] = []
      seriesData[ind.code].push(Math.round((300 + Math.sin(i / 5) * 200 + Math.random() * 100) * 100) / 100)
    })
  })

  // Update chart
  await import('vue').then(({ nextTick }) => nextTick())
  if (!chartRef.value) { loading.value = false; return }
  if (!chart) chart = echarts.init(chartRef.value)

  const colors = ['#1890ff', '#52c41a', '#faad14', '#ff4d4f', '#722ed1']
  const series = selectedIndicators.value.map((ind, i) => ({
    name: ind.name,
    type: 'line' as const,
    smooth: true,
    data: seriesData[ind.code],
    lineStyle: { color: colors[i] },
    itemStyle: { color: colors[i] },
  }))

  chart.setOption({
    tooltip: { trigger: 'axis' },
    legend: { data: selectedIndicators.value.map((i) => i.name), top: 0 },
    grid: { left: 60, right: 20, top: 40, bottom: 40 },
    xAxis: { type: 'category', data: dates, axisLabel: { interval: 4 } },
    yAxis: { type: 'value', scale: true },
    series,
  }, true)

  // Update table
  tableData.value = mockDaily.map((d, i) => {
    const row: Record<string, any> = { date: d.date }
    selectedIndicators.value.forEach((ind) => {
      row[ind.code] = seriesData[ind.code][i]
    })
    return row
  })

  loading.value = false
}
</script>

<style scoped lang="scss">
.multi-query-content {
  .indicator-selector {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    gap: 8px;
    margin-bottom: 16px;
  }

  .hint {
    font-size: var(--font-aux);
    color: #999;
  }

  .multi-chart {
    height: 300px;
    width: 100%;
  }
}
</style>
