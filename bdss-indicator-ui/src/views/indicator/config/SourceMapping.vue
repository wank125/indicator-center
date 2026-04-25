<template>
  <div class="page-container config-page">
    <div class="card-section">
      <div class="section-title" style="margin-bottom: 16px">
        数据源映射
        <el-button type="primary" size="small" @click="showAddDialog">
          <el-icon><Plus /></el-icon>新增映射
        </el-button>
      </div>
      <el-table :data="sourceList" stripe size="small" max-height="calc(100vh - 220px)">
        <el-table-column prop="sourceName" label="数据源名称" width="140" />
        <el-table-column prop="sourceDb" label="源库" width="180" show-overflow-tooltip />
        <el-table-column prop="sourceTable" label="源表" width="200" show-overflow-tooltip />
        <el-table-column prop="indicatorCode" label="指标编码" width="200" show-overflow-tooltip />
        <el-table-column prop="fieldName" label="字段名" width="120" />
        <el-table-column prop="extractType" label="抽取方式" width="100" align="center">
          <template #default="{ row }">
            <el-tag size="small">{{ row.extractType }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="schedule" label="调度频率" width="100" align="center" />
        <el-table-column prop="status" label="状态" width="80" align="center">
          <template #default="{ row }">
            <el-tag :type="row.status ? 'success' : 'danger'" size="small">
              {{ row.status ? '启用' : '停用' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="140" fixed="right">
          <template #default="{ row }">
            <el-button link type="primary" size="small" @click="handleEdit(row)">编辑</el-button>
            <el-button link type="primary" size="small" @click="handleTest(row)">测试</el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>

    <el-dialog v-model="dialogVisible" :title="editId ? '编辑映射' : '新增映射'" width="650px" destroy-on-close>
      <el-form :model="formData" label-width="100px" size="default">
        <el-row :gutter="16">
          <el-col :span="12">
            <el-form-item label="数据源名称" required>
              <el-input v-model="formData.sourceName" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="指标编码" required>
              <el-input v-model="formData.indicatorCode" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="源库" required>
              <el-input v-model="formData.sourceDb" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="源表" required>
              <el-input v-model="formData.sourceTable" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="字段名" required>
              <el-input v-model="formData.fieldName" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="抽取方式">
              <el-select v-model="formData.extractType" style="width: 100%">
                <el-option label="直连" value="DIRECT" />
                <el-option label="API" value="API" />
                <el-option label="文件" value="FILE" />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="调度频率">
              <el-select v-model="formData.schedule" style="width: 100%">
                <el-option label="每日" value="DAILY" />
                <el-option label="每小时" value="HOURLY" />
                <el-option label="实时" value="REALTIME" />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="状态">
              <el-switch v-model="formData.status" :active-value="1" :inactive-value="0" active-text="启用" inactive-text="停用" />
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="handleSave">保存</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { Plus } from '@element-plus/icons-vue'
import { ElMessage } from 'element-plus'
import { MOCK_SOURCE_MAPPINGS } from '@/api/mock-data'

interface SourceMapping {
  id: number
  sourceName: string
  sourceDb: string
  sourceTable: string
  indicatorCode: string
  fieldName: string
  extractType: string
  schedule: string
  status: number
}

const sourceList = ref<SourceMapping[]>([...MOCK_SOURCE_MAPPINGS])
const dialogVisible = ref(false)
const editId = ref<number | null>(null)
const formData = ref<Partial<SourceMapping>>({
  extractType: 'DIRECT', schedule: 'DAILY', status: 1,
})

function showAddDialog() {
  editId.value = null
  formData.value = { extractType: 'DIRECT', schedule: 'DAILY', status: 1 }
  dialogVisible.value = true
}

function handleEdit(row: SourceMapping) {
  editId.value = row.id
  formData.value = { ...row }
  dialogVisible.value = true
}

function handleSave() {
  dialogVisible.value = false
  ElMessage.success('保存成功')
}

function handleTest(row: SourceMapping) {
  ElMessage.info(`测试连接: ${row.sourceDb}.${row.sourceTable}`)
}
</script>

<style scoped lang="scss">
.config-page {
  .section-title {
    display: flex;
    align-items: center;
    justify-content: space-between;
  }
}
</style>
