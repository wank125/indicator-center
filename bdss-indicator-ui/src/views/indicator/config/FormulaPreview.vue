<template>
  <div class="formula-preview-section">
    <div class="preview-header">公式预览（测试计算）</div>
    <el-row :gutter="12" style="margin-bottom: 12px">
      <el-col :span="8">
        <el-date-picker v-model="testDate" type="date" placeholder="选择交易日期" value-format="YYYY-MM-DD" style="width: 100%" />
      </el-col>
      <el-col :span="8">
        <el-select v-model="testUnitId" placeholder="选择机组" filterable clearable style="width: 100%">
          <el-option label="全部机组" value="ALL" />
          <el-option label="SX-A01" value="SX-A01" />
          <el-option label="SX-A02" value="SX-A02" />
          <el-option label="HN-A01" value="HN-A01" />
        </el-select>
      </el-col>
      <el-col :span="8">
        <el-button type="success" size="small" :loading="calcLoading" @click="runTest">执行测试</el-button>
      </el-col>
    </el-row>

    <!-- 依赖值表 -->
    <el-table v-if="result" :data="result.depValues" size="small" stripe style="margin-bottom: 12px">
      <el-table-column prop="code" label="依赖指标" width="200" />
      <el-table-column prop="value" label="取值" align="right" width="120" />
      <el-table-column prop="unit" label="单位" width="80" />
    </el-table>

    <!-- 计算结果 -->
    <div v-if="result" class="calc-result" :class="{ 'calc-error': result.error }">
      <span class="result-label">计算结果:</span>
      <span v-if="result.error" class="result-value text-error">{{ result.error }}</span>
      <span v-else class="result-value text-success">{{ result.value }} {{ result.unit }}</span>
    </div>

    <!-- 公式展示 -->
    <div class="formula-display">
      <code>{{ formula || '请输入公式' }}</code>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'

const props = defineProps<{
  formula: string
  deps: Array<{ code: string; name: string }>
  unit?: string
}>()

const testDate = ref(`${new Date().getFullYear()}-${String(new Date().getMonth() + 1).padStart(2, '0')}-${String(new Date().getDate()).padStart(2, '0')}`)
const testUnitId = ref('ALL')
const calcLoading = ref(false)

interface TestResult {
  value?: string
  unit?: string
  error?: string
  depValues: Array<{ code: string; value: string; unit: string }>
}

const result = ref<TestResult | null>(null)

function runTest() {
  if (!props.formula) return
  calcLoading.value = true

  // Mock calculation
  setTimeout(() => {
    const depValues = props.deps.map((d) => ({
      code: d.code,
      value: (Math.random() * 500 + 100).toFixed(2),
      unit: props.unit || '',
    }))

    const hasError = Math.random() < 0.1
    if (hasError) {
      result.value = { error: '除零错误: 依赖指标为 null', depValues }
    } else {
      result.value = {
        value: (Math.random() * 200 + 50).toFixed(2),
        unit: props.unit || '',
        depValues,
      }
    }
    calcLoading.value = false
  }, 500)
}
</script>

<style scoped lang="scss">
.formula-preview-section {
  margin-top: 16px;
  padding-top: 12px;
  border-top: 1px solid var(--color-border);
}

.preview-header {
  font-size: var(--font-aux);
  color: #999;
  margin-bottom: 12px;
}

.calc-result {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 8px 12px;
  border-radius: 4px;
  background: #f6ffed;
  margin-bottom: 12px;

  &.calc-error { background: #fff2f0; }
}

.result-label { font-size: var(--font-body); color: #666; }
.result-value { font-size: var(--font-title); font-weight: 600; }

.formula-display {
  background: #f5f7fa;
  border-radius: 4px;
  padding: 12px;
  font-family: 'Courier New', monospace;
  font-size: var(--font-body);

  code { color: #333; }
}
</style>
