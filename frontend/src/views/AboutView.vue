<template>
  <div class="about-section">
    <div class="about-header">
      <h1>Rólunk</h1>
    </div>
    <div class="about-content">
      <p>
        Üdvözöljük a pizzaimádók közösségében! A mi weboldalunk azért jött
        létre, hogy összehozzuk azokat, akik szenvedélyesen szeretik a pizzát.
        Az oldalunkon megtalálhatóak a legjobb pizzák, és azok a receptek,
        amelyeket a világ minden táján nagyra értékelnek.
      </p>
      <p>
        Nálunk megtalálja az összes klasszikus pizzát, valamint az újabb ízeket
        és különlegességeket is. Minden pizzánk friss, kiváló minőségű
        összetevőkből készül. Szakácsaink az egész világból származnak, így
        minden pizzánk egyedülálló ízvilággal rendelkezik.
      </p>
      <p>
        A weboldalunkon található receptek lépésről-lépésre bemutatják, hogyan
        készítheti el a pizzát otthon, az egyszerűbb verzióktól a különlegesebb
        ízekig. Ezenkívül az oldalon lehetősége van arra, hogy a kedvenc pizzáit
        rendelje meg a legjobb helyi pizzériákból, és kiváló minőségű ételekhez
        juthasson.
      </p>
      <p>
        Ha Ön is szenvedélyesen szereti a pizzát, akkor a mi oldalunk az Ön
        számára készült. Várjuk Önt szeretettel a közösségünkben!
      </p>
    </div>
  </div>
</template>
<script setup>
</script>
<style>
.about-section {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 2rem;
}

.about-header h1 {
  font-size: 3rem;
  text-align: center;
  margin-bottom: 2rem;
}

.about-content {
  max-width: 800px;
  text-align: justify;
}

 @media screen and (max-width: 768px) {
  .about-header h1 {
    font-size: 2rem;
  }

  .about-content {
    font-size: 0.8rem;
    line-height: 1.2rem;
  }

}
</style>