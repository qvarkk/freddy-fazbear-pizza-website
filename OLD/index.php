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
    <div class="header-left-side">
      <img class="header-logo" src="./img/logo.png">
    </div>
    <nav class="header-center">
      <a class="header-home" href="">Home</a>
      <a class="header-order" href="">Order</a>
      <a class="header-locations" href="">Locations</a>
      <a class="header-news" href="">News</a>
    </nav>

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
         <img class="header-cart" src="./img/icons/shopping-cart.svg" alt="Cart">
       </a>
     </div>
  </header>
  
  <main class="main">
    <div class="carousel-container">
      <div class="carousel-filler">best offers carousel in future</div>
    </div>
    <div class="promo-filler">
      <div class="promo-container">
        <div class="promo-texts">
          <p class="promo-code">FIRSTTIME2023</p>
          <p class="promo-desc">30% OFF ON YOUR FIRST ORDER IN THIS BEAUTIFUL NEW YEAR!</p>
        </div>
        <button class="promo-button">Order Now!</button>
      </div>
    </div>
  </main>
  <footer class="footer">
    <div class="footer-container">
      <img class="footer-logo" src="./img/logo.png">
      <nav class="footer-nav">
        <a class="footer-home" href="">Home</a>
        <a class="footer-order" href="">Order</a>
        <a class="footer-locations" href="">Locations</a>
        <a class="footer-news" href="">News</a>
      </nav>
      <p class="footer-copy">&copy; Freddy Fazbear's Pizza | 1944-2023</p>
    </div>
  </footer>
</body>
</html>