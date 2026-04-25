<template>
  <el-date-picker
    :model-value="modelValue"
    type="daterange"
    range-separator="至"
    start-placeholder="开始日期"
    end-placeholder="结束日期"
    value-format="YYYY-MM-DD"
    :shortcuts="shortcuts"
    style="width: 260px"
    @update:model-value="$emit('update:modelValue', $event)"
    @change="$emit('change', $event)"
  />
</template>

<script setup lang="ts">

defineProps<{
  modelValue?: [string, string] | null
}>()

defineEmits<{
  'update:modelValue': [value: [string, string] | null]
  change: [value: [string, string] | null]
}>()

const shortcuts = [
  {
    text: '最近7天',
    value: () => {
      const end = new Date()
      const start = new Date()
      start.setDate(start.getDate() - 7)
      return [start, end]
    },
  },
  {
    text: '最近30天',
    value: () => {
      const end = new Date()
      const start = new Date()
      start.setDate(start.getDate() - 30)
      return [start, end]
    },
  },
  {
    text: '最近90天',
    value: () => {
      const end = new Date()
      const start = new Date()
      start.setDate(start.getDate() - 90)
      return [start, end]
    },
  },
]
</script>
