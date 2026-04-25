<template>
  <div ref="chartRef" :style="{ height: height + 'px' }"></div>
</template>

<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue'
import * as echarts from 'echarts'

const props = withDefaults(defineProps<{
  height?: number
  names?: string[]
  values?: number[]
}>(), {
  height: 240,
  names: () => ['电厂A', '电厂B', '电厂C', '电厂D', '电厂E', '电厂F', '电厂G', '电厂H', '电厂I', '电厂J'],
  values: () => [35, 42, 48, 55, 61, 65, 68, 72, 76, 89],
})

const chartRef = ref<HTMLElement>()
let chart: echarts.ECharts | null = null

function initChart() {
  if (!chartRef.value) return
  if (!chart) chart = echarts.init(chartRef.value)

  chart.setOption({
    tooltip: { trigger: 'axis' },
    grid: { left: 80, right: 30, top: 10, bottom: 20 },
    xAxis: { type: 'value', name: '万元' },
    yAxis: { type: 'category', data: props.names },
    series: [{
      type: 'bar',
      data: props.values,
      itemStyle: {
        color: new echarts.graphic.LinearGradient(0, 0, 1, 0, [
          { offset: 0, color: '#1890ff' },
          { offset: 1, color: '#36cfc9' },
        ]),
      },
      barWidth: 16,
    }],
  })
}

function handleResize() { chart?.resize() }

onMounted(() => { initChart(); window.addEventListener('resize', handleResize) })
onUnmounted(() => { chart?.dispose(); chart = null; window.removeEventListener('resize', handleResize) })
</script>
