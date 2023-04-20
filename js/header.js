let sidebarMenu = document.querySelector('#sidebarMenu');
let headerMenuBtn = document.querySelector('#headerMenuBtn');
let sidebarMenuBtn = document.querySelector('#sidebarMenuBtn');
let blackScreen = document.querySelector("#blackScreen");

headerMenuBtn.addEventListener('click', () => {
  sidebarMenu.classList.remove("inactive");
});

sidebarMenuBtn.addEventListener('click', () => {
  sidebarMenu.classList.add("inactive");
});

blackScreen.addEventListener('click', () => {
  sidebarMenu.classList.add("inactive");
});
