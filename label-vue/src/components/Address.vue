<template>
  <div>
    <form class="form-address" @submit="createAddress">
      <div class="alert alert-danger" v-if="error">{{ error }}</div>
      <div class="form-group">
        <label for="title">Title</label>
        <input v-model="title" type="text" class="form-control" id="title" placeholder="Workplace">
      </div>
      <div class="form-group">
        <label for="company">Company name</label>
        <input v-model="company" type="text" class="form-control" id="company" placeholder="Stessa">
      </div>
      <div class="form-group">
        <label for="street1">Street, line 1</label>
        <input v-model="street1" type="text" class="form-control" id="street1" placeholder="1145 Market Street">
      </div>
      <div class="form-group">
        <label for="street2">Street, line 2</label>
        <input v-model="street2" type="text" class="form-control" id="street2" placeholder="Apartment">
      </div>
      <div class="form-group">
        <label for="city">City</label>
        <input v-model="city" type="text" class="form-control" id="city" placeholder="San Francisco">
      </div>
      <div class="form-group">
        <label for="state">State</label>
        <input v-model="state" type="text" class="form-control" id="state" placeholder="California">
      </div>
      <div class="form-group">
        <label for="zip">Zipcode</label>
        <input v-model="zip" type="text" class="form-control" id="zip" placeholder="94013">
      </div>
      <div class="form-group">
        <label for="phone">Phone Number</label>
        <input v-model="phone" type="text" class="form-control" id="phone" placeholder="12345678">
      </div>
      <button type="submit" name="btn btn-primary mb-3 bg-primary">Create Address</button>
    </form>
    <ul class="list-group py-3">
        <li class="list-group-item bg-info text-white"
            v-for="address in addresses"
            :key="address.id"
            :address="address"
            @click="chooseAddress(address)">
            <label>{{ address.id }}. {{ address.title }}</label>
        </li>
    </ul>
  </div>
</template>

<script>
export default {
  name: 'Address',
  data() {
    return {
      addresses: [],
      error: '',
      title: '',
      company: '',
      street1: '',
      street2: '',
      city: '',
      state: '',
      zip: '',
      phone: ''
    }
  },
  created() {
    if (!localStorage.signedIn) {
      this.$router.replace('/')
    } else {
      this.$http.secured.get('/api/v1/addresses')
        // Get all current addresses
        .then(response => { this.addresses = response.data })
        .catch(error => this.setError(error, 'Something went wrong'))
    }
  },
  props: {
    fromAddress: Boolean
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },

    createAddress() {
      this.$http.secured.post('/api/v1/addresses', {
         address: {
           title: this.title,
           company: this.company,
           street1: this.street1,
           street2: this.street2,
           city: this.city,
           state: this.state,
           zip: this.zip,
           phone: this.phone
         }
       })
        .then(response => {
          this.addresses.push(response.data)
          this.title = ''
          this.company = ''
          this.street1 = ''
          this.street2 = ''
          this.city = ''
          this.state = ''
          this.zip = ''
          this.phone = ''
        })
        .catch(error => this.setError(error, 'Cannot create address'))
    },

    chooseAddress(address) {
      if (this.fromAddress) {
        this.$emit('clickFromAddress', address)
      } else {
        this.$emit('clickToAddress', address)
      }
    }
  }
}
</script>
