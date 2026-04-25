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

const provinceList = [
  { value: 'shanxi', label: '山西' },
  { value: 'henan', label: '河南' },
  { value: 'hubei', label: '湖北' },
  { value: 'mengxi', label: '蒙西' },
  { value: 'mengdong', label: '蒙东' },
  { value: 'ningxia', label: '宁夏' },
  { value: 'gansu', label: '甘肃' },
  { value: 'shaanxi', label: '陕西' },
  { value: 'yunnan', label: '云南' },
  { value: 'guangxi', label: '广西' },
]
</script>
