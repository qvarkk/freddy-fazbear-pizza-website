<?php
  $auth = false;
  echo $_POST["verify"];
  if (isset($_POST["verify"]) && $_POST["verify"] == "Verify") {
    $first_name = $_POST["first_name"];
    $last_name = $_POST["last_name"];
    $email = $_POST["email"];
    $password = $_POST["password"];

    $db = pg_connect("host=localhost port=5432 dbname=test_db user=postgres password=1111");
    if ($db) {
      $hash_passwd = password_hash($password,  PASSWORD_DEFAULT);
      $query = "INSERT INTO users (first_name, last_name, email, password) VALUES ($1, $2, $3, $4)";
      $result = pg_query_params($db, $query, array($first_name, $last_name, $email, $hash_passwd    ));
      if ($result) {
        $auth = true;
      }
    }
  }

  if ($auth) {
    header("Location: index.php");
    die();
  }
?>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="./styles/header.css">
  <link rel="stylesheet" href="./styles/footer.css">
  <link rel="stylesheet" href="./styles/register_main.css">
  <link rel="stylesheet" href="./styles/style.css">
  <script src="./js/index.js" defer></script>
  <title>Freddy's &middot; Register</title>
</head>
<body>
  <?php 
  require("./php/header.php");
  require("./php/register_main.php");
  require("./php/footer.php");
  ?>
</body>
</html>