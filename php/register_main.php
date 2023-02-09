<main class="main">
  <h1 class="register-header">Register</h1>
  <form action="<?php echo $_SERVER["PHP_SELF"];  ?>" method="post">
    <input type="text" name="first_name" placeholder="First Name">
    <input type="text" name="last_name" placeholder="Last Name">
    <input type="email" name="email" placeholder="Email">
    <input type="password" name="password" placeholder="Password">
    <button value="Verify" name="verify">Register</button>
  </form>
</main>