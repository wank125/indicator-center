<template>
  <el-select
    :model-value="modelValue"
    placeholder="选择省网"
    clearable
    style="width: 160px"
    @update:model-value="$emit('update:modelValue', $event)"
    @change="$emit('change', $event)"
  >
    <el-option
      v-for="item in provinceList"
      :key="item.tenantId"
      :label="item.label"
      :value="item.tenantId"
    />
  </el-select>
</template>

<script setup lang="ts">
defineProps<{
  modelValue?: number | string
}>()

defineEmits<{
  'update:modelValue': [value: number | string]
  change: [value: number | string]
}>()

const provinceList = [
  { tenantId: 1, label: '山西' },
  { tenantId: 2, label: '河南' },
  { tenantId: 3, label: '湖北' },
  { tenantId: 4, label: '蒙西' },
  { tenantId: 5, label: '蒙东' },
  { tenantId: 6, label: '宁夏' },
  { tenantId: 7, label: '甘肃' },
  { tenantId: 8, label: '陕西' },
  { tenantId: 9, label: '云南' },
  { tenantId: 10, label: '广西' },
]
</script>
