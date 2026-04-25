<template>
  <el-table :data="data" size="small" stripe>
    <el-table-column prop="name" label="指标" width="160" />
    <el-table-column prop="today" label="今日" align="right">
      <template #default="{ row }">
        <span :class="row.todayColor">{{ row.today }}</span>
      </template>
    </el-table-column>
    <el-table-column prop="yesterday" label="昨日" align="right" />
    <el-table-column prop="changeRate" label="变化率" align="right">
      <template #default="{ row }">
        <span :class="row.changeColor">{{ row.changeRate }}</span>
      </template>
    </el-table-column>
  </el-table>
</template>

<script setup lang="ts">
import { MOCK_DEVIATION_DATA } from '@/api/mock-data'

withDefaults(defineProps<{
  data?: Array<{
    name: string
    today: string
    yesterday: string
    changeRate: string
    todayColor: string
    changeColor: string
  }>
}>(), {
  data: () => MOCK_DEVIATION_DATA,
})
</script>
