<template>
  <div class="container">
    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4">
      <div class="col" v-for="(pizza, index) in pizzasData" :key="`pizza${index}`">
        <div class="card">
          <img :src="`../../public/${pizza.nev}${pizza.meret}.jpg`" class="card-img-top" alt="pizza image" />
          <div class="card-body">
            <h5 class="card-title">{{ pizza.nev }}</h5>
            <p class="card-text">
              Méret: {{ pizza.meret }} cm <br />
              Ár: {{ pizza.ar }} Ft
            </p>
            <a href="#" class="btn btn-dark">Megrendelés</a>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { useUrlStore } from "@/stores/url";
import { useLoginStore } from "@/stores/login";
import { storeToRefs } from "pinia";
import { useKeresStore } from "@/stores/keres";
const storeKeres = useKeresStore();
const { keresoszo } = storeToRefs(storeKeres);
const storeUrl = useUrlStore();
const storeLogin = useLoginStore();

export default {
  data() {
    return {
      keresoszo,
      storeUrl,
      storeLogin,
      pizzasData: [],
    };
  },
  watch: {
    keresoszo(){
      if (this.keresoszo.trim()) {
        this.getPizzasSzur();
      } else {
        this.getPizzas();
      }
    }
  },
  computed: {
    pizzas() {
      return this.pizzasData.map((pizza) => ({
        name: pizza.nev,
        size: pizza.meret,
        price: pizza.ar,
        image:
          "https://www.mindmegette.hu/images/311/O/kemences-pizza-fekvo.jpg",
      }));
    },
  },
  mounted() {
    this.getPizzas();
  },
  methods: {
    async getPizzas() {
      const url = this.storeUrl.urlPizzak;
      const config = {
        method: "GET",
        headers: {
          Authorization: `Bearer ${this.storeLogin.accessToken}`,
        },
      };
      const response = await fetch(url, config);
      const data = await response.json();
      this.pizzasData = data.data;
    },
    async getPizzasSzur() {
      const url = `${this.storeUrl.urlPizzakKeres}/${this.keresoszo}`;
      const config = {
        method: "GET",
        headers: {
          Authorization: `Bearer ${this.storeLogin.accessToken}`,
        },
      };
      const response = await fetch(url, config);
      const data = await response.json();
      this.pizzasData = data.data;
    },
  },
};
</script>

<style>
.card {
  margin-bottom: 20px;
}
.card-img-top {
  border-radius: 5px;
}
.card-title {
  margin-bottom: 10px;
}
.card-text {
  margin-bottom: 5px;
}
.btn-primary {
  margin-top: 10px;
}

</style>