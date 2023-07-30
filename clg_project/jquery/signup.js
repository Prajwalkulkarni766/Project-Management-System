// function to sign up
function signup() {
  // debugger;
  let user_name = document.getElementById("user_name").value;
  let user_contact_no = document.getElementById("user_contact_no").value;
  let user_gender_id = $('#user_gender option:selected').attr("id");
  let user_email_add = document.getElementById("user_email_add").value;
  let user_password = document.getElementById("user_password").value;
  let user_renter_password = document.getElementById("user_rentered_password").value;
  if (user_name == "" || user_name == " ") {
    document.getElementById("username_msg").style.display = "none";
    document.getElementById("username_msg").innerHTML =
      "*Please enter your name";
    document.getElementById("username_msg").style.display = "block";
    document.getElementById("user_name").focus();
    return;
  } else if (user_contact_no == "" || user_contact_no == " ") {
    document.getElementById("contact_no_msg").style.display = "none";
    document.getElementById("contact_no_msg").innerHTML =
      "*Please enter your contact number";
    document.getElementById("contact_no_msg").style.display = "block";
    document.getElementById("user_contact_no").focus();
    return;
  } else if (user_email_add == "" || user_email_add == " ") {
    document.getElementById("email_msg").style.display = "none";
    document.getElementById("email_msg").innerHTML =
      "*Please enter your email address";
    document.getElementById("email_msg").style.display = "block";
    document.getElementById("user_email_add").focus();
    return;
  } else if (user_password == "" || user_password == " ") {
    document.getElementById("password_msg").style.display = "none";
    document.getElementById("password_msg").innerHTML =
      "*Please enter password";
    document.getElementById("password_msg").style.display = "block";
    document.getElementById("user_password").focus();
    return;
  } else if (user_renter_password == "" || user_renter_password == " ") {
    document.getElementById("rentered_password_msg").style.display = "none";
    document.getElementById("rentered_password_msg").innerHTML =
      "*Please renter password";
    document.getElementById("rentered_password_msg").style.display = "block";
    document.getElementById("user_rentered_password").focus();
    return;
  }
  if (user_password == user_renter_password && document.getElementById("username_msg").style.display == "none" && document.getElementById("contact_no_msg").style.display == "none" && document.getElementById("email_msg").style.display == "none" && document.getElementById("password_msg").style.display == "none" && document.getElementById("rentered_password_msg").style.display == "none") {
    $.ajax({
      type: "post",
      url: "dal/dal_login_signup.php",
      data: {
        sign_up: "sign_up",
        user_name: user_name,
        user_contact_no: user_contact_no,
        user_gender_id: user_gender_id,
        user_email_add: user_email_add,
        user_password: user_password,
      },
      success: function (response) {
        // debugger;
        if (response > 0) {
          sessionStorage.setItem("new_user", "true");
          location.href = "home.php";
        } else {
          document.getElementById("problem_msg").innerHTML =
            "There is problem while sign up";
        }
      },
    });
  }
}

// function to vaildate username
function validate_username() {
  // debugger;
  let user_name = document.getElementById("user_name").value;
  let allowed_text_letters = /^[A-Za-z]+$/;
  if (user_name.match(allowed_text_letters)) {
    document.getElementById("username_msg").style.display = "none";
  } else {
    document.getElementById("username_msg").innerHTML =
      "*Only alphabets are allowed";
    document.getElementById("username_msg").style.display = "block";
    document.getElementById("user_name").focus();
    return;
  }
}

// function to validate contactno
function validate_contactno() {
  // debugger;
  let user_contact_no = document.getElementById("user_contact_no").value;
  let allowed_contact_no_letter = /^[0-9]+$/;
  if (user_contact_no.match(allowed_contact_no_letter)) {
    document.getElementById("contact_no_msg").style.display = "none";
  } else {
    document.getElementById("contact_no_msg").innerHTML =
      "*Only numericals are allowed";
    document.getElementById("contact_no_msg").style.display = "block";
    document.getElementById("user_contact_no").focus();
    return;
  }
  if (user_contact_no.length == 10) {
    document.getElementById("contact_no_msg").style.display = "none";
  } else {
    document.getElementById("contact_no_msg").innerHTML =
      "*Please enter your 10 digit contact number";
    document.getElementById("contact_no_msg").style.display = "block";
    document.getElementById("user_contact_no").focus();
    return;
  }
}

// function to validate emailadd
function validate_emailadd() {
  // debugger;
  let user_email_add = document.getElementById("user_email_add").value;
  let allowed_email_add_letter = /^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$/;
  if (user_email_add.match(allowed_email_add_letter)) {
    document.getElementById("email_msg").style.display = "none";
    $.ajax({
      type: "post",
      url: "dal/dal_login_signup.php",
      data: {
        check_entered_email_is_used_or_not: "check_entered_email_is_used_or_not",
        user_email_add: user_email_add,
      },
      success: function (response) {
        // debugger;
        if (response > 0) {
          document.getElementById("email_msg").innerHTML =
            "*Entered email address is already used by someone else. Please enter another and valid email address";
          document.getElementById("email_msg").style.display = "block";
          document.getElementById("user_email_add").focus();
        } else {
          document.getElementById("email_msg").style.display = "none";
        }
      },
    });
  } else {
    document.getElementById("email_msg").innerHTML =
      "*Please enter valid email address";
    document.getElementById("email_msg").style.display = "block";
    document.getElementById("user_email_add").focus();
    return;
  }
}

// function to validate password
function validate_password() {
  // debugger;
  let user_password = document.getElementById("user_password").value;
  let allowed_password_letter = /^(?=.*\d)(?=.*[A-Z])(.{8})$/;
  if (user_password.match(allowed_password_letter)) {
    document.getElementById("password_msg").style.display = "none";
  } else {
    document.getElementById("password_msg").innerHTML =
      "*Your password must contain alphanumeric and contain at least one number and one capital letter";
    document.getElementById("password_msg").style.display = "block";
    document.getElementById("user_password").focus();
    return;
  }
  if (user_password.length == 8) {
    document.getElementById("password_msg").style.display = "none";
  } else {
    document.getElementById("password_msg").innerHTML =
      "*Your password's length must be 8 character";
    document.getElementById("password_msg").style.display = "block";
    document.getElementById("user_password").focus();
    return;
  }
}

// function to validate rentered password
function validate_rentered_password() {
  // debugger;
  let user_password = document.getElementById("user_password").value;
  let user_renter_password = document.getElementById("user_rentered_password").value;
  if (user_password !== user_renter_password) {
    document.getElementById("rentered_password_msg").innerHTML =
      "*Please enter same password as like entered in password input";
    document.getElementById("rentered_password_msg").style.display = "block";
    document.getElementById("user_rentered_password").focus();
    return;
  }
}