<template>
  <div class="page-container config-page formula-page">
    <el-row :gutter="16">
      <!-- 左侧: 公式编辑区 -->
      <el-col :span="14">
        <div class="card-section">
          <div class="section-title">公式编辑器</div>
          <el-form label-width="80px" size="default">
            <el-form-item label="指标">
              <el-select v-model="selectedCode" placeholder="选择计算指标" filterable @change="handleSelect">
                <el-option v-for="item in MOCK_CALC_INDICATORS" :key="item.code" :label="`${item.name} (${item.code})`" :value="item.code" />
              </el-select>
            </el-form-item>
            <el-form-item label="公式类型">
              <el-radio-group v-model="formulaType">
                <el-radio-button value="arithmetic">四则运算</el-radio-button>
                <el-radio-button value="condition">条件分支</el-radio-button>
                <el-radio-button value="aggregate">聚合</el-radio-button>
                <el-radio-button value="compare">同环比</el-radio-button>
              </el-radio-group>
            </el-form-item>
            <el-form-item label="公式表达式">
              <el-input v-model="formula" type="textarea" :rows="3" placeholder="输入公式表达式，如: {DAM_CLEARING_ENERGY} - {MLT_CONTRACT_ENERGY}" />
            </el-form-item>
          </el-form>

          <!-- 依赖指标 -->
          <div v-if="deps.length" class="deps-section">
            <div class="deps-title">依赖指标</div>
            <div class="deps-tags">
              <el-tag v-for="dep in deps" :key="dep.code" size="small" class="dep-tag" closable @close="removeDep(dep.code)">
                {{ dep.name }} ({{ dep.code }})
              </el-tag>
            </div>
          </div>

          <!-- 操作按钮 -->
          <div class="formula-actions">
            <el-button type="primary" @click="handleValidate">校验公式</el-button>
            <el-button @click="handleSave">保存</el-button>
          </div>
        </div>

        <!-- 公式预览 -->
        <div class="card-section" style="margin-top: 12px">
          <FormulaPreview :formula="formula" :deps="deps" :unit="selectedUnit" />
        </div>
      </el-col>

      <!-- 右侧: 依赖拓扑 + 指标选择 -->
      <el-col :span="10">
        <div class="card-section">
          <div class="section-title">依赖拓扑图</div>
          <DependencyGraph :target-code="selectedCode" :target-name="selectedName" :deps="deps" :height="260" />
        </div>
        <div class="card-section" style="margin-top: 12px">
          <div class="section-title">可选指标 (原始层)</div>
          <el-input v-model="indicatorFilter" placeholder="搜索" clearable size="small" style="margin-bottom: 8px" />
          <div class="indicator-list">
            <div v-for="item in filteredIndicators" :key="item.code" class="indicator-item" @click="addDep(item)">
              <span class="ind-name">{{ item.name }}</span>
              <span class="ind-code">{{ item.code }}</span>
            </div>
          </div>
        </div>
      </el-col>
    </el-row>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { ElMessage } from 'element-plus'
import DependencyGraph from './DependencyGraph.vue'
import FormulaPreview from './FormulaPreview.vue'
import { MOCK_CALC_INDICATORS, MOCK_RAW_INDICATORS } from '@/api/mock-data'
import { getFormulaByCode, saveFormula, updateFormula, validateFormula } from '@/api/request'
import type { FormulaData } from '@/api/request'

const route = useRoute()
const selectedCode = ref((route.query.code as string) || '')
const formulaType = ref('arithmetic')
const formula = ref('')
const indicatorFilter = ref('')
const existingFormulaId = ref<number | null>(null)
const saving = ref(false)

interface DepItem { code: string; name: string; layer: number }
const deps = ref<DepItem[]>([])

const selectedName = computed(() => {
  const found = MOCK_CALC_INDICATORS.find((i) => i.code === selectedCode.value)
  return found?.name || ''
})

const selectedUnit = computed(() => {
  // Default unit based on common indicators
  const code = selectedCode.value
  if (code.includes('PRICE') || code.includes('COST')) return '元/MWh'
  if (code.includes('FEE') || code.includes('MARGIN')) return '元'
  if (code.includes('ENERGY')) return 'MWh'
  return ''
})

const filteredIndicators = computed(() => {
  if (!indicatorFilter.value) return MOCK_RAW_INDICATORS
  const kw = indicatorFilter.value.toLowerCase()
  return MOCK_RAW_INDICATORS.filter((i) => i.name.includes(kw) || i.code.toLowerCase().includes(kw))
})

async function handleSelect() {
  formula.value = ''
  deps.value = []
  existingFormulaId.value = null
  if (!selectedCode.value) return
  try {
    const existing = await getFormulaByCode(selectedCode.value)
    if (existing && existing.formulaExpr) {
      formula.value = existing.formulaExpr
      existingFormulaId.value = existing.id ?? null
      if (existing.formulaType != null) {
        const types = ['arithmetic', 'condition', 'aggregate', 'compare']
        formulaType.value = types[existing.formulaType] || 'arithmetic'
      }
      if (existing.depCodes) {
        const codes = existing.depCodes.split(',')
        deps.value = codes.map((code) => {
          const found = MOCK_RAW_INDICATORS.find((i) => i.code === code)
          return { code, name: found?.name || code, layer: found?.layer ?? 0 }
        })
      }
    }
  } catch { /* no existing formula */ }
}

function addDep(item: typeof MOCK_RAW_INDICATORS[0]) {
  if (deps.value.some((d) => d.code === item.code)) return
  deps.value.push({ code: item.code, name: item.name, layer: item.layer })
  formula.value = deps.value.map((d) => `{${d.code}}`).join(' - ')
}

function removeDep(code: string) {
  deps.value = deps.value.filter((d) => d.code !== code)
  formula.value = deps.value.map((d) => `{${d.code}}`).join(' - ')
}

async function handleValidate() {
  if (!formula.value) { ElMessage.warning('请输入公式表达式'); return }
  const refs = formula.value.match(/\{([^}]+)\}/g)
  if (refs) {
    const codes = refs.map((r) => r.slice(1, -1))
    const missing = codes.filter((c) => !deps.value.some((d) => d.code === c))
    if (missing.length) { ElMessage.error(`未识别的指标编码: ${missing.join(', ')}`); return }
  }
  const typeIdx = ['arithmetic', 'condition', 'aggregate', 'compare'].indexOf(formulaType.value)
  try {
    const data: FormulaData = {
      indicatorCode: selectedCode.value,
      formulaType: typeIdx >= 0 ? typeIdx : 0,
      formulaExpr: formula.value,
      depCodes: deps.value.map((d) => d.code).join(','),
    }
    await validateFormula(data)
    ElMessage.success('公式校验通过')
  } catch (e: any) {
    ElMessage.error(e.message || '校验失败')
  }
}

async function handleSave() {
  if (!selectedCode.value) { ElMessage.warning('请先选择指标'); return }
  if (!formula.value) { ElMessage.warning('请输入公式表达式'); return }
  saving.value = true
  const typeIdx = ['arithmetic', 'condition', 'aggregate', 'compare'].indexOf(formulaType.value)
  const data: FormulaData = {
    indicatorCode: selectedCode.value,
    formulaType: typeIdx >= 0 ? typeIdx : 0,
    formulaExpr: formula.value,
    depCodes: deps.value.map((d) => d.code).join(','),
  }
  try {
    if (existingFormulaId.value) {
      await updateFormula(existingFormulaId.value, data)
    } else {
      await saveFormula(data)
    }
    ElMessage.success('公式已保存')
  } catch (e: any) {
    ElMessage.error(e.message || '保存失败')
  } finally {
    saving.value = false
  }
}

onMounted(() => {
  if (selectedCode.value) handleSelect()
})
</script>

<style scoped lang="scss">
.formula-page {
  .deps-section { margin-top: 16px; padding-top: 12px; border-top: 1px solid var(--color-border); }
  .deps-title { font-size: var(--font-aux); color: #999; margin-bottom: 8px; }
  .deps-tags { display: flex; flex-wrap: wrap; gap: 6px; }
  .dep-tag { cursor: pointer; }
  .formula-actions { margin-top: 16px; display: flex; gap: 8px; }
  .indicator-list { max-height: 300px; overflow-y: auto; }
  .indicator-item {
    display: flex; justify-content: space-between; padding: 6px 8px; cursor: pointer;
    border-radius: 4px; transition: background 0.15s;
    &:hover { background: #f0f5ff; }
  }
  .ind-name { font-size: var(--font-body); }
  .ind-code { font-size: var(--font-aux); color: #999; font-family: monospace; }
}
</style>
