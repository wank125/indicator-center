<template>
  <el-row :gutter="12">
    <el-col :span="6">
      <div class="status-card" style="border-left-color: var(--color-primary)">
        <div class="sc-label">今日任务</div>
        <div class="sc-value">{{ data.totalCount }}</div>
      </div>
    </el-col>
    <el-col :span="6">
      <div class="status-card" style="border-left-color: var(--color-success)">
        <div class="sc-label">计算成功</div>
        <div class="sc-value text-success">{{ data.successCount }}</div>
      </div>
    </el-col>
    <el-col :span="6">
      <div class="status-card" style="border-left-color: var(--color-error)">
        <div class="sc-label">计算失败</div>
        <div class="sc-value text-error">{{ data.failCount }}</div>
      </div>
    </el-col>
    <el-col :span="6">
      <div class="status-card" style="border-left-color: var(--color-warning)">
        <div class="sc-label">跳过</div>
        <div class="sc-value text-warning">{{ data.skipCount }}</div>
      </div>
    </el-col>
  </el-row>
</template>

<script setup lang="ts">
defineProps<{
  data: {
    totalCount: number
    successCount: number
    failCount: number
    skipCount: number
  }
}>()
</script>

<style scoped lang="scss">
.status-card {
  background: var(--color-card);
  border-radius: var(--radius-card);
  padding: 16px 20px;
  text-align: center;
  border-left: 4px solid var(--color-primary);
}

.sc-label {
  font-size: var(--font-aux);
  color: #999;
  margin-bottom: 8px;
}

.sc-value {
  font-size: 28px;
  font-weight: 700;
  color: #333;
}
</style>
