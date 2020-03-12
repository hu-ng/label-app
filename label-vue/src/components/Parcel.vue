<template>
  <div>
    <form class="form-parcels" @submit.prevent="createParcel">
      <div class="alert alert-danger" v-if="error">{{ error }}</div>
      <div class="form-group">
        <label for="title">Title</label>
        <input v-model="title" type="text" class="form-control" id="title" placeholder="My T-shirt">
      </div>
      <div class="form-group">
        <label for="length">Length</label>
        <input v-model="length" type="number" class="form-control" id="length" placeholder="10">
      </div>
      <div class="form-group">
        <label for="width">Width</label>
        <input v-model="width" type="number" class="form-control" id="width" placeholder="10">
      </div>
      <div class="height">
        <label for="height">Height</label>
        <input v-model="height" type="number" class="form-control" id="height" placeholder="10">
      </div>
      <div class="form-group">
        <label for="weight">Weight</label>
        <input v-model="weight" type="number" class="form-control" id="weight" placeholder="10">
      </div>
      <button type="submit" name="btn btn-primary mb-3">Create Parcel</button>
    </form>
    <ul class="list-group py-3">
      <li class="list-group-item bg-info text-white" v-for="parcel in parcels" :key="parcel.id" :parcel="parcel" @click="chooseParcel(parcel)">
          <label>{{ parcel.title }}</label>
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  name: 'Parcel',
  data() {
    return {
      parcels: [],
      error: '',
      length: '',
      width: '',
      height: '',
      weight: '',
      title:''
    }
  },
  created() {
    if (!localStorage.signedIn) {
      this.$router.replace('/')
    } else {
      this.$http.secured.get('/api/v1/parcels')
        // Get all current parcels
        .then(response => { this.parcels = response.data })
        .catch(error => this.setError(error, 'Something went wrong'))
    }
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },

    createParcel() {
      this.$http.secured.post('/api/v1/parcels', {
         parcel: {
           length: this.length,
           width: this.width,
           height: this.height,
           weight: this.weight,
           title: this.title
         }
       })
        .then(response => {
          this.parcels.push(response.data)
          this.length = ''
          this.width = ''
          this.height = ''
          this.weight = ''
          this.title = ''
        })
        .catch(error => this.setError(error, 'Cannot create parcel'))
    },

    chooseParcel(parcel) {
      this.$emit("clickParcel", parcel)
    }
  }
}
</script>

<style lang="css">

</style>
