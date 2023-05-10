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

    <!-- Modal -->
    <div
      class="modal fade"
      id="modalpizza"
      tabindex="-1"
      aria-labelledby="exampleModalLabel"
      aria-hidden="true"
    >
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h1 class="modal-title fs-5" id="exampleModalLabel">Rendelés</h1>
            <button
              type="button"
              class="btn-close"
              data-bs-dismiss="modal"
              aria-label="Close"
            ></button>
          </div>
          <div class="modal-body">
            <form>
              <div class="mb-3">
                <label for="name" class="form-label">Név</label>
                <input
                  type="text"
                  class="form-control"
                  id="name"
                  v-model="editableCimek.cimnev"
                  required
                />
              </div>
              <div class="mb-3">
                <label for="street" class="form-label">Utca</label>
                <input
                  type="text"
                  class="form-control"
                  id="street"
                  v-model="editableCimek.utca"
                  required
                />
              </div>
              <div class="mb-3">
                <label for="houseNumber" class="form-label">Házszám</label>
                <input
                  type="text"
                  class="form-control"
                  id="houseNumber"
                  v-model="editableCimek.hazszam"
                  required
                />
              </div>
            </form>
          </div>
          <div class="modal-footer">
            <button
              type="button"
              class="btn btn-danger"
              data-bs-dismiss="modal"
            >
              Bezárás
            </button>
            <button
              type="button"
              class="btn btn-secondary"
              @click="onClickSave()"
            >
              Mentés
            </button>
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

class Cimek {
  constructor(id = 0, nev = null, utca = null, hsz = null) {
    this.id = id;
    this.cimnev = nev;
    this.utca = utca;
    this.hazszam = hsz;
  }
}

export default {
  data() {
    return {
      keresoszo,
      storeUrl,
      cimek: [],
      editableCimek: new Cimek(),
      storeLogin,
      pizzasData: [],
      stateTitle: "modalcim",
      modal: null,
      state: "view",
      form: null,
    };
  },
  mounted() {
    this.getCimek();
    this.getPizzas();
    this.modal = new bootstrap.Modal(document.getElementById("modalpizza"), {
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
    async getCimek() {
      let url = this.storeUrl.urlCimek;
      const config = {
        method: "GET",
        headers: {
          Authorization: `Bearer ${this.storeLogin.accessToken}`,
        },
      };
      const response = await fetch(url, config);
      const data = await response.json();
      this.cimek = data.data;
      // this.cars = data.data.map((car) => {
      //   car.outOfTraffic = car.outOfTraffic === 1;
      //   return car;
      // });
    },

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
      this.modal.show();
    },
    onClickCancel() {
      this.modal.hide();
    },
    onClickSave() {
      console.log(this.editableCimek);

      // Reset form values
      this.editableCimek = new Cimek();

      // Bezárás
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