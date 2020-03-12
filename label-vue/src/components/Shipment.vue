<template>
  <div class="py-5">
    <table class="table">
      <thead>
        <tr>
          <th scope="col">Shipment ID</th>
          <th scope="col">From Address</th>
          <th scope="col">To Address</th>
          <th scope="col">Parcel</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="shipment in shipments"
            :key="shipment.id"
            :shipment="shipment">
            <td>{{ shipment.id }}</td>
            <td>{{ getTitleAddress(shipment.from_address_id) }}</td>
            <td>{{ getTitleAddress(shipment.to_address_id) }}</td>
            <td>{{ getTitleParcel(shipment.parcel_id) }}</td>
            <td>
              <button type="button" name="button"
                      @click="createLabel(shipment.unique_id)">
                Create label
              </button>
            </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>
<script>
  export default {
    name: 'Shipment',
    data() {
      return {
        shipments: []
      }
    },

    created() {
      if (!localStorage.signedIn) {
        this.$router.replace('/') }
      else {
        this.$http.secured.get('/api/v1/shipments')
          // Get all current addresses
          .then(response => { this.shipments = response.data })
          .catch(error => this.setError(error, 'Something went wrong'))
      }
    },

    methods: {
      setError (error, text) {
        this.error = (error.response && error.response.data && error.response.data.error) || text
      },

      getTitleAddress(id) {
        this.$http.secured.get(`/api/v1/addresses/${id}`)
          .then(response => {
            return response.data.title
          })
          .catch(error => this.setError(error, 'Something went wrong'))
      },

      getTitleParcel(id) {
        this.$http.secured.get(`/api/v1/parcels/${id}`)
          .then(response => {
            return response.data.title
          })
          .catch(error => this.setError(error, 'Something went wrong'))
      },
      }
    }
  }

</script>
