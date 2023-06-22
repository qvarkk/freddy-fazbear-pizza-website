<?php

  session_start(["use_strict_mode" => true]);

  if (!isset($_SESSION['email'])) {
    header('Location: index.php');
    die();
  }

  if ($_SESSION['pfp'] != 'NULL') {
    $pfp = 'data:image/png;base64,'.$_SESSION['pfp'];
  } else {
    $pfp = './img/default-pfp.jpg';
  }

?>


<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <?php include_once 'php/link.php' ?>
  <link rel="stylesheet" href="./styles/profile_main.css">
  <script src="./js/profile.js" defer></script>
  <title>Freddy's &middot; Profile</title>
</head>
<body>
  <?php 
    include "./php/header.php";
    
    include_once "./php/database.php";

    $creds_query = $db->query("SELECT * FROM general.credentials WHERE email = '".$_SESSION['email']."'");
    $creds_row = $creds_query->fetch();

    $user_query = $db->query("SELECT * FROM general.users WHERE id = ".$_SESSION['user_id']);
    $user_row = $user_query->fetch();

    $orders_query = $db->query("SELECT COUNT(*) FROM general.orders WHERE user_id = ".$_SESSION['user_id']);
    $orders_row = $orders_query->fetch();
  ?>

  <main class="main">
    <div class="container">
      <div class="pf-info">
        <p class="pf-names"><?php echo($user_row['first_name']." ".$user_row['last_name']); ?></p>
        <p class="pf-email"><?php echo($_SESSION['email']); ?></p>
        <p class="pf-orders"><?php echo($orders_row['count']." orders"); ?></p>
      </div>
      <div class="pf-other">
        <div class="buttons-side">
          <img class="pfp" src="<?php echo $pfp; ?>" alt="Profile Picture">
          <button id="profBtn" class="profile-button" <?php if (!isset($_GET['option']) || $_GET['option'] == 1) echo('data-active'); ?>>Profile</button>
          <button id="addrBtn" class="addresses-button" <?php if (isset($_GET['option'])) { if ($_GET['option'] == 2) echo('data-active'); }  ?>>Addresses</button>
          <button id="ordrBtn" class="orders-button" <?php if (isset($_GET['option'])) { if ($_GET['option'] == 3) echo('data-active'); }  ?>>Orders</button>
          <button id="logoutBtn" class="logout-button"?>Logout</button>
        </div>
        <div class="info-side">
          <?php
            if (isset($_GET['option'])) {
              switch ($_GET['option']) {
                default:
                case 1:
                  include_once "./php/profile_settings.php";
                  break;
                case 2:
                  include_once "./php/profile_addresses.php";
                  break;
                case 3:
                  include_once "./php/profile_orders.php";
                  break;
              }
            } else {
              include_once "./php/profile_settings.php";
            }
          ?>
        </div>
      </div>
    </div>
  </main>
  <?php include "./php/footer.php" ?>
</body>
</html>