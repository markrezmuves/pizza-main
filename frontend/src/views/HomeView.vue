<template>
  <div class="container">
    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4">
      <div
        class="col"
        v-for="(pizza, index) in pizzasData"
        :key="`pizza${index}`"
      >
        <div class="card">
          <img
            :src="`../../public/${pizza.nev}${pizza.meret}.jpg`"
            class="card-img-top"
            alt="pizza image"
          />
          <div class="card-body">
            <h5 class="card-title">{{ pizza.nev }}</h5>
            <p class="card-text">
              Méret: {{ pizza.meret }} cm <br />
              Ár: {{ pizza.ar }} Ft
            </p>

            <button
              v-if="storeLogin.loginSuccess"
              href="#"
              class="btn btn-dark"
              @click="onClickNew()"
            >
              Megrendelés
            </button>
          </div>
        </div>
      </div>
    </div>

    <!--#region Modal -->
    <!-- Button trigger modal -->
    <button
      type="button"
      class="btn btn-primary"
      data-bs-toggle="modal"
      data-bs-target="#exampleModal"
    >
      Launch demo modal
    </button>

    <!-- Modal -->
    <div
      class="modal fade"
      id="exampleModal"
      tabindex="-1"
      aria-labelledby="exampleModalLabel"
      aria-hidden="true"
    >
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h1 class="modal-title fs-5" id="exampleModalLabel">Modal title</h1>
            <button
              type="button"
              class="btn-close"
              data-bs-dismiss="modal"
              aria-label="Close"
            ></button>
          </div>
          <div class="modal-body">...</div>
          <div class="modal-footer">
            <button
              type="button"
              class="btn btn-secondary"
              data-bs-dismiss="modal"
            >
              Close
            </button>
            <button type="button" class="btn btn-primary">Save changes</button>
          </div>
        </div>
      </div>
    </div>
    <!--#endregion Modal -->
  </div>
</template>

<script>
import * as bootstrap from "bootstrap";
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
      stateTitle: "modalcim",
      modal: null,
      form: null,
    };
  },
  mounted() {
    this.getPizzas();
    this.modal = new bootstrap.Modal(document.getElementById("exampleModal"), {
      keyboard: false,
    });

    this.form = document.querySelector(".needs-validation");
  },
  watch: {
    keresoszo() {
      if (this.keresoszo.trim()) {
        this.getPizzasSzur();
      } else {
        this.getPizzas();
      }
    },
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
    onClickNew() {
      this.state = "new";
      // this.currentId = null;
      // this.editablePizza = new Pizza();
      this.modal.show();
    },
    onClickCancel() {
      this.modal.hide();
    },
    onClickSave() {
      this.modal.hide();
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