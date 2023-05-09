let profBtn = document.querySelector("#profBtn");
let addrBtn = document.querySelector("#addrBtn");
let ordrBtn = document.querySelector("#ordrBtn");

profBtn.addEventListener('click', () => {
  window.location.replace("../profile.php?option=1");
});

addrBtn.addEventListener('click', () => {
  window.location.replace("../profile.php?option=2");
});

ordrBtn.addEventListener('click', () => {
  window.location.replace("../profile.php?option=3");
});
