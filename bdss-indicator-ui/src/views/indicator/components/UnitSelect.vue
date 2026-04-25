<template>
  <el-select
    :model-value="modelValue"
    placeholder="选择机组"
    clearable
    filterable
    style="width: 200px"
    @update:model-value="$emit('update:modelValue', $event)"
    @change="$emit('change', $event)"
  >
    <el-option label="全部机组" value="ALL" />
    <el-option
      v-for="item in unitList"
      :key="item.value"
      :label="item.label"
      :value="item.value"
    />
  </el-select>
</template>

<script setup lang="ts">
defineProps<{
  modelValue?: string
}>()

defineEmits<{
  'update:modelValue': [value: string]
  change: [value: string]
}>()

const unitList = [
  { value: 'SX-A01', label: '山西A厂1号机' },
  { value: 'SX-A02', label: '山西A厂2号机' },
  { value: 'SX-B01', label: '山西B厂1号机' },
  { value: 'HN-A01', label: '河南A厂1号机' },
  { value: 'HN-B01', label: '河南B厂1号机' },
  { value: 'HB-A01', label: '湖北A厂1号机' },
]
</script>
