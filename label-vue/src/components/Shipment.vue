<template>
  <div class="py-5">
    <div class="alert alert-danger" v-if="error">{{ error }}</div>
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
            <td>{{ shipment.from_address_id }}</td>
            <td>{{ shipment.to_address_id }}</td>
            <td>{{ shipment.parcel_id }}</td>
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
      shipments: [],
      to_address: [],
      from_address: [],
      parcel: [],
      error: ''
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
      console.log(this.error)
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },

    getTitleAddress(id, fromAddressBool) {
      this.$http.secured.get(`/api/v1/addresses/${id}`)
        .then(response => {
          if (fromAddressBool) {
            this.from_address.push(response.data.title)
          } else {
            this.to_address.push(response.data.title)
          }
        })
        .catch(error => this.setError(error, 'Something went wrong'))
    },

    getTitleParcel(id) {
      this.$http.secured.get(`/api/v1/parcels/${id}`)
        .then(response => {
          this.parcel.push(response.data.title)
        })
        .catch(error => this.setError(error, 'Something went wrong'))
    },

    createLabel(unique_id) {
      this.$http.secured.post('/api/v1/get_label', {
        label: {unique_id: unique_id}
      })
        .then(response => {
          if (response.data.label_link) {
            window.open(response.data.label_link, '_blank');
          }
      })
        .catch(error => this.setError(error, 'Label for the shipment already exists'))
    }
  }
}

</script>
