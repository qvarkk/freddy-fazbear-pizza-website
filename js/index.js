let carouselPrev = document.querySelector("#carouselPrev");
let carouselNext = document.querySelector("#carouselNext");
let introSect = document.querySelector("#introSect");

let urls = ["../img/fnaf/chica_in_corridor.jpg", "../img/fnaf/bonnie_in_dining.png"];
let counter = 0;
let timer = 10;

// делол эти преколы в час ночи почти, не бейте и не смейтесь надо мной пжпжпжпжпж

carouselNext.addEventListener("click", () => {
  introSect.style.backgroundImage = `url("${urls[counter]}")`;
  timer = 10;
  if (counter === 1) {
    counter = 0;
  } else {
    counter = 1;
  }
});

carouselPrev.addEventListener("click", () => {
  introSect.style.backgroundImage = `url("${urls[counter]}")`;
  timer = 10;
  if (counter === 1) {
    counter = 0;
  } else {
    counter = 1;
  }
});

setInterval(() => {
  timer--;
  if (timer === 0) {
    timer = 10;
    introSect.style.backgroundImage = `url("${urls[counter]}")`;
    if (counter === 1) {
      counter = 0;
    } else {
      counter = 1;
    }
  }
}, 1000);

function handlePageResize() {
  if (window.innerWidth < 768) {
    carouselPrev.style.display = "none";
    carouselNext.style.display = "none";
  } else {
    carouselPrev.style.display = "inherit";
    carouselNext.style.display = "inherit";
  }
}

window.addEventListener("resize", handlePageResize);
handlePageResize();
