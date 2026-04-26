<template>
  <div>
    <div class="section-title">明细数据</div>
    <el-table :data="data" size="small" stripe max-height="400" show-summary :summary-method="getSummary">
      <el-table-column prop="date" label="日期" width="120" />
      <el-table-column prop="timePoint" label="时间点" width="80">
        <template #default="{ row }">{{ row.timePoint != null ? `${String(row.timePoint).padStart(2, '0')}:00` : '--' }}</template>
      </el-table-column>
      <el-table-column prop="value" label="数值" align="right" sortable>
        <template #default="{ row }">{{ formatValue(row.value) }}</template>
      </el-table-column>
      <el-table-column prop="month" label="月份" width="100">
        <template #default="{ row }">{{ row.month ?? '--' }}</template>
      </el-table-column>
      <el-table-column prop="yearCumulative" label="年累计" align="right" width="120">
        <template #default="{ row }">{{ formatValue(row.yearCumulative) }}</template>
      </el-table-column>
      <el-table-column v-if="showMom" label="环比" align="right" width="100">
        <template #default="{ row }">{{ calcMom(row) }}</template>
      </el-table-column>
    </el-table>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'

const props = defineProps<{
  data: Array<Record<string, any>>
}>()

const showMom = computed(() => props.data.length > 1 && props.data.every((d) => d.value != null))

function formatValue(v: number | null | undefined): string {
  if (v == null) return '--'
  if (Math.abs(v) >= 10000) return v.toLocaleString('zh-CN', { maximumFractionDigits: 2 })
  if (Number.isInteger(v)) return v.toLocaleString('zh-CN')
  return v.toLocaleString('zh-CN', { minimumFractionDigits: 2, maximumFractionDigits: 4 })
}

function calcMom(row: Record<string, any>, index?: number): string {
  const idx = index ?? props.data.indexOf(row)
  if (idx <= 0) return '--'
  const prev = props.data[idx - 1]?.value
  const cur = row.value
  if (prev == null || cur == null || prev === 0) return '--'
  const rate = ((cur - prev) / Math.abs(prev)) * 100
  const cls = rate >= 0 ? '+' : ''
  return `${cls}${rate.toFixed(1)}%`
}

function getSummary({ data, columns }: any) {
  const sums: string[] = []
  columns.forEach((col: any, i: number) => {
    if (i === 0) { sums.push('合计'); return }
    if (col.property === 'value' || col.property === 'yearCumulative') {
      const vals = data.map((d: any) => d[col.property]).filter((v: any) => v != null) as number[]
      sums.push(vals.length ? formatValue(vals.reduce((a: number, b: number) => a + b, 0)) : '--')
    } else {
      sums.push('')
    }
  })
  return sums
}
</script>
