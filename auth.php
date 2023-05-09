<?php

session_start(["use_strict_mode" => true]);
require('./php/database.php');

if (isset($_GET['logout'])) {
    session_unset();
    header("Location: ../index.php");
    die();
}

if (isset($_GET['register'])) {
    $users_query = $db->query("INSERT INTO general.users (first_name, last_name, active) VALUES ('".$_POST['first_name']."', '".$_POST['last_name']."', true)");
    $user_id_query = $db->query("SELECT MAX(id) FROM general.users");
    $user_id = $user_id_query->fetch();
    $creds_query = $db->query("INSERT INTO general.credentials (email, password, user_id, active) VALUES ('".strtolower($_POST['email'])."', '".md5($_POST['password'])."', ".$user_id['max'].", true)");

    $_SESSION['email'] = strtolower($_POST['email']);
    $_SESSION['user_id'] = $user_id['max'];
    header("Location: ../index.php");
    die();

} else if (isset($_POST['email'])) {
    $query = $db->query("SELECT * FROM general.credentials WHERE email = '".strtolower($_POST['email'])."' AND active = true");

    if ($row = $query->fetch())
    {
        if (md5($_POST["password"]) == $row['password']){
            $_SESSION['email'] = strtolower($row['email']);
            $_SESSION['user_id'] = $row['user_id'];
            header("Location: ../index.php");
            die();
        }
        else {
            $_SESSION['message'] = 'Вы ввели неправильный пароль!';
            header("Location: ../login.php");
            die();
        }
    }
    else {
        $_SESSION['message'] = 'Вы ввели неправильный логин!';
        header("Location: ../login.php");
        die();
    }

}

?>