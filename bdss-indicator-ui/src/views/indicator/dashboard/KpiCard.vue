<template>
  <div class="kpi-card">
    <div class="kpi-label">{{ label }}</div>
    <div class="kpi-value-row">
      <span class="kpi-value">{{ formattedValue }}</span>
      <span class="kpi-unit">{{ unit }}</span>
    </div>
    <div v-if="changeRate !== null && changeRate !== undefined" class="kpi-change" :class="changeClass">
      <el-icon v-if="changeDirection === 'up'"><Top /></el-icon>
      <el-icon v-else-if="changeDirection === 'down'"><Bottom /></el-icon>
      <span>{{ changeText }}</span>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { Top, Bottom } from '@element-plus/icons-vue'

const props = defineProps<{
  label: string
  value: number | null
  unit: string
  changeRate?: number | null
  changeType?: 'yoy' | 'mom'
  changeDirection?: 'up' | 'down' | 'flat'
}>()

const formattedValue = computed(() => {
  if (props.value === null || props.value === undefined) return '--'
  const v = props.value
  if (props.unit === '%') return v.toFixed(1)
  if (props.unit === '元/MWh') return v.toFixed(2)
  if (props.unit === '元') return v.toLocaleString('zh-CN', { maximumFractionDigits: 0 })
  if (props.unit === 'MWh') return v.toLocaleString('zh-CN', { maximumFractionDigits: 1 })
  if (props.unit === '小时') return v.toLocaleString('zh-CN', { maximumFractionDigits: 1 })
  return v.toLocaleString('zh-CN')
})

const changeClass = computed(() => {
  if (props.changeDirection === 'up') return 'change-up'
  if (props.changeDirection === 'down') return 'change-down'
  return 'change-flat'
})

const changeText = computed(() => {
  if (props.changeRate === null || props.changeRate === undefined) return ''
  const prefix = props.changeType === 'yoy' ? '同比' : '环比'
  const abs = Math.abs(props.changeRate).toFixed(1)
  if (props.changeDirection === 'up') return `${prefix} ↑${abs}%`
  if (props.changeDirection === 'down') return `${prefix} ↓${abs}%`
  return `${prefix} ${abs}%`
})
</script>

<style scoped lang="scss">
.kpi-card {
  background: var(--color-card);
  border-radius: var(--radius-card);
  padding: 16px 20px;
  display: flex;
  flex-direction: column;
  gap: 8px;
  border: 1px solid var(--color-border);
  transition: box-shadow 0.2s;

  &:hover {
    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
  }
}

.kpi-label {
  font-size: var(--font-aux);
  color: #999;
}

.kpi-value-row {
  display: flex;
  align-items: baseline;
  gap: 4px;
}

.kpi-value {
  font-size: var(--font-kpi);
  font-weight: 700;
  color: #333;
  line-height: 1.2;
}

.kpi-unit {
  font-size: var(--font-aux);
  color: #999;
}

.kpi-change {
  font-size: var(--font-aux);
  display: flex;
  align-items: center;
  gap: 2px;
}

.change-up {
  color: var(--color-success);
}

.change-down {
  color: var(--color-error);
}

.change-flat {
  color: #999;
}
</style>
