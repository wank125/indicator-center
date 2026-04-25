<template>
  <el-dialog v-model="visible" :title="editCode ? '编辑指标' : '新增指标'" width="600px" destroy-on-close>
    <el-form :model="form" label-width="90px" size="default">
      <el-row :gutter="16">
        <el-col :span="12">
          <el-form-item label="指标编码" required>
            <el-input v-model="form.indicatorCode" :disabled="!!editCode" />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="指标名称" required>
            <el-input v-model="form.indicatorName" />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="指标类型">
            <el-select v-model="form.indicatorType" style="width: 100%">
              <el-option label="原始" :value="1" />
              <el-option label="计算" :value="2" />
              <el-option label="派生" :value="3" />
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="市场类型">
            <el-select v-model="form.marketType" style="width: 100%">
              <el-option label="现货" value="SPOT" />
              <el-option label="中长期" value="MLT" />
              <el-option label="通用" value="ALL" />
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="主体类型">
            <el-select v-model="form.subjectType" style="width: 100%">
              <el-option label="机组" value="UNIT" />
              <el-option label="电厂" value="PLANT" />
              <el-option label="集团" value="GROUP" />
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="一级分类">
            <el-input v-model="form.categoryL1" />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="二级分类">
            <el-input v-model="form.categoryL2" />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="单位">
            <el-input v-model="form.unit" />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="计算层级">
            <el-input-number v-model="form.calcLayer" :min="0" :max="5" style="width: 100%" />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="时间粒度">
            <el-select v-model="form.timeGrain" style="width: 100%">
              <el-option label="分时" value="timeseries" />
              <el-option label="日" value="daily" />
              <el-option label="月" value="monthly" />
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="状态">
            <el-switch v-model="form.status" :active-value="1" :inactive-value="0" active-text="启用" inactive-text="停用" />
          </el-form-item>
        </el-col>
      </el-row>
    </el-form>
    <template #footer>
      <el-button @click="visible = false">取消</el-button>
      <el-button type="primary" @click="handleSave">保存</el-button>
    </template>
  </el-dialog>
</template>

<script setup lang="ts">
import { ref, computed, watch } from 'vue'
import type { IndicatorDef } from '@/types/indicator'

const props = defineProps<{
  modelValue: boolean
  editCode?: string
  editData?: Partial<IndicatorDef>
}>()

const emit = defineEmits<{
  'update:modelValue': [v: boolean]
  save: [data: Partial<IndicatorDef>]
}>()

const visible = computed({
  get: () => props.modelValue,
  set: (v) => emit('update:modelValue', v),
})

const form = ref<Partial<IndicatorDef>>({
  indicatorType: 1,
  marketType: 'SPOT',
  subjectType: 'UNIT',
  calcLayer: 0,
  timeGrain: 'daily',
  status: 1,
})

watch(() => props.editData, (data) => {
  if (data) form.value = { ...data }
}, { immediate: true })

watch(() => props.modelValue, (open) => {
  if (open && !props.editCode) {
    form.value = { indicatorType: 1, marketType: 'SPOT', subjectType: 'UNIT', calcLayer: 0, timeGrain: 'daily', status: 1 }
  }
})

function handleSave() {
  emit('save', { ...form.value })
  visible.value = false
}
</script>
