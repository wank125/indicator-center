<template>
  <div class="page-container dashboard-page">
    <div class="dashboard-header">
      <h3 class="page-title">指标看板</h3>
      <div class="header-filters">
        <ProvinceSelect v-model="store.selectedProvince" />
        <DateRangePicker v-model="dateRange" @change="handleDateChange" />
      </div>
    </div>

    <!-- KPI 卡片行 -->
    <el-row :gutter="12" class="kpi-row">
      <el-col :span="4" v-for="kpi in store.kpiList" :key="kpi.code">
        <KpiCard
          :label="kpi.label"
          :value="kpi.value"
          :unit="kpi.unit"
          :change-rate="kpi.changeRate"
          :change-type="kpi.changeType"
          :change-direction="kpi.changeDirection"
        />
      </el-col>
    </el-row>

    <!-- 图表行1: 电价曲线 + 价差柱状 -->
    <el-row :gutter="12" class="chart-row">
      <el-col :span="12">
        <div class="card-section">
          <div class="section-title">日前出清电价曲线</div>
          <PriceCurveChart />
        </div>
      </el-col>
      <el-col :span="12">
        <div class="card-section">
          <div class="section-title">实时/日前价差趋势</div>
          <DeviationBarChart />
        </div>
      </el-col>
    </el-row>

    <!-- 图表行2: 收益TOP10 + 偏差分析 -->
    <el-row :gutter="12" class="chart-row">
      <el-col :span="12">
        <div class="card-section">
          <div class="section-title">收益 TOP10</div>
          <TopRankChart :height="240" />
        </div>
      </el-col>
      <el-col :span="12">
        <div class="card-section">
          <div class="section-title">偏差分析</div>
          <DeviationAnalysis />
        </div>
      </el-col>
    </el-row>

    <!-- 图表行3: 合约覆盖率 + 度电成本 + 可利用小时 -->
    <el-row :gutter="12" class="chart-row">
      <el-col :span="12">
        <div class="card-section">
          <div class="section-title">合约覆盖率 / 度电成本趋势</div>
          <CoverageTrend />
        </div>
      </el-col>
      <el-col :span="12">
        <div class="card-section">
          <div class="section-title">可利用小时</div>
          <GaugeChart />
        </div>
      </el-col>
    </el-row>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import KpiCard from './KpiCard.vue'
import PriceCurveChart from './PriceCurveChart.vue'
import DeviationBarChart from './DeviationBarChart.vue'
import TopRankChart from './TopRankChart.vue'
import DeviationAnalysis from './DeviationAnalysis.vue'
import CoverageTrend from './CoverageTrend.vue'
import GaugeChart from './GaugeChart.vue'
import ProvinceSelect from '../components/ProvinceSelect.vue'
import DateRangePicker from '../components/DateRangePicker.vue'
import { useIndicatorStore } from '@/stores/indicator'

const store = useIndicatorStore()
const dateRange = ref<string[]>([])

function handleDateChange() {
  store.loadKpi()
}

onMounted(() => {
  store.initDefaultDate()
  store.loadKpi()
})
</script>

<style scoped lang="scss">
.dashboard-page {
  .dashboard-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: var(--spacing-section);
  }

  .page-title {
    font-size: var(--font-title);
    font-weight: 600;
    color: #333;
  }

  .header-filters {
    display: flex;
    align-items: center;
    gap: 12px;
  }

  .kpi-row {
    margin-bottom: var(--spacing-component);
  }

  .chart-row {
    margin-bottom: var(--spacing-component);
  }
}
</style>
