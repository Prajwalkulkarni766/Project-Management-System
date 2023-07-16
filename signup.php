<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Sign Up</title>
  <?php
    include 'login_signup_header.php';
  ?>
  <style>
  #box_of_signup 
{
  font-family:Arial; 
  background: -webkit-linear-gradient(to right, #155799, #159957); 
  background: linear-gradient(to right, #155799, #159957); 
  color:whitesmoke;
}  
  </style>

</head>

<body>
<p></p>
  <div class="w3-third w3-display-middle w3-padding w3-round-large" id="box_of_signup">
    <div class="w3-container">
      <h1 class="w3-center w3-xxlarge w3-text-white">Sign Up</h1>
      <div class="w3-section w3-bar">
        <div class="w3-bar-item group">
          <label class="">Username</label>
          <input class="w3-input w3-border w3-margin-bottom" maxlength="25" type="text" id="user_name" onchange="validate_username()" autofocus required>
          <b>
            <p id="username_msg" class="w3-text-red" style="display:none;"></p>
          </b>
        </div>
        <div class="w3-bar-item group">
          <label class="">Contact Number</label>
          <input class="w3-input w3-border w3-margin-bottom" maxlength="10" type="text" id="user_contact_no" onchange="validate_contactno()" required>
          <b>
            <p id="contact_no_msg" class="w3-text-red" style="display:none;"></p>
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
          <input class="w3-input w3-border w3-margin-bottom" maxlength="8" type="password" id="user_rentered_password" required>
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