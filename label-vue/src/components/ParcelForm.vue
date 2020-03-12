<template>
  <div>
    <form class="form-parcels mt-5 px-5" @submit.prevent="createParcel">
      <div class="alert alert-danger" v-if="error">{{ error }}</div>
      <div class="form-group row">
        <label for="title" class="col-2">Title</label>
        <input v-model="title" type="text" class="form-control col-10" id="title" placeholder="My T-shirt">
      </div>
      <div class="form-group row">
        <label for="length" class="col-2">Length</label>
        <input v-model="length" type="number" class="form-control col-10" id="length" placeholder="10">
      </div>
      <div class="form-group row">
        <label for="width" class="col-2">Width</label>
        <input v-model="width" type="number" class="form-control col-10" id="width" placeholder="10">
      </div>
      <div class="form-group row">
        <label for="height" class="col-2">Height</label>
        <input v-model="height" type="number" class="form-control col-10" id="height" placeholder="10">
      </div>
      <div class="form-group row">
        <label for="weight" class="col-2">Weight</label>
        <input v-model="weight" type="number" class="form-control col-10" id="weight" placeholder="10">
      </div>
      <button type="submit" name="btn btn-primary mb-3">Create Parcel</button>
    </form>
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
          this.$router.replace('/home')
        })
        .catch(error => this.setError(error, 'Cannot create parcel'))
    }
  }
}
</script>

<style lang="css">

</style>
