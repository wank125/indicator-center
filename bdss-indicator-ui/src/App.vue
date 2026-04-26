<template>
  <el-container class="app-layout">
    <el-aside width="200px" class="app-sidebar">
      <div class="sidebar-logo">
        <h2>指标中心</h2>
      </div>
      <el-menu
        :default-active="activeMenu"
        background-color="#001529"
        text-color="rgba(255,255,255,0.65)"
        active-text-color="#1890ff"
        router
      >
        <el-menu-item index="/qctc/indicator/dashboard">
          <el-icon><DataBoard /></el-icon>
          <span>指标看板</span>
        </el-menu-item>
        <el-menu-item index="/qctc/indicator/query">
          <el-icon><Search /></el-icon>
          <span>指标查询</span>
        </el-menu-item>
        <el-sub-menu index="/qctc/indicator/config">
          <template #title>
            <el-icon><Setting /></el-icon>
            <span>指标配置</span>
          </template>
          <el-menu-item index="/qctc/indicator/config/def">指标定义</el-menu-item>
          <el-menu-item index="/qctc/indicator/config/source">数据源映射</el-menu-item>
          <el-menu-item index="/qctc/indicator/config/formula">公式编辑</el-menu-item>
          <el-menu-item index="/qctc/indicator/config/dim">维度管理</el-menu-item>
        </el-sub-menu>
        <el-menu-item index="/qctc/indicator/monitor">
          <el-icon><Monitor /></el-icon>
          <span>计算监控</span>
        </el-menu-item>
      </el-menu>
    </el-aside>
    <el-container>
      <el-header class="app-header">
        <div class="header-breadcrumb">
          <el-breadcrumb separator="/">
            <el-breadcrumb-item>指标中心</el-breadcrumb-item>
            <el-breadcrumb-item v-if="currentTitle">{{ currentTitle }}</el-breadcrumb-item>
          </el-breadcrumb>
        </div>
        <div class="header-actions">
          <ProvinceSelect v-model="store.selectedProvince" @change="handleProvinceChange" />
        </div>
      </el-header>
      <el-main class="app-main">
        <router-view />
      </el-main>
    </el-container>
  </el-container>
</template>

<script setup lang="ts">
import { computed, watch } from 'vue'
import { useRoute } from 'vue-router'
import { DataBoard, Search, Setting, Monitor } from '@element-plus/icons-vue'
import ProvinceSelect from '@/views/indicator/components/ProvinceSelect.vue'
import { useIndicatorStore } from '@/stores/indicator'

const route = useRoute()
const store = useIndicatorStore()

const activeMenu = computed(() => route.path)
const currentTitle = computed(() => (route.meta.title as string) || '')

function handleProvinceChange(val: number | string) {
  store.tenantId = val ? Number(val) : undefined
  store.loadKpi()
  store.loadDimensionTree()
}
</script>

<style lang="scss">
@import '@/styles/variables.scss';

.app-layout {
  height: 100vh;
}

.app-sidebar {
  background: #001529;
  overflow-y: auto;

  &::-webkit-scrollbar {
    width: 0;
  }
}

.sidebar-logo {
  height: 48px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-bottom: 1px solid rgba(255, 255, 255, 0.08);

  h2 {
    color: #fff;
    font-size: 16px;
    font-weight: 600;
    white-space: nowrap;
  }
}

.app-header {
  background: var(--color-card);
  display: flex;
  align-items: center;
  justify-content: space-between;
  border-bottom: 1px solid var(--color-border);
  padding: 0 20px;
  height: 48px;
}

.header-actions {
  display: flex;
  align-items: center;
  gap: 12px;
}

.app-main {
  background: var(--color-bg);
  overflow-y: auto;
}

// Element Plus sidebar overrides
.el-menu {
  border-right: none !important;
}

.el-sub-menu .el-menu-item {
  padding-left: 52px !important;
}
</style>
