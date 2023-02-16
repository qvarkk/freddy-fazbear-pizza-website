<main class="main">
  <div class="container">
    <h1 class="register-header">Register</h1>
    <form action="process_signup.php" method="post" class="form" id="registerForm">
      <label for="first_name">First Name</label>
      <input id="fNameInput" class="unfilled form-input fname-input" type="text" name="first_name" placeholder="John" pattern="^[A-Za-z\s]+" required>
      <label for="last_name">Last Name</label>
      <input id="lNameInput" class="unfilled form-input lname-input" type="text" name="last_name" placeholder="Doe" pattern="^[A-Za-z\s]+" required>
      <label for="email">Email Address</label>
      <input id="emailInput" class="unfilled form-input email-input" type="email" name="email" placeholder="JohnDoe@email.com" minlength="5" maxlength="148" required>
      <label for="password">Password</label>
      <input id="pwdInput" class="unfilled form-input pwd-input" type="password" name="password" placeholder="********" pattern="^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?!.*\s).*$" minlength="8" maxlength="32" required>
      <label for="confpassword">Confirm Password</label>
      <input id="confPwdInput" class="unfilled form-input conf-pwd-input" type="password" name="confpassword" placeholder="********" pattern="^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?!.*\s).*$" minlength="8" maxlength="32" required>
    </form>
    <p class="login-para">Already have an account? <a class="login-anchor" href="./login.php">Log In</a>.</p>
    <button form="registerForm" type="submit" class="register-btn" value="Verify" name="verify">Register</button>
  </div>
</main>