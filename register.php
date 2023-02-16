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
  <?php
  echo $_POST["error"];
  require("./php/header.php");
  require("./php/register_main.php");
  require("./php/footer.php");
  ?>
</body>
</html>