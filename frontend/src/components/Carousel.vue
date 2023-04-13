<template>
  <div id="carouselExample" class="carousel slide position-relative" data-bs-ride="carousel">
    <div class="carousel-inner">
      <div class="carousel-item active">
        <img src="https://cdn.pixabay.com/photo/2017/12/09/08/18/pizza-3007395__480.jpg" id="kep" class="d-block w-100" alt="..." />
      </div>
      <div class="carousel-item">
        <img src="https://www.mokuslekvar.hu/wp-content/uploads/2022/04/pizza-9.jpg" id="kep" class="d-block w-100" alt="..." />
      </div>
      <div class="carousel-item">
        <img src="https://images8.alphacoders.com/644/thumb-1920-644361.jpg" id="kep" class="d-block w-100" alt="..." />
      </div>
    </div>
    <button
      class="carousel-control-prev"
      type="button"
      data-bs-target="#carouselExample"
      data-bs-slide="prev"
    >
      <span class="carousel-control-prev-icon" aria-hidden="true"></span>
      <span class="visually-hidden">Previous</span>
    </button>
    <button
      class="carousel-control-next"
      type="button"
      data-bs-target="#carouselExample"
      data-bs-slide="next"
    >
      <span class="carousel-control-next-icon" aria-hidden="true"></span>
      <span class="visually-hidden">Next</span>
    </button>

    <div class="position-absolute top-50 start-50 translate-middle">
      <h1 class="my-fs-cim"><span class="p-2 ps-4 pe-4 my-bg-cim">Pizzéria</span> </h1>
    </div>

  </div>
</template>

<script>
export default {};
</script>
<style>
.my-bg-cim {
  background-color: rgba(255,255,255,0.3);
  border-radius: 10px;
}
.my-fs-cim {
  font-size: 5rem;
  font-weight: normal;
}
#kep{
width: 1200px;
height: 300px;
}

</style>