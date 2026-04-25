<template>
  <div class="page-container config-page dim-page">
    <el-row :gutter="16">
      <el-col :span="12">
        <div class="card-section">
          <div class="section-title">
            维度管理
            <el-button-group>
              <el-button size="small" :type="activeDim === 'BUSINESS' ? 'primary' : ''" @click="switchDim('BUSINESS')">业务域</el-button>
              <el-button size="small" :type="activeDim === 'MARKET' ? 'primary' : ''" @click="switchDim('MARKET')">市场类型</el-button>
              <el-button size="small" :type="activeDim === 'SUBJECT' ? 'primary' : ''" @click="switchDim('SUBJECT')">主体层级</el-button>
            </el-button-group>
          </div>
          <div class="tree-toolbar">
            <el-button type="primary" size="small" @click="addRootNode"><el-icon><Plus /></el-icon>新增根节点</el-button>
          </div>
          <el-tree :data="dimTree" node-key="id" default-expand-all :expand-on-click-node="false" draggable @node-drop="handleDrop">
            <template #default="{ data }">
              <div class="dim-tree-node">
                <span class="node-label">{{ data.dimName }}</span>
                <span class="node-code">{{ data.dimCode }}</span>
                <span class="node-actions">
                  <el-button link type="primary" size="small" @click.stop="addChild(data)">添加</el-button>
                  <el-button link type="primary" size="small" @click.stop="editNode(data)">编辑</el-button>
                  <el-popconfirm title="确定删除?" @confirm="deleteNode(data)">
                    <template #reference><el-button link type="danger" size="small" @click.stop>删除</el-button></template>
                  </el-popconfirm>
                </span>
              </div>
            </template>
          </el-tree>
        </div>
      </el-col>
      <el-col :span="12">
        <div class="card-section" v-if="editingNode">
          <div class="section-title">编辑节点</div>
          <el-form :model="editingNode" label-width="80px" size="default">
            <el-form-item label="维度编码"><el-input v-model="editingNode.dimCode" /></el-form-item>
            <el-form-item label="维度名称"><el-input v-model="editingNode.dimName" /></el-form-item>
            <el-form-item label="维度类型">
              <el-select v-model="editingNode.dimType" style="width: 100%">
                <el-option label="业务域" value="BUSINESS" />
                <el-option label="市场类型" value="MARKET" />
                <el-option label="主体层级" value="SUBJECT" />
              </el-select>
            </el-form-item>
            <el-form-item><el-button type="primary" @click="saveNode">保存</el-button></el-form-item>
          </el-form>
        </div>
        <div class="card-section" v-else><el-empty description="选择左侧节点进行编辑" :image-size="80" /></div>
        <div class="card-section" style="margin-top: 12px" v-if="editingNode">
          <div class="section-title">绑定指标</div>
          <el-select v-model="bindIndicators" multiple filterable placeholder="搜索并绑定指标" style="width: 100%">
            <el-option v-for="ind in MOCK_INDICATOR_OPTIONS" :key="ind.code" :label="`${ind.name} (${ind.code})`" :value="ind.code" />
          </el-select>
          <div class="bind-actions"><el-button type="primary" size="small" @click="saveBindings">保存绑定</el-button></div>
        </div>
      </el-col>
    </el-row>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { Plus } from '@element-plus/icons-vue'
import { ElMessage } from 'element-plus'
import { MOCK_DIMENSION_TREE, MOCK_INDICATOR_OPTIONS } from '@/api/mock-data'

interface DimNode {
  id: number; dimType: string; dimCode: string; dimName: string; parentId: number | null; children?: DimNode[]
}

const activeDim = ref('BUSINESS')
const dimTree = ref<DimNode[]>([...MOCK_DIMENSION_TREE])
const editingNode = ref<DimNode | null>(null)
const bindIndicators = ref<string[]>([])

function switchDim(type: string) {
  activeDim.value = type
  editingNode.value = null
  // TODO: 按 type 从后端加载不同维度树，当前 mock 统一使用 BUSINESS 树
}
function addRootNode() { ElMessage.success('新增根节点 (Mock)') }
function addChild(data: DimNode) { ElMessage.success(`在 ${data.dimName} 下新增子节点 (Mock)`) }
function editNode(data: DimNode) { editingNode.value = { ...data } }
function deleteNode(data: DimNode) { ElMessage.success(`删除 ${data.dimName} (Mock)`) }
function saveNode() { ElMessage.success('节点已保存') }
function handleDrop() { ElMessage.success('节点顺序已更新') }
function saveBindings() { ElMessage.success('指标绑定已保存') }
</script>

<style scoped lang="scss">
.dim-page {
  .section-title { display: flex; align-items: center; justify-content: space-between; }
  .tree-toolbar { margin: 12px 0; }
  .dim-tree-node { display: flex; align-items: center; gap: 8px; flex: 1; font-size: var(--font-body); }
  .node-label { flex: 1; }
  .node-code { color: #999; font-size: var(--font-aux); font-family: monospace; }
  .node-actions { display: none; }
  .dim-tree-node:hover .node-actions { display: inline-flex; }
  .bind-actions { margin-top: 8px; }
}
</style>
