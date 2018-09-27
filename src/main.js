// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.

import Vue from 'vue'
import BootstrapVue from 'bootstrap-vue'
import App from './App.vue'
import router from './router/index'
import { store } from './store/state'
import Vuedals from 'vuedals'
import {Alert} from 'bootstrap-vue/es/components'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'

global.jQuery = global.$ = require('jquery')

require('./css/clustercode.css')
require('./js/clustercode')

Vue.use(BootstrapVue)
Vue.use(Vuedals)
Vue.use(Alert)

Vue.config.productionTip = false

/* eslint-disable no-new */
new Vue({
  el: 'app',
  router,
  store,
  template: '<app/>',
  components: {
    App
  }
})
