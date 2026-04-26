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
import { ref, onMounted } from 'vue'
import { getDefinitions } from '@/api/request'
import { MOCK_INDICATOR_OPTIONS } from '@/api/mock-data'

interface OptionItem { code: string; name: string }

defineProps<{
  modelValue?: string
  placeholder?: string
}>()

const emit = defineEmits<{
  'update:modelValue': [value: string]
  change: [code: string, name: string]
}>()

const loading = ref(false)
const allList = ref<OptionItem[]>([])
const filteredList = ref<OptionItem[]>([])

async function loadOptions() {
  loading.value = true
  try {
    const res = await getDefinitions({ pageSize: 500 })
    allList.value = res.list.map((d: any) => ({ code: d.indicatorCode, name: d.indicatorName }))
    filteredList.value = allList.value.slice(0, 50)
  } catch {
    allList.value = MOCK_INDICATOR_OPTIONS
    filteredList.value = MOCK_INDICATOR_OPTIONS
  } finally {
    loading.value = false
  }
}

function handleSearch(query: string) {
  if (!query) { filteredList.value = allList.value.slice(0, 50); return }
  const q = query.toLowerCase()
  filteredList.value = allList.value
    .filter((item) => item.code.toLowerCase().includes(q) || item.name.includes(q))
    .slice(0, 50)
}

function handleChange(code: string) {
  const indicator = allList.value.find((i) => i.code === code)
  if (indicator) emit('change', code, indicator.name)
}

onMounted(() => { loadOptions() })
</script>
