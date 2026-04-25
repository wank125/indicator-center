<template>
  <div ref="chartRef" :style="{ height: height + 'px' }"></div>
</template>

<script setup lang="ts">
import { ref, onMounted, onUnmounted, watch } from 'vue'
import * as echarts from 'echarts'
import { generate96TimePoints } from '@/api/mock-data'

const props = withDefaults(defineProps<{
  height?: number
}>(), { height: 280 })

const chartRef = ref<HTMLElement>()
let chart: echarts.ECharts | null = null

function initChart() {
  if (!chartRef.value) return
  if (!chart) chart = echarts.init(chartRef.value)

  const timePoints = generate96TimePoints()
  const actual = timePoints.map((_, i) => Math.round((250 + Math.sin(i / 10) * 80 + Math.random() * 30) * 100) / 100)
  const algo = timePoints.map((_, i) => Math.round((240 + Math.sin(i / 10) * 75 + Math.random() * 20) * 100) / 100)
  const predict = timePoints.map((_, i) => Math.round((245 + Math.sin(i / 10) * 70 + Math.random() * 25) * 100) / 100)

  chart.setOption({
    tooltip: { trigger: 'axis', valueFormatter: (v: number) => v?.toFixed(2) + ' 元/MWh' },
    legend: { data: ['实际', '算法预测', '日前预测'], top: 0 },
    grid: { left: 60, right: 20, top: 40, bottom: 60 },
    xAxis: { type: 'category', data: timePoints, axisLabel: { interval: 11 } },
    yAxis: { type: 'value', name: '元/MWh', scale: true },
    dataZoom: [{ type: 'inside' }, { type: 'slider', height: 20 }],
    series: [
      { name: '实际', type: 'line', smooth: true, data: actual, lineStyle: { width: 2 } },
      { name: '算法预测', type: 'line', smooth: true, data: algo, lineStyle: { type: 'dashed' } },
      { name: '日前预测', type: 'line', smooth: true, data: predict, lineStyle: { type: 'dotted' } },
    ],
  })
}

function handleResize() { chart?.resize() }

onMounted(() => { initChart(); window.addEventListener('resize', handleResize) })
onUnmounted(() => { chart?.dispose(); chart = null; window.removeEventListener('resize', handleResize) })

watch(() => props.height, () => { chart?.resize() })
</script>
