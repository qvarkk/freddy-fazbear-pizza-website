<div class="settings">
  <div class="names-settings">
    <p class="info-text">Name:</p>
    <p class="text-para">
      <?php
        echo($user_row['first_name']." ".$user_row['last_name']);
      ?>
    </p>
    <button class="change-btn" id="nameChgBtn">Change</button>
  </div>
  <div class="email-settings">
    <p class="info-text">Email:</p>
    <p class="text-para">
      <?php
        echo($creds_row['email']);
      ?>
    </p>
    <button class="change-btn" id="emailChgBtn">Change</button>
  </div>
  <div class="password-settings">
    <p class="info-text">Password:</p>
    <p class="text-para">
      &middot;&middot;&middot;&middot;&middot;&middot;&middot;&middot;
    </p>
    <button class="change-btn" id="passwordChgBtn">Change</button>
  </div>
  <div class="phone-settings">
    <p class="info-text">Phone Number:</p>
    <p class="text-para">
      <?php
        if ($user_row['phone_num'] == null) {
          echo('No number connected');
        } else {
          echo("+".$user_row['phone_num']);
        }
      ?>
    </p>
    <button class="change-btn" id="numberChgBtn">Change</button>
  </div>
</div>

<dialog class="name-change-dialog dialog" id="nameDialog">
  <form class="name-change-form form" action="update.php" method="post">
    <div class="change-inputs">
      <div>
        <label for="firstName">First Name</label>
        <input type="text" name="first_name" id="firstName" pattern="^[A-Za-z\s]+" required>
      </div>
      <div>
        <label for="lastName">Last Name</label>
        <input type="text" name="last_name" id="lastName" pattern="^[A-Za-z\s]+" required>
      </div>
    </div>
    <button class="update-btn">Update</button>
  </form>
</dialog>

<dialog class="email-change-dialog dialog" id="emailDialog">
  <form class="email-change-form form" action="update.php" method="post">
    <div class="change-inputs">
      <div>
        <label for="email">Email</label>
        <input type="email" name="email" id="email" required>
      </div>
    </div>
    <button class="update-btn">Update</button>
  </form>
</dialog>

<dialog class="password-change-dialog dialog" id="passwordDialog">
  <form class="password-change-form form" action="update.php" method="post">
    <div class="change-inputs">
      <div>
        <label for="oldPassword">Old Password</label>
        <input type="password" name="old_password" id="oldPassword" pattern="^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?!.*\s).*$" minlength="8" maxlength="32" required>
      </div>
      <div>
        <label for="newPassword">New Password</label>
        <input type="password" name="password" id="newPassword" pattern="^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?!.*\s).*$" minlength="8" maxlength="32" required>
      </div>
      <div>
        <label for="confPassword">Confirm Password</label>
        <input type="password" name="conf_password" id="confPassword" pattern="^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?!.*\s).*$" minlength="8" maxlength="32" required>
      </div>
    </div>
    <button class="update-btn">Update</button>
  </form>
</dialog>

<dialog class="number-change-dialog dialog" id="numberDialog">
  <form class="number-change-form form" action="update.php" method="post">
    <div class="change-inputs">
      <div>
        <label for="number">Phone Number</label>
        <input type="number" name="number" id="number" required>
      </div>
    </div>
    <button class="update-btn">Update</button>
  </form>
</dialog>

<script src="./js/profile_settings.js"></script>