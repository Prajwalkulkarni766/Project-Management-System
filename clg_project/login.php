<!DOCTYPE html>
<html lang="en">

<head>
  <?php
  include 'login_signup_header.php';
  ?>
  <script src="jquery/login.js"></script>
</head>

<body>

  <div class="w3-third w3-display-middle w3-padding w3-round-large">
    <form class="w3-container" autocomplete="off">
      <h1 class="w3-center w3-xxlarge">Log In</h1>
      <div class="w3-section w3-bar">
        <div class="w3-bar-item group">
          <label class="">User Email Address</label>
          <input class="w3-input w3-border w3-margin-bottom" maxlength="25" type="email" id="user_email_add" onchange="validate_emailadd_of_login_window()" autofocus required>
        </div>
        <div class="w3-bar-item group">
          <label class="">Password</label>
          <input class="w3-input w3-border w3-margin-bottom" maxlength="8" type="password" id="user_password" required>
        </div>
        <div class="w3-bar-item group">
          <button class="w3-col l12 m12 s12 w3-button w3-padding w3-section w3-right w3-text-black" type="button" onclick="login()">Login</button>
        </div>
        <div class="w3-bar-item group">
          <div class="w3-center">
            <div class="text-center">Don't have an account? <a href="signup.php">Sign up</a></div>
          </div>
        </div>
      </div>
    </form>
  </div>

</body>

</html>