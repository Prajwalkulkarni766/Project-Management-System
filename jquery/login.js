// function to login in system
function login() {
    // debugger;
    let user_email_add = document.getElementById("user_email_add").value;
    if (user_email_add == "") {
        document.getElementById("new-alert-msg").innerHTML = "Enter the email address";
        document.getElementById("new-alert").style.display = "block";
        return;
    }
    let allowed_email_add_letter = /^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$/;
    if (!user_email_add.match(allowed_email_add_letter)) {
        document.getElementById("new-alert-msg").innerHTML = "Enter the valid email address";
        document.getElementById("new-alert").style.display = "block";
        document.getElementById("user_email_add").focus();
        return;
    }
    let user_password = document.getElementById("user_password").value;
    if (user_password == "") {
        document.getElementById("new-alert-msg").innerHTML = "Enter the password";
        document.getElementById("new-alert").style.display = "block";
        return;
    }
    $.ajax({
        type: "post",
        url: "dal/dal_login_signup.php",
        data: {
            log_in: "log_in",
            user_email_add: user_email_add,
            user_password: user_password,
        },
        success: function (response) {
            // debugger;
            if (response == -1) {
                document.getElementById("new-alert-msg").innerHTML =
                    "Your login is restricted by your respective admin. So you can't login until and unless admin enable your login";
                document.getElementById("new-alert").style.display = "block";
            }
            else if (response > 0) {
                location.href = "home.php";
            } else {
                document.getElementById("new-alert-msg").innerHTML =
                    "Entered details are incorrect";
                document.getElementById("new-alert").style.display = "block";
            }
        },
    });
}

// function to validate email address
function validate_emailadd_of_login_window() {
    // debugger;
    let user_email_add = document.getElementById("user_email_add").value;
    let allowed_email_add_letter = /^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$/;
    if (user_email_add.match(allowed_email_add_letter)) {
      return;
    } else {
      document.getElementById("new-alert-msg").innerHTML = "Enter the valid email address";
      document.getElementById("new-alert").style.display = "block";
      document.getElementById("user_email_add").focus();
      return;
    }
  }