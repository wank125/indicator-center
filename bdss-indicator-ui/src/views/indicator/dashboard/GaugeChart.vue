<template>
  <div ref="chartRef" :style="{ height: height + 'px' }"></div>
</template>

<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue'
import * as echarts from 'echarts'

const props = withDefaults(defineProps<{
  height?: number
  value?: number
  max?: number
  label?: string
}>(), {
  height: 200,
  value: 4521,
  max: 6000,
  label: '小时',
})

const chartRef = ref<HTMLElement>()
let chart: echarts.ECharts | null = null

function initChart() {
  if (!chartRef.value) return
  if (!chart) chart = echarts.init(chartRef.value)

  chart.setOption({
    series: [{
      type: 'gauge',
      startAngle: 200,
      endAngle: -20,
      min: 0,
      max: props.max,
      detail: { formatter: '{value}', fontSize: 20, offsetCenter: [0, '60%'] },
      data: [{ value: props.value, name: props.label }],
      axisLine: {
        lineStyle: {
          width: 20,
          color: [
            [0.4, '#ff4d4f'],
            [0.7, '#faad14'],
            [1, '#52c41a'],
          ],
        },
      },
      pointer: { width: 5 },
      axisTick: { length: 8 },
      splitLine: { length: 15 },
      axisLabel: { fontSize: 10 },
      title: { offsetCenter: [0, '80%'], fontSize: 12 },
    }],
  })
}

function handleResize() { chart?.resize() }

onMounted(() => { initChart(); window.addEventListener('resize', handleResize) })
onUnmounted(() => { chart?.dispose(); chart = null; window.removeEventListener('resize', handleResize) })
</script>
