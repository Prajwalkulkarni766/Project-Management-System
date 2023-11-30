<!DOCTYPE html>
<html lang="en">

<head>
  <?php
  include 'login_signup_header.php';
  ?>
  <script src="jquery/signup.js"></script>
</head>

<body>
  <div class="w3-third w3-display-middle w3-padding w3-round-large" id="box_of_signup">
    <div class="w3-container">
      <h1 class="w3-center w3-xxlarge">Sign Up</h1>
      <div class="w3-section w3-bar">
        <div class="w3-bar-item group">
          <label class="">Username</label>
          <input class="w3-input w3-border w3-margin-bottom" maxlength="25" type="text" id="user_name" onchange="validate_username()" autofocus required>
          <b>
            <p id="username_msg" class="w3-text-red" style="display:none;"></p>
          </b>
        </div>
        <div class="w3-bar-item group">
          <label class="">Email Address</label>
          <input class="w3-input w3-border w3-margin-bottom" type="text" id="user_email_add" maxlength="30" onchange="validate_emailadd()" required>
          <b>
            <p id="email_msg" class="w3-text-red" style="display:none;"></p>
          </b>
        </div>
        <div class="w3-bar-item group">
          <label class="">Passwrod</label>
          <input class="w3-input w3-border w3-margin-bottom" maxlength="8" type="password" id="user_password" onchange="validate_password()" required>
          <b>
            <p id="password_msg" class="w3-text-red" style="display:none;"></p>
          </b>
        </div>
        <div class="w3-bar-item group">
          <label class="">Renter Passwrod</label>
          <input class="w3-input w3-border w3-margin-bottom" maxlength="8" type="password" id="user_rentered_password" onchange="validate_rentered_password()" required>
          <b>
            <p id="rentered_password_msg" class="w3-text-red" style="display:none;"></p>
          </b>
        </div>
        <div class="w3-bar-item group">
          <b>
            <p id="problem_msg" class="w3-text-red" style="display:none;"></p>
          </b>
        </div>
        <div class="w3-bar-item group">
          <button class="w3-col l12 m12 s12 w3-button w3-padding w3-section w3-right w3-text-black" type="button" onclick="signup()">Sign Up</button>
        </div>
        <div class="w3-bar-item group">
          <div class="w3-center">
            <div class="text-center">Already have an account? <a href="login.php">Log In</a></div>
          </div>
        </div>
      </div>
    </div>
  </div>
</body>

</html>