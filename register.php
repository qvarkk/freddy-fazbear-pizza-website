<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="shortcut icon" href="favicon.ico" type="image/x-icon">
  <link rel="stylesheet" href="./styles/header.css">
  <link rel="stylesheet" href="./styles/footer.css">
  <link rel="stylesheet" href="./styles/register_main.css">
  <link rel="stylesheet" href="./styles/style.css">
  <script src="./js/header.js" defer></script>
  <script src="./js/register_main.js" defer></script>
  <title>Freddy's &middot; Register</title>
</head>
<body>
  <?php include "./php/header.php"; ?>

  <main class="main">
    <div class="container">
      <h1 class="register-header">Register</h1>
      <form action="auth.php?register=1" method="post" class="form" id="registerForm" enctype="multipart/form-data">
        <label for="first_name">First Name</label>
        <input id="fNameInput" class="unfilled form-input fname-input" type="text" name="first_name" placeholder="Volodimir" pattern="^[A-Za-z\s]+" required>
        <label for="last_name">Last Name</label>
        <input id="lNameInput" class="unfilled form-input lname-input" type="text" name="last_name" placeholder="Zelensky" pattern="^[A-Za-z\s]+" required>
        <label for="email">Email Address</label>
        <input id="emailInput" class="unfilled form-input email-input" type="email" name="email" placeholder="Nyanyanya@edu.surgu.ru" minlength="5" maxlength="148" required>
        <label for="password">Password</label>
        <input id="pwdInput" class="unfilled form-input pwd-input" type="password" name="password" placeholder="********" pattern="^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?!.*\s).*$" minlength="8" maxlength="32" required>
        <label for="confpassword">Confirm Password</label>
        <input id="confPwdInput" class="unfilled form-input conf-pwd-input" type="password" name="confpassword" placeholder="********" pattern="^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?!.*\s).*$" minlength="8" maxlength="32" required>
        <label for="profile_picture">Profile Picture (only .png)</label>
        <input type="file" name="profile_picture" id="profilePicture" accept=".png">
      </form>
      <p class="login-para">Already have an account? <a class="login-anchor" href="./login.php">Log In</a>.</p>
      <button form="registerForm" type="submit" class="register-btn" value="Verify" name="verify">Register</button>
    </div>
  </main>

  <?php include "./php/footer.php" ?>
</body>
</html>