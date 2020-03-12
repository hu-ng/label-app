<template id="home">
  <div>
    <div class="row py-5">
      <div class="col">
        <h3>From Address</h3>
        <Address v-bind:fromAddress="true" @clickFromAddress="chooseFromAddress"/>
      </div>
      <div class="col">
        <h3>To Address</h3>
        <Address v-bind:fromAddress="false" @clickToAddress="chooseToAddress"/>
      </div>
      <div class="col">
        <h3>Parcel</h3>
        <Parcel @clickParcel="chooseParcel"/>
      </div>
      <div class="col">
        <p>Shipping from: {{ (fromAddress) ? (fromAddress.title) : ""}}</p>
        <p>Shipping to: {{ (toAddress) ? (toAddress.title) : ""}}</p>
        <p>Parcel: {{ (parcel) ? (parcel.title) : ""}} </p>
        <button type="button" name="button" @click="createShipment">Create Shipment</button>
      </div>
    </div>
  </div>
</template>

<script>
import Address from "@/components/Address"
import Parcel from "@/components/Parcel"

export default {
  name: 'Home',
  components: {
    Address,
    Parcel
  },
  data() {
    return {
      parcel: null,
      toAddress: null,
      fromAddress: null
    }
  },
  created () {
    if (!localStorage.signedIn) {
      this.$router.replace('/')
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
