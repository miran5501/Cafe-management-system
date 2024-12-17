// Hover the current url's icon
$(function (){
  const path = window.location.pathname;
  if(path === "/index.html"){
    $('.navbar .services ul li:nth-of-type(1) a')
      .css('background-color', 'var(--secondary-color)')
      .css('border', 'none')
      .css('border-radius', '5px')
  }
})

// Slider For Hero Component
$(function () {
  //config
  const width = "100vw";
  const animSpeed = 500;
  const pause = 3000;
  let currentSlide = 1;

  // cache DOM
  const $slider = $(".hero .slider");
  const $sliderContainer = $slider.find(".slides");
  const $slide = $sliderContainer.find(".slide");

  // set animation
  let interval;
  function startSlider() {
    interval = setInterval(() => {
      $sliderContainer.animate(
        { "margin-left": "-=" + width },
        animSpeed,
        () => {
          currentSlide++;
          if (currentSlide === $slide.length) {
            currentSlide = 1;
            $sliderContainer.css("margin-left", 0);
          }
        }
      );
    }, pause);
  }

  function pauseSlider() {
    clearInterval(interval);
  }

  $slider.on("mouseenter", pauseSlider).on("mouseleave", startSlider);
  startSlider();
});


//Load Categories from json
$(function () {
  const $categoryGrid = $(".categories .grid");
  $.getJSON('./categories.json', function(categories) {
    categories.forEach(category => {
      $categoryGrid.append(
        `<div class="category btn centered">
          <img src=${category.image} alt="new" width="48px">
          <p>${category.name}</p>
        </div>`
      );
    });
  }) 
});

//Load favorite products from json
$(function () {
  const $favoritesGrid = $(".favorites .grid");
  $.getJSON('./favorites.json', function(products) {
    products.forEach(product => {
      $favoritesGrid.append(
        `<div class="flex centered">
          <div class="product-img">
            <img class="btn" src=${product.image} alt="" width="120px" height="120px">
            <button class="plus"><span>&#65291</span></button>
          </div>
          <div class="prices">
            <span class="old-price">${product.oldPrice}</span>
            <span class="new-price">${product.currentPrice}</span>
          </div>
          <span class="name">${product.name}</span>
          <span class="size">${product.size}</span>
        </div>`
      );
    });
  }) 
});