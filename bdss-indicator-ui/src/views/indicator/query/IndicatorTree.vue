<template>
  <div class="indicator-tree-panel">
    <div class="tree-header">
      <span class="tree-title">指标分类</span>
      <el-radio-group :model-value="dimType" size="small" @update:model-value="$emit('update:dimType', $event)">
        <el-radio-button value="BUSINESS">业务域</el-radio-button>
        <el-radio-button value="MARKET">市场</el-radio-button>
        <el-radio-button value="SUBJECT">主体</el-radio-button>
      </el-radio-group>
    </div>
    <el-input :model-value="filter" placeholder="搜索指标" clearable size="small" class="tree-search"
      @update:model-value="$emit('update:filter', $event)" />
    <el-tree
      ref="treeRef"
      :data="treeData"
      :props="treeProps"
      :filter-node-method="filterNode"
      node-key="dimCode"
      highlight-current
      @node-click="handleNodeClick"
    >
      <template #default="{ data }">
        <span class="tree-node-label">{{ data.dimName }}</span>
      </template>
    </el-tree>
  </div>
</template>

<script setup lang="ts">
import { ref, watch } from 'vue'
import type { ElTree } from 'element-plus'
import type { TreeNode } from '@/types/indicator'

const props = defineProps<{
  dimType: 'BUSINESS' | 'MARKET' | 'SUBJECT'
  filter: string
  treeData: TreeNode[]
}>()

const emit = defineEmits<{
  'update:dimType': [value: 'BUSINESS' | 'MARKET' | 'SUBJECT']
  'update:filter': [value: string]
  nodeClick: [data: TreeNode]
}>()

const treeRef = ref<InstanceType<typeof ElTree>>()
const treeProps = { children: 'children', label: 'dimName' }

function filterNode(value: string, data: any) {
  if (!value) return true
  return data.dimName.includes(value) || data.dimCode?.includes(value.toUpperCase())
}

watch(() => props.filter, (val) => {
  treeRef.value?.filter(val)
})

function handleNodeClick(data: TreeNode) {
  if (!data.children || data.children.length === 0) {
    emit('nodeClick', data)
  }
}
</script>

<style scoped lang="scss">
.indicator-tree-panel {
  display: flex;
  flex-direction: column;
  gap: 8px;
  height: 100%;
}

.tree-header {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.tree-title {
  font-size: var(--font-title);
  font-weight: 600;
}

.tree-node-label {
  font-size: var(--font-body);
}
</style>
