let nameDialog = document.querySelector("#nameDialog");
let nameChgBtn = document.querySelector("#nameChgBtn");

nameChgBtn.addEventListener('click', () => {
  nameDialog.showModal();
});

let emailDialog = document.querySelector("#emailDialog");
let emailChgBtn = document.querySelector("#emailChgBtn");

emailChgBtn.addEventListener('click', () => {
  emailDialog.showModal();
});

let passwordDialog = document.querySelector("#passwordDialog");
let passwordChgBtn = document.querySelector("#passwordChgBtn");

passwordChgBtn.addEventListener('click', () => {
  passwordDialog.showModal();
});

let numberDialog = document.querySelector("#numberDialog");
let numberChgBtn = document.querySelector("#numberChgBtn");

numberChgBtn.addEventListener('click', () => {
  numberDialog.showModal();
});

let dialogs = [nameDialog, emailDialog, passwordDialog, numberDialog];
dialogs.forEach(dialog => {
  dialog.addEventListener("click", e => {
    const dialogDimensions = dialog.getBoundingClientRect()
    if (
      e.clientX < dialogDimensions.left ||
      e.clientX > dialogDimensions.right ||
      e.clientY < dialogDimensions.top ||
      e.clientY > dialogDimensions.bottom
    ) {
      dialog.close()
    }
  })
});