<template>
  <div class="page-container monitor-page">
    <!-- 概览卡片 -->
    <CalcStatusCards :data="overview" />

    <!-- 操作栏 -->
    <div class="card-section">
      <el-row :gutter="12" align="middle" justify="space-between">
        <el-col :span="16">
          <el-row :gutter="12">
            <el-col :span="6">
              <el-date-picker v-model="filterDate" type="date" placeholder="交易日期" value-format="YYYY-MM-DD" clearable />
            </el-col>
            <el-col :span="5">
              <el-select v-model="filterStatus" placeholder="状态" clearable>
                <el-option label="成功" value="SUCCESS" /><el-option label="失败" value="FAILED" />
                <el-option label="运行中" value="RUNNING" /><el-option label="待执行" value="PENDING" />
              </el-select>
            </el-col>
            <el-col :span="5">
              <el-select v-model="filterLayer" placeholder="计算层级" clearable>
                <el-option label="L0" :value="0" /><el-option label="L1" :value="1" />
                <el-option label="L2" :value="2" /><el-option label="L3" :value="3" />
              </el-select>
            </el-col>
            <el-col :span="4"><el-button type="primary" @click="loadLogs">查询</el-button></el-col>
          </el-row>
        </el-col>
        <el-col :span="4" style="text-align: right">
          <el-button type="success" @click="handleTriggerCalc"><el-icon><VideoPlay /></el-icon>触发计算</el-button>
        </el-col>
      </el-row>
    </div>

    <!-- 任务日志列表 -->
    <div class="card-section">
      <div class="section-title">计算任务日志</div>
      <el-table :data="taskLogs" stripe size="small">
        <el-table-column prop="id" label="任务ID" width="80" />
        <el-table-column prop="tradeDate" label="交易日期" width="120" />
        <el-table-column prop="totalCount" label="总指标" width="80" align="center" />
        <el-table-column prop="successCount" label="成功" width="80" align="center">
          <template #default="{ row }"><span class="text-success">{{ row.successCount }}</span></template>
        </el-table-column>
        <el-table-column prop="failCount" label="失败" width="80" align="center">
          <template #default="{ row }"><span class="text-error">{{ row.failCount }}</span></template>
        </el-table-column>
        <el-table-column prop="skipCount" label="跳过" width="80" align="center">
          <template #default="{ row }"><span class="text-warning">{{ row.skipCount }}</span></template>
        </el-table-column>
        <el-table-column prop="duration" label="耗时(ms)" width="100" align="right">
          <template #default="{ row }">{{ row.duration }}ms</template>
        </el-table-column>
        <el-table-column prop="status" label="状态" width="100" align="center">
          <template #default="{ row }"><el-tag :type="statusTagType(row.status)" size="small">{{ row.status }}</el-tag></template>
        </el-table-column>
        <el-table-column prop="createTime" label="创建时间" width="170" />
        <el-table-column label="操作" width="120" fixed="right">
          <template #default="{ row }">
            <el-button link type="primary" size="small" @click="viewDetail">明细</el-button>
            <el-button link type="warning" size="small" @click="retryTask(row)">重试</el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>

    <!-- 计算明细弹窗（独立组件） -->
    <CalcDetailTable v-model="detailVisible" :details="MOCK_CALC_DETAILS" />
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { VideoPlay } from '@element-plus/icons-vue'
import { triggerCalc, getCalcLog } from '@/api/request'
import { MOCK_CALC_TASKS, MOCK_CALC_DETAILS } from '@/api/mock-data'
import CalcStatusCards from './CalcStatusCards.vue'
import CalcDetailTable from './CalcDetailTable.vue'
import type { CalcTaskLog } from '@/types/indicator'
import { ElMessage } from 'element-plus'

const filterDate = ref('')
const filterStatus = ref('')
const filterLayer = ref<number | string>('')
const taskLogs = ref<CalcTaskLog[]>([...MOCK_CALC_TASKS])
const detailVisible = ref(false)

const overview = ref({ totalCount: 90, successCount: 85, failCount: 3, skipCount: 2 })

function statusTagType(status: string) {
  switch (status) {
    case 'SUCCESS': return 'success'
    case 'FAILED': return 'danger'
    case 'RUNNING': return 'warning'
    default: return 'info'
  }
}

async function loadLogs() {
  try {
    const res = await getCalcLog({
      tradeDate: filterDate.value || undefined,
      status: filterStatus.value || undefined,
      calcLayer: filterLayer.value || undefined,
    })
    taskLogs.value = res.list
  } catch { taskLogs.value = MOCK_CALC_TASKS }
  updateOverview()
}

function updateOverview() {
  const today = taskLogs.value[0]
  if (today) overview.value = { totalCount: today.totalCount, successCount: today.successCount, failCount: today.failCount, skipCount: today.skipCount }
}

async function handleTriggerCalc() {
  if (!filterDate.value) { ElMessage.warning('请选择交易日期'); return }
  try { await triggerCalc({ tradeDate: filterDate.value }) } catch { /* mock */ }
  ElMessage.success('计算任务已触发')
  loadLogs()
}

function viewDetail() { detailVisible.value = true }
function retryTask(row: CalcTaskLog) { ElMessage.info(`重试任务 #${row.id} (Mock)`) }

function toLocalDate(d: Date): string {
  return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, '0')}-${String(d.getDate()).padStart(2, '0')}`
}

onMounted(() => { filterDate.value = toLocalDate(new Date()); updateOverview() })
</script>

<style scoped lang="scss">
.monitor-page {
  .overview-row { margin-bottom: var(--spacing-component); }
}
</style>
