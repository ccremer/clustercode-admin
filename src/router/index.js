import Vue from 'vue'
import Router from 'vue-router'
import TaskList from '../components/TaskList.vue'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'tasks',
      component: TaskList
    }
  ]
})
