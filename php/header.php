<?php

session_start(["use_strict_mode" => true]);

if (isset($_SESSION['email'])) {
  $link = 'profile.php';  
  $text = 'Profile';
} else {
  $link = 'login.php';
  $text = 'Login';
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
  <nav class="nav">
    <input type="checkbox" id="headerCheck">
    <label for="headerCheck" class="header-check-btn">
      <img src="/img/icons/side-menu.svg" class="header-check-img">
    </label>
    <a href="../index.php"><p class="nav-logo">FREDDY'S</p></a>
    <ul class="nav-list">
      <li class="nav-item"><a href="../index.php" class="nav-link">Home</a></li>
      <li class="nav-item"><a href="<?php echo $link; ?>" class="nav-link"><?php echo $text; ?></a></li>
      <li class="nav-item"><a href="#" class="nav-link">Rent</a></li>
      <li class="nav-item"><a href="#" class="nav-link">Contact Us</a></li>
    </ul>
  </nav>
</header>