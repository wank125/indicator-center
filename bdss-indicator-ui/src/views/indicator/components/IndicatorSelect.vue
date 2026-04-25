<template>
  <el-select
    :model-value="modelValue"
    :placeholder="placeholder"
    clearable
    filterable
    remote
    :remote-method="handleSearch"
    :loading="loading"
    value-key="code"
    style="width: 240px"
    @update:model-value="$emit('update:modelValue', $event)"
    @change="handleChange"
  >
    <el-option
      v-for="item in filteredList"
      :key="item.code"
      :label="`${item.code} - ${item.name}`"
      :value="item.code"
    />
  </el-select>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { MOCK_INDICATOR_OPTIONS } from '@/api/mock-data'

defineProps<{
  modelValue?: string
  placeholder?: string
}>()

const emit = defineEmits<{
  'update:modelValue': [value: string]
  change: [code: string, name: string]
}>()

const loading = ref(false)
const filteredList = ref(MOCK_INDICATOR_OPTIONS)

function handleSearch(query: string) {
  if (!query) { filteredList.value = MOCK_INDICATOR_OPTIONS; return }
  const q = query.toLowerCase()
  filteredList.value = MOCK_INDICATOR_OPTIONS.filter(
    (item) => item.code.toLowerCase().includes(q) || item.name.includes(q),
  )
}

function handleChange(code: string) {
  const indicator = MOCK_INDICATOR_OPTIONS.find((i) => i.code === code)
  if (indicator) emit('change', code, indicator.name)
}
</script>
