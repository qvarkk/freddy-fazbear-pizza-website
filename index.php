<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="./styles/header.css">
    <link rel="stylesheet" href="./styles/footer.css">
    <link rel="stylesheet" href="./styles/index_main.css">
    <link rel="stylesheet" href="./styles/style.css">
    <script src="./js/header.js" defer></script>
    <title>Freddy's &middot; Home</title>
  </head>
  <body>
    <?php include "./php/header.php" ?>

    <main class="main">
      <div class="carousel-container">
        <div class="carousel-filler">best offers carousel in future <?php if ($_POST["first_name"] != "") echo $_POST["first_name"]; ?></div>
      </div>
      <div class="promo-filler">
        <div class="promo-container">
          <div class="promo-texts">
            <p class="promo-code">FIRSTTIME2023</p>
            <p class="promo-desc">30% OFF ON YOUR FIRST ORDER IN THIS BEAUTIFUL NEW YEAR!</p>
          </div>
          <button type="button" class="promo-button">Order Now!</button>
        </div>
      </div>
    </main>

    <?php include "./php/footer.php" ?>
  </body>
</html>