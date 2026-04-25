<template>
  <div class="query-toolbar card-section">
    <el-row :gutter="12" align="middle">
      <el-col :span="8">
        <IndicatorSelect
          :model-value="indicatorCode"
          :placeholder="indicatorPlaceholder || '选择或搜索指标'"
          @update:model-value="$emit('update:indicatorCode', $event)"
        />
      </el-col>
      <el-col :span="8">
        <DateRangePicker
          :model-value="dateRange"
          @update:model-value="$emit('update:dateRange', $event)"
          @change="$emit('dateChange', $event)"
        />
      </el-col>
      <el-col :span="3">
        <GrainSwitch
          :model-value="grain"
          @update:model-value="$emit('update:grain', $event)"
        />
      </el-col>
      <el-col :span="5" class="toolbar-actions">
        <el-button type="primary" :loading="loading" @click="$emit('query')">查询</el-button>
        <el-button @click="$emit('export')">导出</el-button>
        <el-button size="small" @click="$emit('multiQuery')">多指标</el-button>
      </el-col>
    </el-row>
  </div>
</template>

<script setup lang="ts">
import IndicatorSelect from '../components/IndicatorSelect.vue'
import DateRangePicker from '../components/DateRangePicker.vue'
import GrainSwitch from '../components/GrainSwitch.vue'
import type { GrainType } from '@/types/indicator'

defineProps<{
  indicatorCode?: string | null
  dateRange: string[]
  grain: GrainType
  loading?: boolean
  indicatorPlaceholder?: string
}>()

defineEmits<{
  'update:indicatorCode': [value: string | null]
  'update:dateRange': [value: string[]]
  'update:grain': [value: GrainType]
  query: []
  export: []
  multiQuery: []
  dateChange: [range: string[]]
}>()
</script>

<style scoped lang="scss">
.toolbar-actions {
  display: flex;
  gap: 8px;
  justify-content: flex-end;
}
</style>
