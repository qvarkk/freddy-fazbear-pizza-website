<?php

$host = "localhost";
$port = "5432";
$db_name = "freddys";
$user = "postgres";
$pwd = "1111";

$db = pg_connect("host=$host port=$port dbname=$db_name user=$user password=$pwd");

if (!$db) {
  die("Couldn't connect to the database... Try again later.");
}

return $db;

?>