import { createRouter, createWebHashHistory } from 'vue-router'

const router = createRouter({
  history: createWebHashHistory(),
  routes: [
    {
      path: '/',
      redirect: '/qctc/indicator/dashboard',
    },
    {
      path: '/qctc/indicator',
      children: [
        {
          path: 'dashboard',
          name: 'IndicatorDashboard',
          component: () => import('@/views/indicator/dashboard/Index.vue'),
          meta: { title: '指标看板' },
        },
        {
          path: 'query',
          name: 'IndicatorQuery',
          component: () => import('@/views/indicator/query/Index.vue'),
          meta: { title: '指标查询' },
        },
        {
          path: 'config',
          name: 'IndicatorConfig',
          redirect: '/qctc/indicator/config/def',
          children: [
            {
              path: 'def',
              name: 'ConfigDef',
              component: () => import('@/views/indicator/config/DefinitionList.vue'),
              meta: { title: '指标定义' },
            },
            {
              path: 'source',
              name: 'ConfigSource',
              component: () => import('@/views/indicator/config/SourceMapping.vue'),
              meta: { title: '数据源映射' },
            },
            {
              path: 'formula',
              name: 'ConfigFormula',
              component: () => import('@/views/indicator/config/FormulaEditor.vue'),
              meta: { title: '公式编辑' },
            },
            {
              path: 'dim',
              name: 'ConfigDim',
              component: () => import('@/views/indicator/config/DimensionTree.vue'),
              meta: { title: '维度管理' },
            },
          ],
        },
        {
          path: 'monitor',
          name: 'IndicatorMonitor',
          component: () => import('@/views/indicator/monitor/Index.vue'),
          meta: { title: '计算监控' },
        },
      ],
    },
  ],
})

router.beforeEach((to, _from, next) => {
  if (to.meta.title) {
    document.title = `${to.meta.title} - 指标中心`
  }
  next()
})

export default router
