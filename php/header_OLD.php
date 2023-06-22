<?php

session_start(["use_strict_mode" => true]);

if (isset($_SESSION['email'])) {
  $link = 'profile.php';  
  $text = $_SESSION['email'];
  if ($_SESSION['pfp'] != 'NULL') {
    $pfp = 'data:image/png;base64,'.$_SESSION['pfp'];
  } else {
    $pfp = './img/default-pfp.jpg';
  }
} else {
  $link = 'login.php';
  $text = 'Login';
  $pfp = './img/default-pfp.jpg';
}

if (isset($_SESSION['message'])) {
  echo('
  <div class="server-notification" id="serverNotif">
    <p class="server-message">'.$_SESSION['message'].'</p>
  </div>
  ');
}

unset($_SESSION['message']);

?>

<header class="header">
  <a href="index.php"><img class="header-logo" src="./img/logo.png" draggable="false"></a>
  <img id="headerMenuBtn" class="header-menu-icon" src="./img/icons/side-menu.svg" alt="Menu" draggable="false">

  <div id="sidebarMenu" class="header-menu inactive">
    <div id="blackScreen" class="black-screen"></div>
    
    <div class="header-sidebar">
      <img id="sidebarMenuBtn"  class="sidebar-menu-icon" src="./img/icons/side-menu.svg" alt="Menu">
      <nav class="sidebar-nav">
        <a class="header-profile" href="<?php echo($link); ?>">
          <p class="sidebar-username">
          <?php echo($text); ?>
          </p>
          <img class="header-pfp" src="<?php echo $pfp; ?>" alt="Profile picture">
        </a>
        <a class="header-home" href="./index.php">Home</a>
        <a class="header-order" href="#">Order</a>
        <a class="header-card" href="#">Cart</a>
        <a class="header-locations" href="#">Places</a>
        <a class="header-news" href="#">News</a>
        <?php
          if (isset($_SESSION['email']))
            echo('<a class="header-news" href="auth.php?logout=1">Log Out</a>');
        ?>
      </nav>
    </div>
  </div>
</header>