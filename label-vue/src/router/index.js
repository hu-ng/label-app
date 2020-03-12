import Vue from 'vue'
import Router from 'vue-router'
import Signin from '@/components/Signin'
import Signup from '@/components/Signup'
import Home from '@/components/Home'
import Shipment from '@/components/Shipment'
import AddressForm from '@/components/AddressForm'
import ParcelForm from '@/components/ParcelForm'


Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'Signin',
      component: Signin
    },
    {
      path: '/signup',
      name: 'Signup',
      component: Signup
    },
    {
      path: '/home',
      name: 'Home',
      component: Home
    },
    {
      path: '/shipments',
      name: 'Shipment',
      component: Shipment
    },
    {
      path: '/address-form',
      name: 'AddressForm',
      component: AddressForm
    },
    {
      path: '/parcel-form',
      name: 'ParcelForm',
      component: ParcelForm
    }
  ]
})
