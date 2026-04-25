<template>
  <el-dialog v-model="visible" title="计算明细" width="900px" destroy-on-close>
    <template v-if="details.length">
      <el-table :data="details" stripe size="small" max-height="400">
        <el-table-column prop="indicatorCode" label="指标编码" width="200" show-overflow-tooltip />
        <el-table-column prop="indicatorName" label="指标名称" width="140" />
        <el-table-column prop="calcLayer" label="层级" width="60" align="center">
          <template #default="{ row }">L{{ row.calcLayer }}</template>
        </el-table-column>
        <el-table-column prop="status" label="状态" width="80" align="center">
          <template #default="{ row }">
            <el-tag :type="statusTagType(row.status)" size="small">{{ row.status }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="affectedRows" label="影响行数" width="90" align="right" />
        <el-table-column prop="duration" label="耗时(ms)" width="90" align="right" />
        <el-table-column prop="errorMsg" label="错误信息" show-overflow-tooltip>
          <template #default="{ row }">
            <span v-if="row.errorMsg" class="text-error">{{ row.errorMsg }}</span>
            <span v-else>--</span>
          </template>
        </el-table-column>
      </el-table>

      <!-- 汇总统计 -->
      <div class="detail-summary">
        <el-descriptions :column="4" size="small" border>
          <el-descriptions-item label="总计">{{ details.length }} 个指标</el-descriptions-item>
          <el-descriptions-item label="成功">
            <span class="text-success">{{ details.filter((d) => d.status === 'SUCCESS').length }}</span>
          </el-descriptions-item>
          <el-descriptions-item label="失败">
            <span class="text-error">{{ details.filter((d) => d.status === 'FAILED').length }}</span>
          </el-descriptions-item>
          <el-descriptions-item label="总耗时">
            {{ details.reduce((sum, d) => sum + d.duration, 0) }}ms
          </el-descriptions-item>
        </el-descriptions>
      </div>
    </template>
    <el-empty v-else description="暂无明细数据" :image-size="60" />
  </el-dialog>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import type { CalcDetailLog } from '@/types/indicator'

const props = defineProps<{
  modelValue: boolean
  details: CalcDetailLog[]
}>()

const emit = defineEmits<{ 'update:modelValue': [v: boolean] }>()

const visible = computed({
  get: () => props.modelValue,
  set: (v) => emit('update:modelValue', v),
})

function statusTagType(status: string) {
  switch (status) {
    case 'SUCCESS': return 'success'
    case 'FAILED': return 'danger'
    case 'RUNNING': return 'warning'
    default: return 'info'
  }
}
</script>

<style scoped lang="scss">
.detail-summary {
  margin-top: 16px;
}
</style>
