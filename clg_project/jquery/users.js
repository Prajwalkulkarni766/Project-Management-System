let unsaved_arr = [];

// function to create str of profile
function create_profile_div(is_old, user_id, user_name, user_contact_no, user_email_add, user_gender, user_role, user_password, user_disabled) {
    // debugger;
    let profile = '<div id="div_for_';
    is_old == 1 ? profile += 'existing' : profile += 'new';
    profile += 'user_' + user_id + '" class="w3-container w3-margin-top w3-margin-bottom w3-col l3 m6 s12">';
    profile += '<header class="w3-container w3-bar w3-border w3-light-grey">';
    profile += '<div class="w3-container w3-center">';
    if (user_gender == 1) {
        profile += '<img src="img/male_avatar.png" alt="Avatar" class="w3-padding-small w3-circle w3-center" style="width:80px">';
    }
    else if (user_gender == 2) {
        profile += '<img src="img/female_avatar.png" alt="Avatar" class="w3-padding-small w3-circle w3-center" style="width:80px">';
    }
    else {
        profile += '<img src="img/other_avatar.png" alt="Avatar" class="w3-padding-small w3-circle w3-center" style="width:80px">';
    }
    profile += '</div>';
    profile += '</header>';
    profile += '<div class="w3-border w3-container">';
    profile += '<div class="w3-margin-bottom">';
    profile += '<div class="group w3-padding">';
    profile += '<label class="">Name : </label>';
    profile += '<input id="';
    is_old == 1 ? profile += 'existing' : profile += 'new';
    profile += "_user_name" + user_id + '" class="w3-input" type="text" maxlength="25" value="' + user_name + '">';
    profile += '</div>';
    profile += '<div class="group w3-padding">';
    profile += '<label class="">Contact Number : </label>';
    profile += '<input id="';
    is_old == 1 ? profile += 'existing' : profile += 'new';
    profile += "_user_contact_no" + user_id + '" class="w3-input" type="text" maxlength="10" value="' + user_contact_no + '">';
    profile += '</div>';
    profile += '<div class="group w3-padding">';
    profile += '<label class="">Email Address : </label>';
    profile += '<input id="';
    is_old == 1 ? profile += 'existing' : profile += 'new';
    profile += "_user_email_add" + user_id + '" class="w3-input" type="email" maxlength="30" value = "' + user_email_add + '" > ';
    profile += '</div>';
    profile += '<div class="group w3-padding"><label class="">Gender</label><select id="';
    is_old == 1 ? profile += 'existing' : profile += 'new';
    profile += '_user_gender' + user_id + '" class="w3-select w3-margin-bottom">';
    profile += '<option id="1"';
    user_gender == 1 ? profile += 'selected' : profile += ' ';
    profile += '>Male</option><option id="2"';
    user_gender == 2 ? profile += 'selected' : profile += ' ';
    profile += '>Female</option><option id="3"';
    user_gender == 3 ? profile += 'selected' : profile += ' ';
    profile += '>Other</option></select></div>';
    profile += '<div class="group w3-padding"><label class="">User Role : </label><select id="';
    is_old == 1 ? profile += 'existing' : profile += 'new';
    profile += '_user_role' + user_id + '" class="w3-select w3-margin-bottom">';
    profile += '<option id="2"';
    user_role == 2 ? profile += 'selected' : profile += ' ';
    profile += ' >Sub Admin</option><option id="3"';
    user_role == 3 ? profile += 'selected' : profile += ' ';
    profile += ' >Requirement Gatherer</option><option id="4"';
    user_role == 4 ? profile += 'selected' : profile += ' ';
    profile += ' >Developer</option><option id="5"';
    user_role == 5 ? profile += 'selected' : profile += ' ';
    profile += ' >Tester</option><option id="6"';
    user_role == 6 ? profile += 'selected' : profile += ' ';
    profile += ' disabled >Custom</option></select></div>';
    profile += '<div class="group w3-padding">';
    profile += '<label class="">Password : </label>';
    profile += '<input id="';
    is_old == 1 ? profile += 'existing' : profile += 'new';
    profile += '_user_password' + user_id + '" class="w3-input" type="password" maxlength="8" value="' + user_password + '">';
    profile += '</div>';
    profile += '<div class="group w3-padding">';
    profile += '<input class="w3-check" type="checkbox" onclick="show_password(';
    is_old == 1 ? profile += `${user_id}, 'existing'` : profile += `${user_id}, 'new'`;
    profile += ')"> &nbsp;&nbsp; Show Password';
    profile += '</div>';
    if (is_old == 1) {
        profile += '<div class="group w3-padding w3-center w3-large">';
        profile += '<input type="checkbox" id="existing_user_disabled_' + user_id + '" class="w3-check w3-xlarge" ';
        user_disabled == 1 ? profile += 'title="Disabled User" onchange="disable_or_enable_user(' + user_id + ')" checked' : profile += 'title="Enabled User" onchange="disable_or_enable_user(' + user_id + ')"';
        profile += ' >';
        profile += '<button onclick="save_changes(' + user_id + ')" class="w3-button w3-margin-left w3-hover-text-green w3-xlarge" title="Save Changes"><i class="fa fa-floppy-o" aria-hidden="true"></i></button>';
        profile += '</div>';
    }
    profile += '</div>';
    profile += '</div>';
    profile += '</div >';
    return profile;
}

// function to create new user
function create_new_user() {
    // debugger;
    let no_of_user = parseInt(document.getElementById("no_of_user").value);
    if (no_of_user > 0 && no_of_user != "") {
        $("#refresh_user_btn").attr("disabled", false);
        $("#save_user_btn").attr("disabled", false);
        let index_of_user = 0;
        while (index_of_user < no_of_user) {
            let profile = create_profile_div(0, index_of_user, "", "", "", "", "", "");
            document.getElementById("newly_created_user").innerHTML += profile;
            index_of_user++;
        }
    }
    else {
        document.getElementById("new-alert-msg").innerHTML =
            "Please enter number of user";
        document.getElementById("new-alert").style.display = "block";
        document.getElementById("no_of_user").value = "";
        document.getElementById("refresh_user_btn").disabled = true;
        document.getElementById("save_user_btn").disabled = true;
        document.getElementById("newly_created_user").innerHTML = " ";
    }
}

// function to refresh or reset the create user section
function refresh_new_user() {
    // debugger;
    unsaved_arr = [];
    $("#refresh_user_btn").attr("disabled", true);
    $("#save_user_btn").attr("disabled", true);
    document.getElementById("newly_created_user").innerHTML = " ";
    document.getElementById("no_of_user").value = "";
    document.getElementById("no_of_user").focus();
}

// function to save new user
function save_new_user(index_of_new_profile) {
    // debugger;
    let new_user_name = document.getElementById("new_user_name" + index_of_new_profile).value;
    let new_user_contact_no = document.getElementById("new_user_contact_no" + index_of_new_profile).value;
    let new_user_email_add = document.getElementById("new_user_email_add" + index_of_new_profile).value;
    let new_user_gender = $('#new_user_gender' + index_of_new_profile + ' option:selected').attr("id");
    let new_user_role = $('#new_user_role' + index_of_new_profile + ' option:selected').attr("id");
    let new_user_password = document.getElementById("new_user_password" + index_of_new_profile).value;
    $.ajax({
        type: "post",
        url: "dal/dal_users.php",
        data: {
            save_new_user: "save_new_user",
            new_user_name: new_user_name,
            new_user_contact_no: new_user_contact_no,
            new_user_email_add: new_user_email_add,
            new_user_gender: new_user_gender,
            new_user_role: new_user_role,
            new_user_password: new_user_password,
            index_of_new_profile: index_of_new_profile,
        },
        success: function (response) {
            // debugger;
            if (response >= 0) {
                document.getElementById("div_for_newuser_" + response).remove();
                document.getElementById("no_of_user").value = "";
                refresh_new_user();
            }
        },
    });
}

// function to fetch all related user
function get_users() {
    // debugger;
    document.getElementById("existing_created_user").innerHTML = " ";
    $.ajax({
        type: "post",
        url: "dal/dal_users.php",
        data: {
            get_users: "get_users",
        },
        success: function (response) {
            // debugger;
            if (response != "") {
                parsed_response = JSON.parse(response);
                let index_of_response = 0;
                while (index_of_response < parsed_response.length) {
                    let profile = create_profile_div(1, parsed_response[index_of_response]['user_id'], parsed_response[index_of_response]['user_name'], parsed_response[index_of_response]['user_contact_no'], parsed_response[index_of_response]['user_email_add'], parsed_response[index_of_response]['user_gender'], parsed_response[index_of_response]['user_role'], parsed_response[index_of_response]['user_password'], parsed_response[index_of_response]['user_disabled']);
                    document.getElementById("existing_created_user").innerHTML += profile;
                    index_of_response++;
                }
            }
        },
    });
}

// function to show password
function show_password(id, status) {
    // debugger;
    let password = document.getElementById(status + "_user_password" + id);
    if (password.type === "password") {
        password.type = "text";
    } else {
        password.type = "password";
    }
}

// function to toggle create user and view user tab
function open_another_tab(evt, name) {
    // debugger;
    var i, x, tablinks;
    x = document.getElementsByClassName("city");
    for (i = 0; i < x.length; i++) {
        x[i].style.display = "none";
    }
    tablinks = document.getElementsByClassName("tablink");
    for (i = 0; i < x.length; i++) {
        tablinks[i].className = tablinks[i].className.replace(" w3-dark-grey", "");
    }
    document.getElementById(name).style.display = "block";
    evt.currentTarget.className += " w3-dark-grey";
}

// function to validate email address
function validate_emailadd() {
    // debugger;
    document.getElementById("refresh_user_btn").disabled = true;
    let index_of_new_profile = 0;
    let total_no_of_profile = document.getElementById("no_of_user").value;
    while (index_of_new_profile < total_no_of_profile) {
        if (unsaved_arr != "") {
            index_of_new_profile = unsaved_arr.shift();
        }
        if (document.getElementById("new_user_name" + index_of_new_profile).value == "") {
            document.getElementById("new-alert-msg").innerHTML =
                "Please enter name of user where it is not filled";
            document.getElementById("new-alert").style.display = "block";
            document.getElementById("refresh_user_btn").disabled = false;
            return;
        }
        if (document.getElementById("new_user_contact_no" + index_of_new_profile).value == "") {
            document.getElementById("new-alert-msg").innerHTML =
                "Please enter contact number of user where it is not filled";
            document.getElementById("new-alert").style.display = "block";
            document.getElementById("refresh_user_btn").disabled = false;
            return;
        }
        else if (document.getElementById("new_user_contact_no" + index_of_new_profile).value.length != 10) {
            document.getElementById("new-alert-msg").innerHTML =
                "Please enter contact number of length 10 where it is not filled";
            document.getElementById("new-alert").style.display = "block";
            document.getElementById("refresh_user_btn").disabled = false;
            return;
        }
        else if (isNaN(document.getElementById("new_user_contact_no" + index_of_new_profile).value)) {
            document.getElementById("new-alert-msg").innerHTML =
                "Please enter valid contact number that contain only numeric values";
            document.getElementById("new-alert").style.display = "block";
            document.getElementById("refresh_user_btn").disabled = false;
            return;
        }
        if (document.getElementById("new_user_password" + index_of_new_profile).value == "") {
            document.getElementById("new-alert-msg").innerHTML =
                "Please enter password of user where it is not filled";
            document.getElementById("new-alert").style.display = "block";
            document.getElementById("refresh_user_btn").disabled = false;
            return;
        }
        else {
            let user_password = document.getElementById("new_user_password" + index_of_new_profile).value;
            let allowed_password_letter = /^(?=.*\d)(?=.*[A-Z])(.{8})$/;
            if (!user_password.match(allowed_password_letter)) {
                document.getElementById("new-alert-msg").innerHTML =
                    "Your password must contain alphanumeric and contain at least one number and one capital letter and contain length 8";
                document.getElementById("new-alert").style.display = "block";
                document.getElementById("refresh_user_btn").disabled = false;
                return;
            }
        }
        if (document.getElementById("new_user_email_add" + index_of_new_profile).value == "") {
            document.getElementById("new-alert-msg").innerHTML =
                "Please enter email address of user where it is not filled";
            document.getElementById("new-alert").style.display = "block";
            document.getElementById("refresh_user_btn").disabled = false;
            return;
        }
        else {
            let user_email_add = document.getElementById("new_user_email_add" + index_of_new_profile).value
            let allowed_email_add_letter = /^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$/;
            if (user_email_add.match(allowed_email_add_letter)) {
                $.ajax({
                    type: "post",
                    url: "dal/dal_users.php",
                    data: {
                        check_entered_email_is_used_or_not: "check_entered_email_is_used_or_not",
                        user_email_add: user_email_add,
                        index_of_new_profile: index_of_new_profile,
                    },
                    success: function (response) {
                        // debugger;
                        let splitted_response = response.split("#");
                        if (splitted_response[1] > 0) {
                            document.getElementById("new-alert-msg").innerHTML =
                                `Entered email address ${user_email_add} is already used by someone else. Please enter another and valid email address`;
                            document.getElementById("new-alert").style.display = "block";
                            document.getElementById("refresh_user_btn").disabled = false;
                            unsaved_arr.push(splitted_response[0]);
                        } else if (splitted_response[1] == 0) {
                            save_new_user(splitted_response[0]);
                        }
                    },
                });
            } else {
                document.getElementById("new-alert-msg").innerHTML =
                    "Please enter valid email address";
                document.getElementById("new-alert").style.display = "block";
                document.getElementById("refresh_user_btn").disabled = false;
                return;
            }
        }
        index_of_new_profile++;
    }
}

// function to disable or enable user
function disable_or_enable_user(user_id) {
    // debugger;
    let value = 0;
    if (document.getElementById("existing_user_disabled_" + user_id).checked == true) {
        value = 1;
    }
    $.ajax({
        type: "post",
        url: "dal/dal_users.php",
        data: {
            disable_user: "disable_user",
            user_id: user_id,
            value: value,
        },
        success: function (response) {
            // debugger;
            if (response > 0) {
                if (value == 1) {
                    document.getElementById("existing_user_disabled_" + user_id).checked = true;
                    document.getElementById("existing_user_disabled_" + user_id).title = "Disable User";
                }
                else {
                    document.getElementById("existing_user_disabled_" + user_id).checked = false;
                    document.getElementById("existing_user_disabled_" + user_id).title = "Enable User";
                }
            }
            else {
                document.getElementById("existing_user_disabled_" + user_id).checked = false;
                document.getElementById("new-alert-msg").innerHTML =
                    "Error occurred while disabling user, Please try again later";
                document.getElementById("new-alert").style.display = "block";
            }
        },
    });
}

// function to save changes made by authority user
function save_changes(user_id) {
    // debugger;
    let user_name = document.getElementById("existing_user_name" + user_id).value;
    let user_contact_no = document.getElementById("existing_user_contact_no" + user_id).value;
    let user_email_add = document.getElementById("existing_user_email_add" + user_id).value;
    let user_gender = $('#existing_user_gender' + user_id + ' option:selected').attr("id");
    let user_role = $('#existing_user_role' + user_id + ' option:selected').attr("id");
    let password = document.getElementById("existing_user_password" + user_id).value;
    if (user_name == "" || user_contact_no == "" || user_email_add == "" || user_gender == "") {
        document.getElementById("new-alert-msg").innerHTML =
            "Please enter the all fields of the user";
        document.getElementById("new-alert").style.display = "block";
        return;
    }
    if (isNaN(user_contact_no)) {
        document.getElementById("new-alert-msg").innerHTML =
            "Please enter the valid contact number";
        document.getElementById("new-alert").style.display = "block";
        return;
    }
    let allowed_email_add_letter = /^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$/;
    if (!user_email_add.match(allowed_email_add_letter)) {
        document.getElementById("new-alert-msg").innerHTML =
            "Please enter the valid email address";
        document.getElementById("new-alert").style.display = "block";
        return;
    }
    let allowed_password_letter = /^(?=.*\d)(?=.*[A-Z])(.{8})$/;
    if (!password.match(allowed_password_letter)) {
        document.getElementById("new-alert-msg").innerHTML =
            "Your password must contain alphanumeric and contain at least one number and one capital letter and contain length 8";
        document.getElementById("new-alert").style.display = "block";
        return;
    }
    $.ajax({
        type: "post",
        url: "dal/dal_users.php",
        data: {
            save_changes: "save_changes",
            user_id: user_id,
            user_name: user_name,
            user_contact_no: user_contact_no,
            user_email_add: user_email_add,
            user_gender: user_gender,
            user_role: user_role,
            password: password,
        },
        success: function (response) {
            // debugger;
            if (response > 0) {
                document.getElementById("new-alert-msg").innerHTML =
                    "Changes are saved";
                document.getElementById("new-alert").style.display = "block";
            }
            else {
                document.getElementById("new-alert-msg").innerHTML =
                    "Error occurred while changing user details, Please try again later";
                document.getElementById("new-alert").style.display = "block";
            }
        },
    });
}