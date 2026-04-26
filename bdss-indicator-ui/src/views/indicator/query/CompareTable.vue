<template>
  <div>
    <div class="compare-header">
      <span class="section-title">同环比对比</span>
      <el-radio-group :model-value="compareType" size="small" @update:model-value="$emit('update:compareType', $event)">
        <el-radio-button value="yoy">同比</el-radio-button>
        <el-radio-button value="mom">环比</el-radio-button>
      </el-radio-group>
    </div>
    <el-table :data="data" size="small" stripe v-if="data.length">
      <el-table-column prop="period" label="期间" width="120" />
      <el-table-column prop="value" label="当前值" align="right">
        <template #default="{ row }">{{ fmt(row.value) }}</template>
      </el-table-column>
      <el-table-column prop="compareValue" label="对比值" align="right">
        <template #default="{ row }">{{ fmt(row.compareValue) }}</template>
      </el-table-column>
      <el-table-column label="差值" align="right" width="110">
        <template #default="{ row }">
          <span v-if="row.value != null && row.compareValue != null"
            :class="row.value - row.compareValue >= 0 ? 'text-success' : 'text-error'">
            {{ row.value - row.compareValue >= 0 ? '+' : '' }}{{ fmt(row.value - row.compareValue) }}
          </span>
          <span v-else>--</span>
        </template>
      </el-table-column>
      <el-table-column prop="changeRate" label="变化率" align="right" width="130">
        <template #default="{ row }">
          <span v-if="row.changeRate !== null" class="rate-cell" :class="rateClass(row.changeRate)">
            <span class="rate-arrow">{{ row.changeRate >= 0 ? '↑' : '↓' }}</span>
            {{ row.changeRate >= 0 ? '+' : '' }}{{ row.changeRate?.toFixed(2) }}%
          </span>
          <span v-else>--</span>
        </template>
      </el-table-column>
    </el-table>
    <el-empty v-else description="选择指标后查询" :image-size="60" />
  </div>
</template>

<script setup lang="ts">
import type { CompareData } from '@/types/indicator'

defineProps<{
  data: CompareData[]
  compareType: 'yoy' | 'mom'
}>()

defineEmits<{
  'update:compareType': [value: 'yoy' | 'mom']
}>()

function fmt(v: number | null | undefined): string {
  if (v == null) return '--'
  if (Math.abs(v) >= 10000) return v.toLocaleString('zh-CN', { maximumFractionDigits: 2 })
  return v.toLocaleString('zh-CN', { minimumFractionDigits: 2, maximumFractionDigits: 4 })
}

function rateClass(rate: number): string {
  return rate >= 0 ? 'text-success' : 'text-error'
}
</script>

<style scoped lang="scss">
.compare-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 12px;
}
.rate-cell {
  display: inline-flex;
  align-items: center;
  gap: 2px;
  font-weight: 500;
}
.rate-arrow {
  font-size: 14px;
}
</style>
