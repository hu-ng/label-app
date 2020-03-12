<template>
  <div id="app">
    <div class="container">
      <div class="sign-out float-right d-block">
        <router-link class="mr-3" to="/shipments">Shipments</router-link>
        <router-link class="mr-3" to="/home">Home</router-link>
        <a href="#" @click="signOut">Sign Out</a>
      </div>
      <br>
      <router-view></router-view>
    </div>
  </div>
</template>

<script>

export default {
  name: 'App',
  components: {
  },
  methods: {
    signOut () {
      this.$http.secured.delete('/signin')
        .then(response => {
          console.log(response)
          delete localStorage.csrf
          delete localStorage.signedIn
          this.$router.replace('/')
         })
         .catch(error => this.setError(error, 'Cannot sign out'))
    },
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
