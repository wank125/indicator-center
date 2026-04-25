<template>
  <div class="page-container config-page">
    <!-- 搜索栏 -->
    <div class="card-section">
      <el-row :gutter="12" align="middle">
        <el-col :span="6">
          <el-input v-model="searchKey" placeholder="编码/名称搜索" clearable @clear="loadData" @keyup.enter="loadData" />
        </el-col>
        <el-col :span="4">
          <el-select v-model="filterMarket" placeholder="市场类型" clearable @change="loadData">
            <el-option label="现货" value="SPOT" /><el-option label="中长期" value="MLT" /><el-option label="全部" value="" />
          </el-select>
        </el-col>
        <el-col :span="4">
          <el-select v-model="filterType" placeholder="指标类型" clearable @change="loadData">
            <el-option label="原始" :value="1" /><el-option label="计算" :value="2" /><el-option label="派生" :value="3" />
          </el-select>
        </el-col>
        <el-col :span="4">
          <el-select v-model="filterStatus" placeholder="覆盖状态" clearable @change="loadData">
            <el-option label="已覆盖" :value="1" /><el-option label="未覆盖" :value="0" />
          </el-select>
        </el-col>
        <el-col :span="6" style="text-align: right">
          <el-button type="primary" @click="showAddDialog"><el-icon><Plus /></el-icon>新增指标</el-button>
        </el-col>
      </el-row>
    </div>

    <!-- 指标列表 -->
    <div class="card-section">
      <el-table :data="paginatedData" stripe size="small" v-loading="loading" max-height="calc(100vh - 280px)">
        <el-table-column prop="indicatorCode" label="编码" width="200" show-overflow-tooltip />
        <el-table-column prop="indicatorName" label="名称" width="160" show-overflow-tooltip />
        <el-table-column prop="indicatorType" label="类型" width="80" align="center">
          <template #default="{ row }">
            <el-tag :type="row.indicatorType === 1 ? 'info' : row.indicatorType === 2 ? 'warning' : 'success'" size="small">
              {{ row.indicatorType === 1 ? '原始' : row.indicatorType === 2 ? '计算' : '派生' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="marketType" label="市场" width="80" align="center" />
        <el-table-column prop="categoryL1" label="一级分类" width="100" />
        <el-table-column prop="categoryL2" label="二级分类" width="100" />
        <el-table-column prop="unit" label="单位" width="80" align="center" />
        <el-table-column prop="calcLayer" label="层级" width="60" align="center">
          <template #default="{ row }">L{{ row.calcLayer }}</template>
        </el-table-column>
        <el-table-column prop="status" label="状态" width="80" align="center">
          <template #default="{ row }">
            <el-tag :type="row.status === 1 ? 'success' : 'info'" size="small">
              {{ row.status === 1 ? '已覆盖' : '未覆盖' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="180" fixed="right">
          <template #default="{ row }">
            <el-button link type="primary" size="small" @click="handleEdit(row)">编辑</el-button>
            <el-button v-if="row.indicatorType !== 1" link type="warning" size="small" @click="handleFormula(row)">公式</el-button>
            <el-popconfirm title="确定删除?" @confirm="handleDelete(row)">
              <template #reference><el-button link type="danger" size="small">删除</el-button></template>
            </el-popconfirm>
          </template>
        </el-table-column>
      </el-table>
      <div class="pagination-wrap">
        <el-pagination
          v-model:current-page="pageNum"
          v-model:page-size="pageSize"
          :total="filteredData.length"
          :page-sizes="[20, 50, 100]"
          layout="total, sizes, prev, pager, next"
        />
      </div>
    </div>

    <!-- 新增/编辑表单（独立组件） -->
    <DefinitionForm
      v-model="formVisible"
      :edit-code="editCode"
      :edit-data="editData"
      @save="handleFormSave"
    />
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { Plus } from '@element-plus/icons-vue'
import { getDefinitions, createDefinition, updateDefinition, deleteDefinition } from '@/api/request'
import { MOCK_INDICATORS } from '@/api/mock-data'
import DefinitionForm from './DefinitionForm.vue'
import type { IndicatorDef } from '@/types/indicator'

const router = useRouter()
const searchKey = ref('')
const filterMarket = ref('')
const filterType = ref<number | string>('')
const filterStatus = ref<number | string>('')
const pageNum = ref(1)
const pageSize = ref(50)
const loading = ref(false)
const tableData = ref<IndicatorDef[]>([...MOCK_INDICATORS])

const formVisible = ref(false)
const editCode = ref('')
const editData = ref<Partial<IndicatorDef>>()

const filteredData = computed(() => {
  let list = tableData.value
  if (searchKey.value) {
    const kw = searchKey.value.toLowerCase()
    list = list.filter((i) => i.indicatorCode.toLowerCase().includes(kw) || i.indicatorName.includes(kw))
  }
  if (filterMarket.value) list = list.filter((i) => i.marketType === filterMarket.value)
  if (filterType.value !== '') list = list.filter((i) => i.indicatorType === filterType.value)
  if (filterStatus.value !== '') list = list.filter((i) => i.status === filterStatus.value)
  return list
})

const paginatedData = computed(() => {
  const start = (pageNum.value - 1) * pageSize.value
  return filteredData.value.slice(start, start + pageSize.value)
})

async function loadData() {
  loading.value = true
  try {
    const res = await getDefinitions({ keyword: searchKey.value || undefined, pageNum: pageNum.value, pageSize: pageSize.value })
    tableData.value = res.list
  } catch {
    tableData.value = MOCK_INDICATORS
  } finally {
    loading.value = false
  }
}

function showAddDialog() {
  editCode.value = ''
  editData.value = undefined
  formVisible.value = true
}

function handleEdit(row: IndicatorDef) {
  editCode.value = row.indicatorCode
  editData.value = { ...row }
  formVisible.value = true
}

async function handleFormSave(data: Partial<IndicatorDef>) {
  try {
    if (editCode.value) await updateDefinition(editCode.value, data)
    else await createDefinition(data)
  } catch { /* mock */ }
  loadData()
}

async function handleDelete(row: IndicatorDef) {
  try { await deleteDefinition(row.indicatorCode) } catch { /* mock */ }
  loadData()
}

function handleFormula(row: IndicatorDef) {
  router.push({ path: '/qctc/indicator/config/formula', query: { code: row.indicatorCode } })
}

onMounted(() => loadData())
</script>

<style scoped lang="scss">
.config-page {
  .pagination-wrap { display: flex; justify-content: flex-end; margin-top: 12px; }
}
</style>
