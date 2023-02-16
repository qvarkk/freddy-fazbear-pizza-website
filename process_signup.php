<?php

function validateRegistration() {
  if (empty($_POST["first_name"]) or empty($_POST["last_name"]) or empty($_POST["email"]) or empty($_POST["password"]) or empty($_POST["confpassword"])) {
    return true;
  } else {
    return false;
  }
}

function addUserToDatabase() {

  if (validateRegistration()) {
    header("Location: error.php");
  }

  $db = require("./database.php");

  $query = "INSERT INTO users (first_name, last_name, email, password)
            VALUES ($1, $2, $3, $4)";
  $password_hash = password_hash($_POST["password"], PASSWORD_DEFAULT);
  $result = pg_query_params($db, $query, array($_POST["first_name"], $_POST["last_name"], $_POST["email"], $password_hash));

  if (!$result) {
    header("Location: error.php");
  } else {
    header("Location: index.php");
    exit;
  }
}

addUserToDatabase();

?>