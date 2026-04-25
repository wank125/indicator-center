<template>
  <div ref="chartRef" :style="{ height: height + 'px' }"></div>
</template>

<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue'
import * as echarts from 'echarts'
import { generateLast30Days } from '@/api/mock-data'

const props = withDefaults(defineProps<{
  height?: number
}>(), { height: 280 })

const chartRef = ref<HTMLElement>()
let chart: echarts.ECharts | null = null

function initChart() {
  if (!chartRef.value) return
  if (!chart) chart = echarts.init(chartRef.value)

  const days = generateLast30Days()
  const diffData = days.map(() => Math.round((Math.random() - 0.4) * 100) / 10)

  chart.setOption({
    tooltip: { trigger: 'axis' },
    grid: { left: 60, right: 20, top: 20, bottom: 40 },
    xAxis: { type: 'category', data: days },
    yAxis: { type: 'value', name: '价差(元)' },
    series: [{
      type: 'bar',
      data: diffData,
      itemStyle: {
        color: (params: any) => params.value >= 0 ? '#52c41a' : '#ff4d4f',
      },
    }],
  })
}

function handleResize() { chart?.resize() }

onMounted(() => { initChart(); window.addEventListener('resize', handleResize) })
onUnmounted(() => { chart?.dispose(); chart = null; window.removeEventListener('resize', handleResize) })
</script>
