<template>
  <div>
    <div class="chart-toolbar">
      <span class="chart-label">{{ title }}</span>
      <el-button-group>
        <el-button size="small" :type="chartType === 'line' ? 'primary' : ''" @click="$emit('update:chartType', 'line')">折线</el-button>
        <el-button size="small" :type="chartType === 'bar' ? 'primary' : ''" @click="$emit('update:chartType', 'bar')">柱状</el-button>
        <el-button size="small" :type="chartType === 'area' ? 'primary' : ''" @click="$emit('update:chartType', 'area')">面积</el-button>
      </el-button-group>
    </div>
    <div ref="chartRef" class="query-chart"></div>
  </div>
</template>

<script setup lang="ts">
import { ref, watch, onMounted, onUnmounted } from 'vue'
import * as echarts from 'echarts'

const props = defineProps<{
  title?: string
  chartType: 'line' | 'bar' | 'area'
  xData: (string | number)[]
  yData: (number | null)[]
  unit?: string
}>()

defineEmits<{
  'update:chartType': [value: 'line' | 'bar' | 'area']
}>()

const chartRef = ref<HTMLElement>()
let chart: echarts.ECharts | null = null

function renderChart() {
  if (!chartRef.value) return
  if (!chart) chart = echarts.init(chartRef.value)

  const seriesName = props.title || '指标'
  const unitLabel = props.unit || ''

  const seriesBase: any = {
    name: seriesName,
    data: props.yData,
    smooth: true,
    lineStyle: { color: '#1890ff' },
    itemStyle: { color: '#1890ff' },
  }

  if (props.chartType === 'area') {
    seriesBase.type = 'line'
    seriesBase.areaStyle = { opacity: 0.15 }
  } else if (props.chartType === 'bar') {
    seriesBase.type = 'bar'
  } else {
    seriesBase.type = 'line'
  }

  chart.setOption({
    tooltip: {
      trigger: 'axis',
      formatter(params: any) {
        const p = Array.isArray(params) ? params[0] : params
        const val = p.value != null ? p.value.toLocaleString('zh-CN', { maximumFractionDigits: 4 }) : '--'
        return `${p.axisValue}<br/>${p.marker} ${p.seriesName}: <b>${val}</b>${unitLabel ? ' ' + unitLabel : ''}`
      },
    },
    legend: { data: [seriesName], top: 0, right: 0 },
    grid: { left: 70, right: 20, top: 30, bottom: 60 },
    xAxis: {
      type: 'category',
      data: props.xData,
      axisLabel: { rotate: props.xData.length > 30 ? 45 : 0, fontSize: 11 },
    },
    yAxis: {
      type: 'value',
      scale: true,
      name: unitLabel,
      nameTextStyle: { align: 'right', padding: [0, 40, 0, 0] },
    },
    dataZoom: [
      { type: 'inside', start: 0, end: 100 },
      { type: 'slider', start: 0, end: 100, height: 20, bottom: 5 },
    ],
    series: [seriesBase],
  }, true)
}

function handleResize() { chart?.resize() }

watch(() => [props.xData, props.yData, props.chartType], renderChart, { deep: true })

onMounted(() => { renderChart(); window.addEventListener('resize', handleResize) })
onUnmounted(() => { chart?.dispose(); chart = null; window.removeEventListener('resize', handleResize) })
</script>

<style scoped lang="scss">
.chart-toolbar {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 8px;
}

.chart-label {
  font-size: var(--font-title);
  font-weight: 600;
}

.query-chart {
  height: 380px;
  width: 100%;
}
</style>
