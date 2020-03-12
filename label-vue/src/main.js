import Vue from 'vue'
import App from './App'
import router from './router'
import VueAxios from 'vue-axios'
import 'bootstrap/dist/css/bootstrap.min.css'
import { securedAxiosInstance, plainAxiosInstance } from './backend/'

Vue.config.productionTip = false
Vue.use(VueAxios, {
  secured: securedAxiosInstance,
  plain: plainAxiosInstance
})

new Vue({
  router,
  securedAxiosInstance,
  plainAxiosInstance,
  render: h => h(App),
}).$mount('#app')
