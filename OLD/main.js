let headerMenu = document.querySelector('#headerMenu');
let headerMenuBtn = document.querySelector('#headerMenuBtn');
headerMenuBtn.addEventListener('click', () => {
  headerMenu.classList.toggle('inactive');
});
