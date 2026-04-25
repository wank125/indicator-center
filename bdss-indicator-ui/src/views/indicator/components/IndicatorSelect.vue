<template>
  <el-select
    :model-value="modelValue"
    placeholder="搜索指标编码/名称"
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

defineProps<{
  modelValue?: string
}>()

const emit = defineEmits<{
  'update:modelValue': [value: string]
  change: [code: string, name: string]
}>()

const loading = ref(false)

const allIndicators = [
  { code: 'MLT_CONTRACT_ENERGY', name: '合约电量', category: '电量' },
  { code: 'DAM_CLEARING_ENERGY', name: '日前出清电量', category: '电量' },
  { code: 'DAM_CLEARING_PRICE', name: '日前出清电价', category: '电价' },
  { code: 'RTM_CLEARING_ENERGY', name: '实时出清电量', category: '电量' },
  { code: 'RTM_CLEARING_PRICE', name: '实时出清电价', category: '电价' },
  { code: 'TOTAL_ONLINE_ENERGY', name: '上网电量', category: '电量' },
  { code: 'SPOT_FULL_FEE', name: '现货全量电费', category: '电费' },
  { code: 'TOTAL_AVG_PRICE', name: '度电价格', category: '电价' },
  { code: 'TOTAL_MARGIN', name: '总边际贡献', category: '边际贡献' },
  { code: 'DAM_DEV_ENERGY', name: '日前偏差电量', category: '偏差' },
  { code: 'DAM_DEV_POS_ENERGY', name: '日前正偏差电量', category: '偏差' },
  { code: 'DAM_DEV_NEG_ENERGY', name: '日前负偏差电量', category: '偏差' },
  { code: 'CONTRACT_COVERAGE', name: '合约覆盖率', category: '覆盖率' },
  { code: 'LOAD_RATE', name: '负荷率', category: '负荷率' },
  { code: 'PER_UNIT_REVENUE', name: '度电收益', category: '经营效率' },
]

const filteredList = ref(allIndicators)

function handleSearch(query: string) {
  if (!query) {
    filteredList.value = allIndicators
    return
  }
  const q = query.toLowerCase()
  filteredList.value = allIndicators.filter(
    (item) => item.code.toLowerCase().includes(q) || item.name.includes(q),
  )
}

function handleChange(code: string) {
  const indicator = allIndicators.find((i) => i.code === code)
  if (indicator) {
    emit('change', code, indicator.name)
  }
}
</script>
