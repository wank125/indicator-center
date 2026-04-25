<template>
  <div>
    <div class="section-title">明细数据</div>
    <el-table :data="data" size="small" stripe max-height="400">
      <el-table-column prop="date" label="日期" width="140" />
      <el-table-column prop="timePoint" label="时间点" width="100">
        <template #default="{ row }">{{ row.timePoint != null ? row.timePoint : '--' }}</template>
      </el-table-column>
      <el-table-column prop="value" label="数值" align="right">
        <template #default="{ row }">{{ row.value ?? '--' }}</template>
      </el-table-column>
    </el-table>
  </div>
</template>

<script setup lang="ts">
defineProps<{
  data: Array<{ date: string; timePoint?: number | null; value: number | null }>
}>()
</script>
