<template>
  <div ref="chartRef" :style="{ height: height + 'px' }"></div>
</template>

<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue'
import * as echarts from 'echarts'
import { generateLast30Days } from '@/api/mock-data'

const props = withDefaults(defineProps<{
  height?: number
}>(), { height: 200 })

const chartRef = ref<HTMLElement>()
let chart: echarts.ECharts | null = null

function initChart() {
  if (!chartRef.value) return
  if (!chart) chart = echarts.init(chartRef.value)

  const days = generateLast30Days()
  const coverageData = days.map(() => Math.round((70 + Math.random() * 20) * 10) / 10)
  const costData = days.map(() => Math.round((180 + Math.random() * 80) * 100) / 100)
  const genData = days.map(() => Math.round(600 + Math.random() * 400))

  chart.setOption({
    tooltip: { trigger: 'axis' },
    legend: { data: ['合约覆盖率', '度电成本', '发电量'], top: 0 },
    grid: { left: 50, right: 50, top: 40, bottom: 30 },
    xAxis: { type: 'category', data: days, axisLabel: { interval: 6 } },
    yAxis: [
      { type: 'value', name: '%', min: 60, max: 100 },
      { type: 'value', name: '元/MWh / MWh' },
    ],
    series: [
      {
        name: '合约覆盖率', type: 'line', data: coverageData, smooth: true,
        lineStyle: { color: '#1890ff' }, itemStyle: { color: '#1890ff' },
        areaStyle: { opacity: 0.1 },
      },
      {
        name: '度电成本', type: 'line', data: costData, smooth: true, yAxisIndex: 1,
        lineStyle: { color: '#faad14' }, itemStyle: { color: '#faad14' },
      },
      {
        name: '发电量', type: 'bar', data: genData, yAxisIndex: 1,
        itemStyle: { color: 'rgba(24,144,255,0.15)' },
      },
    ],
  })
}

function handleResize() { chart?.resize() }

onMounted(() => { initChart(); window.addEventListener('resize', handleResize) })
onUnmounted(() => { chart?.dispose(); chart = null; window.removeEventListener('resize', handleResize) })
</script>
