<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="./style.css">
  <link rel="shortcut icon" href="favicon.ico" type="image/x-icon">
  <script src="./main.js" defer></script>
  <title>Freddy Fazbear Pizza</title>
</head>
<body>
  <header class="header">
    <div class="header-container">
      <div class="header-left-side">
        <img class="header-logo" src="./img/logo.png" alt="">
      </div>
      <div class="header-center">
        <a class="header-home" href="">Home</a>
        <a class="header-order" href="">Order</a>
        <a class="header-locations" href="">Locations</a>
        <a class="header-news" href="">News</a>
      </div>

      <div class="header-right-side">
        <div class="header-profile">
          <img class="header-pfp" id="headerMenuBtn" src="./img/default-pfp.jpg" alt="Profile picture">
          <div class="header-pf-menu inactive" id="headerMenu">
            <a class="header-pf-profile" href="">Profile</a>
            <a class="header-pf-settings" href="">Settings</a>
            <a class="header-pf-logout" href="">Log Out</a>
          </div>
        </div>
        <a class="header-cart" href="">
          <img src="./img/icons/shopping-cart.svg" alt="Cart">
        </a>
      </div>
    </div>
  </header>
  
  <main class="main"></main>
  <footer class="footer"></footer>
</body>
</html>