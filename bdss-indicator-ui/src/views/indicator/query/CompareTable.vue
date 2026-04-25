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
        <template #default="{ row }">{{ row.value ?? '--' }}</template>
      </el-table-column>
      <el-table-column prop="compareValue" label="对比值" align="right">
        <template #default="{ row }">{{ row.compareValue ?? '--' }}</template>
      </el-table-column>
      <el-table-column prop="changeRate" label="变化率" align="right" width="120">
        <template #default="{ row }">
          <span v-if="row.changeRate !== null" :class="row.changeRate >= 0 ? 'text-success' : 'text-error'">
            {{ row.changeRate >= 0 ? '+' : '' }}{{ row.changeRate?.toFixed(1) }}%
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
</script>

<style scoped lang="scss">
.compare-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 12px;
}
</style>
