<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="shortcut icon" href="favicon.ico" type="image/x-icon">
  <?php include "php/link.php" ?>
  <link rel="stylesheet" href="styles/login.css">
  <title>Freddy's &middot; Login</title>
</head>
<body>
  
  <?php
    include "./php/header.php";

    if (isset($_SESSION['email'])) {
      $_SESSION['message'] = "You're already logged in!";
      header("Location: index.php");
      die();
    }
  ?>

  <main class="main">
    <div class="container">
    <input type="checkbox" name="name" id="methodCheck">
      <div class="login-module">
        <h1 class="login-header">Login</h1>
        <form action="auth.php" method="POST" class="login-form" id="loginForm">
          <input class="unfilled form-input email-linput" type="email" name="email" placeholder="E-mail" minlength="5" maxlength="148" required>
          <input class="unfilled form-input pwd-linput" type="password" name="password" placeholder="Password" minlength="8" maxlength="32" required>
          <button form="loginForm" type="submit" class="submit-btn" name="login">Login</button>
          <button class="swap-btn" type="button" onclick="document.querySelector('#methodCheck').click()">Register</button>
        </form>
      </div>
      <div class="register-module">
        <h1 class="register-header">Register</h1>
        <form action="auth.php?register=1" method="post" class="register-form" id="registerForm" enctype="multipart/form-data">
          <input class="unfilled form-input fname-rinput" type="text" name="first_name" placeholder="First Name" pattern="^[A-Za-z\s]+" required>
          <input class="unfilled form-input lname-rinput" type="text" name="last_name" placeholder="Last Name" pattern="^[A-Za-z\s]+" required>
          <input class="unfilled form-input email-rinput" type="email" name="email" placeholder="E-mail" minlength="5" maxlength="148" required>
          <input class="unfilled form-input pwd-rinput" type="password" name="password" placeholder="Password" pattern="^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?!.*\s).*$" minlength="8" maxlength="32" required>
          <input class="unfilled form-input conf-pwd-rinput" type="password" name="confpassword" placeholder="Confirm Password" pattern="^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?!.*\s).*$" minlength="8" maxlength="32" required>
          <!-- <input class="file-input" type="file" name="profile_picture" id="profilePicture" accept=".png"> -->
          <label class="file-label">
            <input class="file-input" type="file" name="profile_picture" id="profilePicture" accept=".png">
            Upload PFP
          </label>
          <button form="registerForm" type="submit" class="submit-btn" name="register">Register</button>
          <button class="swap-btn" type="button" onclick="document.querySelector('#methodCheck').click()">Login</button>
        </form>
      </div>
    </div>
  </main>

  <?php include "./php/footer.php" ?>
</body>
</html>