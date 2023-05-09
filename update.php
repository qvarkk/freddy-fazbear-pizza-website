<?php

session_start(["use_strict_mode" => true]);
require('./php/database.php');

if (isset($_POST['first_name'])) {
  $creds_query = $db->query("SELECT * FROM general.credentials WHERE email = '".strtolower($_SESSION['email'])."'");
  $creds_row = $creds_query->fetch();

  $update_query = $db->query("UPDATE general.users SET first_name = '".$_POST['first_name']."', last_name = '".$_POST['last_name']."' WHERE id = ".$creds_row['user_id']);

  $_SESSION['message'] = "Name was updated successfully.";
  header('Location: profile.php?option=1');
  die();

} else if (isset($_POST['email'])) {
  $select_query = $db->query("SELECT * FROM general.credentials WHERE user_id = ".$_SESSION['user_id']." AND active = true");

  if ($row = $select_query->fetch()) {
    if ($_POST['email'] == $row['email']) {
      $_SESSION['message'] = 'Your new email is the same as current one.';
    } else {
      $update_query = $db->query("UPDATE general.credentials SET active = false WHERE user_id = ".$_SESSION['user_id']." AND active = true");
      $insert_query = $db->query("INSERT INTO general.credentials (email, password, user_id, active) VALUES ('".$_POST['email']."', '".$row['password']."', ".$_SESSION['user_id'].", true)");
      $_SESSION['email'] = $_POST['email'];
      $_SESSION['message'] = "Email was updated successfully.";
    }
  }

  header('Location: profile.php?option=1');
  die();

} else if (isset($_POST['password'])) {
  $select_query = $db->query("SELECT * FROM general.credentials WHERE user_id = ".$_SESSION['user_id']);
  $select_w = $select_query->fetch();
  $dupe_flag = false;

  if ($_POST['password'] != $_POST['conf_password']) {
    $_SESSION['message'] = "Confirmation password is wrong.";
    header('Location: profile.php?option=1');
    die();
  }

  if ($select_w['password'] == md5($_POST['old_password'])) {
    if ($row = $select_query->fetch()) {
      foreach ($one as $row) {
        if ($one['password'] == md5($_POST['password'])) {
          $dupe_flag = true;
        }
      }

      if (!$dupe_flag) {
        $update_query = $db->query("UPDATE general.credentials SET active = false WHERE user_id = ".$_SESSION['user_id']." AND active = true");
        $insert_query = $db->query("INSERT INTO general.credentials (email, password, uder_id, active) VALUES ('".$_SESSION['email']."', '".$_POST['password']."', ".$_SESSION['user_id'].", true)");
        $_SESSION['message'] = 'Password was updated successfully.';
      } else {
        $_SESSION['message'] = 'This password was already in use before. Enter new one.';
      }
    }
  } else {
    $_SESSION['message'] = "Wrong old password entered.";
  }

  header('Location: profile.php?option=1');
  die();

} else if (isset($_POST['number'])) {
  $creds_query = $db->query("SELECT * FROM general.credentials WHERE email = '".strtolower($_SESSION['email'])."'");
  $creds_row = $creds_query->fetch();

  $update_query = $db->query("UPDATE general.users SET phone_num = ".$_POST['number']);

  header('Location: profile.php?option=1');
  die();

} else {
  $_SESSION['message'] = "Some error occurred while changing your data.";
  header('Location: profile.php?option=1');
  die();
}

?>