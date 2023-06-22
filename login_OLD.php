<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="shortcut icon" href="favicon.ico" type="image/x-icon">
  <link rel="stylesheet" href="./styles/header.css">
  <link rel="stylesheet" href="./styles/footer.css">
  <link rel="stylesheet" href="./styles/login_main.css">
  <link rel="stylesheet" href="./styles/style.css">
  <script src="./js/header.js" defer></script>
  <title>Freddy's &middot; Login</title>
</head>
<body>
  
  <?php
    include "./php/header.php";

    if (isset($_SESSION['email'])) {
      header("Location: index.php");
      die();
    }
  ?>
  <main class="main">
    <div class="container">
      <h1 class="register-header">Login</h1>
      <form action="auth.php" method="POST" class="form" id="registerForm">
        <label for="email">Email Address</label>
        <input id="emailInput" class="unfilled form-input email-input" type="email" name="email" placeholder="Nyanyanya@edu.surgu.ru" minlength="5" maxlength="148" required>
        <label for="password">Password</label>
        <input id="pwdInput" class="unfilled form-input pwd-input" type="password" name="password" placeholder="********" minlength="8" maxlength="32" required>
      </form>
      <?php 
        if (isset($_SESSION['message']))
          echo($_SESSION['message']);
      ?>
      <p class="login-para">Don't have an account yet? <a class="login-anchor" href="./register.php">Register</a>.</p>
      <button form="registerForm" type="submit" class="register-btn" value="Verify" name="verify">Login</button>
    </div>
  </main>

  <?php include "./php/footer.php" ?>
</body>
</html>