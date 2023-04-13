<template>
  <div>
    <h1>Pizzák</h1>
    <div class="row row-cols-1 row-cols-sm-2  row-cols-md-3  row-cols-lg-4  g-4">
      
      <div class="col"
      v-for="(pizza, index) in pizzak" :key="`pizza${index}`"
      >
        <div class="card">
          <!-- <img src="..." class="card-img-top" alt="..." /> -->
          <div class="card-body">
            <h5 class="card-title">{{ pizza.nev }}</h5>
            <p class="card-text">
             Méret: {{ pizza.meret }} cm <br>
             Ár: {{ pizza.ar }} Ft
            </p>
            <a href="#" class="btn btn-primary">Megrendelés</a>
          </div>
        </div>
      </div>
    </div>

  </div>
</template>

<script>
import { useUrlStore } from "@/stores/url";
import { useLoginStore } from "@/stores/login";
const storeUrl = useUrlStore();
const storeLogin = useLoginStore();
export default {
  data() {
    return {
      storeUrl,
      storeLogin,
      pizzak: [],
    };
  },
  mounted() {
    this.getPizzak();
  },
  methods: {
    async getPizzak() {
      let url = this.storeUrl.urlPizza;
      const config = {
        method: "GET",
        headers: {
          Authorization: `Bearer ${this.storeLogin.accessToken}`,
        },
      };
      const response = await fetch(url, config);
      const data = await response.json();
      this.pizzak = data.data;
    },
  },
};
</script>

<style>
</style>
