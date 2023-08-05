<!DOCTYPE html>
<html lang="en">

<head>
    <?php
    include 'header.php';
    ?>
</head>

<body>
    <?php
    include 'dal/dal_db.php';
    include 'menu.php';
    // checking user have right or privilege to view or create user
    if (isset($_SESSION['privilege_for_create_user']) && $_SESSION['privilege_for_create_user'] > 0 || isset($_SESSION['privilege_for_view_and_edit_created_user']) && $_SESSION['privilege_for_view_and_edit_created_user'] > 0) {
    ?>
        <script src="jquery/users.js"></script>
        <div class="w3-container ">
            <h1>Users</h1>
        </div>
        <div class="w3-container">
            <div class="w3-bar w3-light-grey">
                <?php
                // checking user have right or privilege to create user
                if (isset($_SESSION['privilege_for_create_user']) && $_SESSION['privilege_for_create_user'] > 0) {
                ?>
                    <button class="w3-bar-item w3-button tablink w3-dark-grey" onclick="open_another_tab(event,'Create User')">Create User</button>
                <?php
                }
                ?>

                <?php
                // checking user have right or privilege to view and edit user
                if (isset($_SESSION['privilege_for_view_and_edit_created_user']) && $_SESSION['privilege_for_view_and_edit_created_user'] > 0) {
                ?>
                    <button class="w3-bar-item w3-button tablink" onclick="open_another_tab(event,'View Created User')">View Created User</button>
                <?php
                }
                ?>
            </div>

            <?php
            // checking user have right or privilege to create user
            if (isset($_SESSION['privilege_for_create_user']) && $_SESSION['privilege_for_create_user'] > 0) {
            ?>
                <div id="Create User" class="w3-container w3-border city">
                    <div class="w3-container">
                        <div class="group w3-quarter w3-padding">
                            <label class="">Number of users that you want to create : </label>
                            <input id="no_of_user" class="w3-input" type="number" onblur="create_new_user()">
                        </div>
                        <div class="group w3-quarter w3-margin-top">
                            <button id="refresh_user_btn" onclick="refresh_new_user()" class="w3-xlarge w3-button" title="Reset" disabled><i class="fa fa-refresh" aria-hidden="true"></i></i></button>
                            <button id="save_user_btn" onclick="validate_emailadd()" class="w3-xlarge w3-button" title="Save" disabled><i class="fa fa-floppy-o" aria-hidden="true"></i></button>
                        </div>
                    </div>
                    <div id="newly_created_user" class="w3-container">

                    </div>
                </div>
            <?php
            }
            ?>

            <?php
            // checking user have right or privilege to view and edit user
            if (isset($_SESSION['privilege_for_view_and_edit_created_user']) && $_SESSION['privilege_for_view_and_edit_created_user'] > 0) {
            ?>
                <div id="View Created User" class="w3-container w3-border city" <?php
                                                                                if (isset($_SESSION['privilege_for_create_user']) && $_SESSION['privilege_for_create_user'] <= 0) {
                                                                                ?> style="display:block" <?php } else { ?> style="display:none" <?php
                                                                                                                                            } ?>>
                    <div class="group w3-bar">
                        <h2 class="w3-bar-item">View Created User</h2>
                        <button onclick="get_users()" class="w3-xlarge w3-bar-item w3-margin-top w3-right w3-button" title="Refresh or Get"><i class="fa fa-refresh" aria-hidden="true"></i></i></button>
                    </div>
                    <div id="existing_created_user"></div>
                </div>
            <?php
            }
            ?>
        </div>
    <?php
    } else {
    ?>
        <div class="w3-center w3-margin-top">You don't have privilege to see or create user</div>
    <?php
    }
    ?>
</body>

</html>