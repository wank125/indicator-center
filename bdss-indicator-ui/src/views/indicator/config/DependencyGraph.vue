<template>
  <div ref="chartRef" :style="{ height: height + 'px' }"></div>
</template>

<script setup lang="ts">
import { ref, watch, onMounted, onUnmounted } from 'vue'
import * as echarts from 'echarts'

interface DepNode {
  code: string
  name: string
  layer: number
}

const props = withDefaults(defineProps<{
  targetCode?: string
  targetName?: string
  deps: DepNode[]
  height?: number
}>(), { height: 260 })

const chartRef = ref<HTMLElement>()
let chart: echarts.ECharts | null = null

function renderGraph() {
  if (!chartRef.value) return
  if (!chart) chart = echarts.init(chartRef.value)

  const nodes: any[] = []
  const links: any[] = []
  const targetLabel = props.targetName || props.targetCode || 'TARGET'

  props.deps.forEach((d) => {
    nodes.push({
      name: d.code,
      symbolSize: 40,
      label: { show: true, formatter: d.name, fontSize: 10 },
      itemStyle: { color: '#1890ff' },
    })
    links.push({ source: d.code, target: props.targetCode || 'TARGET' })
  })

  if (props.targetCode) {
    nodes.push({
      name: props.targetCode,
      symbolSize: 50,
      label: { show: true, formatter: targetLabel, fontSize: 11 },
      itemStyle: { color: '#52c41a' },
    })
  } else {
    nodes.push({
      name: 'TARGET',
      symbolSize: 50,
      label: { show: true, formatter: '目标指标', fontSize: 11 },
      itemStyle: { color: '#52c41a' },
    })
  }

  chart.setOption({
    series: [{
      type: 'graph',
      layout: 'force',
      roam: true,
      draggable: true,
      force: { repulsion: 200, edgeLength: 100 },
      data: nodes,
      links,
      label: { show: true },
      edgeSymbol: ['none', 'arrow'],
    }],
  }, true)
}

function handleResize() { chart?.resize() }

watch(() => [props.deps, props.targetCode], renderGraph, { deep: true })
onMounted(() => { renderGraph(); window.addEventListener('resize', handleResize) })
onUnmounted(() => { chart?.dispose(); chart = null; window.removeEventListener('resize', handleResize) })
</script>
