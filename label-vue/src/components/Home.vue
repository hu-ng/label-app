<template id="home">
  <div>
    <div class="row py-5">
      <div class="col">
        <h3>From Address</h3>
        <ul class="list-group py-3">
            <li class="list-group-item bg-info text-white"
                v-for="address in addresses"
                :key="address.id"
                :address="address"
                @click="chooseFromAddress(address, true)">
                <label>{{ address.id }}. {{ address.title }}</label>
            </li>
        </ul>
      </div>
      <div class="col">
        <h3>To Address</h3>
        <ul class="list-group py-3">
            <li class="list-group-item bg-info text-white"
                v-for="address in addresses"
                :key="address.id"
                :address="address"
                @click="chooseToAddress(address, false)">
                <label>{{ address.id }}. {{ address.title }}</label>
            </li>
        </ul>
      </div>
      <div class="col">
        <h3>Parcel</h3>
        <ul class="list-group py-3">
          <li class="list-group-item bg-info text-white" v-for="parcel in parcels" :key="parcel.id" :parcel="parcel" @click="chooseParcel(parcel)">
              <label>{{ parcel.id }}. {{ parcel.title }}</label>
          </li>
        </ul>
      </div>
      <div class="col">
        <p>Shipping from: {{ (fromAddress) ? (fromAddress.title) : ""}}</p>
        <p>Shipping to: {{ (toAddress) ? (toAddress.title) : ""}}</p>
        <p>Parcel: {{ (parcel) ? (parcel.title) : ""}} </p>
        <button type="button" name="button" @click="createShipment">Create Shipment</button>
        <button class="mt-3">
          <router-link to="/address-form">Create new Address</router-link>
        </button>
        <button class="mt-3">
          <router-link to="/parcel-form">Create new Parcel</router-link>
        </button>
      </div>
    </div>
  </div>
</template>

<script>

export default {
  name: 'Home',
  data() {
    return {
      parcel: null,
      toAddress: null,
      fromAddress: null,
      addresses: [],
      parcels: [],
      error: ''
    }
  },
  created () {
    if (!localStorage.signedIn) {
      this.$router.replace('/')
    } else {
      this.$http.secured.get('/api/v1/addresses')
        // Get all current addresses
        .then(response => { this.addresses = response.data })
        .catch(error => this.setError(error, 'Something went wrong'))

      this.$http.secured.get('/api/v1/parcels')
        // Get all current parcels
        .then(response => { this.parcels = response.data })
        .catch(error => this.setError(error, 'Something went wrong'))
    }
  },

  methods: {
    createShipment() {
      this.$http.secured.post('/api/v1/shipments', {
        shipment: {
          to_address_id: this.toAddress.id,
          from_address_id: this.fromAddress.id,
          parcel_id: this.parcel.id
        }
      })
        .then(response => {
          this.parcel = null,
          this.toAddress = null,
          this.fromAddress = null
          console.log(response)
        })
          .catch(error => this.setError(error, 'Cannot create shipment'))
    },

    chooseToAddress(address) {
      this.toAddress = address
    },

    chooseFromAddress(address) {
      this.fromAddress = address
    },

    chooseParcel(parcel) {
      this.parcel = parcel
    }
  }
}
</script>

<style lang="css">

</style>
