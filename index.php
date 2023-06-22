<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <?php include 'php/link.php' ?>
    <link rel="stylesheet" href="./styles/index.css">
    <script src="/js/index.js" defer></script>
    <title>Freddy's &middot; Home</title>
  </head>
  <body>
    <?php include "./php/header.php" ?>

    <main class="main">
      <section class="intro-sect" id="introSect">
        <input type="button" value="&#11164;" class="carousel-arrow left-arrow" id="carouselPrev">
        <input type="button" value="&#11166;" class="carousel-arrow right-arrow" id="carouselNext">
        <div class="intro-container">
          <div class="intro-card">
            <h2 class="intro-card-heading">FREDDY FAZBEAR</h2>
            <p class="intro-card-text">Experience the magic of animatronics with our premier rent service. From lifelike bears to enchanting bunnies, our high-quality animatronics will bring your event to life. Book now for an unforgettable experience!</p>
            <button class="intro-card-button">Book Now!</button>
          </div>
        </div>
      </section>
      <section class="recom-sect">
          <div class="recom-container">
            <div class="recom-card">
              <img src="img/fnaf/freddy_full_height.png" alt="freddy" class="recom-img" draggable="false">
              <div class="recom-holder freddy">
                <h3 class="recom-heading">FREDDY</h3>
                <p class="recom-text">Freddy Fazbear is an iconic animatronic, known for his charming appearance, catchy songs, and entertaining performances at his pizza place. </p>
              </div>
            </div>
            <div class="recom-card">
              <img src="img/fnaf/bonnie_full_height.png" alt="bonnie" class="recom-img" draggable="false">
              <div class="recom-holder bonnie">
                <h3 class="recom-heading">BONNIE</h3>
                <p class="recom-text">Bonnie is a captivating animatronic guitarist, characterized by his vibrant purple color, energetic stage presence, and mischievous glimmer in his eyes.</p>
              </div>
            </div>
            <div class="recom-card">
              <img src="img/fnaf/chica_full_height.png" alt="chica" class="recom-img" draggable="false">
              <div class="recom-holder chica">
                <h3 class="recom-heading">CHICA</h3>
                <p class="recom-text">Chica is a delightful animatronic chicken, radiating warmth with her bright yellow feathers and charmingly cheerful personality.</p>
              </div>
            </div>
            <div class="recom-card">
              <img src="img/fnaf/foxy_full_height.png" alt="foxy" class="recom-img" draggable="false">
              <div class="recom-holder foxy">
                <h3 class="recom-heading">FOXY</h3>
                <p class="recom-text">Foxy is an electrifying animatronic pirate fox, exuding an air of mystery with his tattered appearance and fiery red mane.</p>
              </div>
            </div>
          </div>
      </section>
    </main>

    <?php include "./php/footer.php" ?>
  </body>
</html>