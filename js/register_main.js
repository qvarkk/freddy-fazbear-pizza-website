var fNameInput = document.querySelector("#fNameInput");
var lNameInput = document.querySelector("#lNameInput");
var emailInput = document.querySelector("#emailInput");
var pwdInput = document.querySelector("#pwdInput");
var confPwdInput = document.querySelector("#confPwdInput");

function unblankField(field) {
  field.addEventListener("input", () => {
    if (field.value.length > 0) {
      field.classList.remove("unfilled");          
    }
  });
}

unblankField(fNameInput);
unblankField(lNameInput);
unblankField(emailInput);
unblankField(pwdInput);
unblankField(confPwdInput);