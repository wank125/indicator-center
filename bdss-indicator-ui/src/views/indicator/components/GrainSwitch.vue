<template>
  <el-radio-group
    :model-value="modelValue"
    size="default"
    @update:model-value="$emit('update:modelValue', $event)"
    @change="$emit('change', $event)"
  >
    <el-radio-button value="timeseries">分时(96点)</el-radio-button>
    <el-radio-button value="daily">日</el-radio-button>
    <el-radio-button value="monthly">月</el-radio-button>
  </el-radio-group>
</template>

<script setup lang="ts">
import type { GrainType } from '@/types/indicator'

defineProps<{
  modelValue: GrainType
}>()

defineEmits<{
  'update:modelValue': [value: GrainType]
  change: [value: GrainType]
}>()
</script>
