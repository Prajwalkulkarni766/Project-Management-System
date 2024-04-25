<?php
include 'dal_db.php';
session_start();

if (isset($_POST['get_users'])) {
    $relatedUsers = mysqli_query($con, "SELECT related_user FROM tbl_user WHERE user_id = $_SESSION[user_id]");
    $row = mysqli_fetch_assoc($relatedUsers);
    $array = explode(",", $row['related_user']);
    $output_in_the_form_of_json = array();
    foreach ($array as $key => $value) {
        if ($value == $_SESSION["user_id"]) {
            continue;
        }
        $userData = mysqli_query($con, "SELECT * FROM tbl_user WHERE user_id = $value");
        if ($userData) {
            while ($row = mysqli_fetch_assoc($userData)) {
                $output_in_the_form_of_json[] = $row;
            }
        }
    }
    echo json_encode($output_in_the_form_of_json);
    mysqli_close($con);
    exit();
}

if (isset($_POST['save_new_user'])) {
    mysqli_query($con, "set @user_id=0");
    mysqli_query($con, "CALL sp_user(@user_id,'$_POST[new_user_name]',$_POST[new_user_role],'$_POST[new_user_email_add]','$_POST[new_user_password]',0,$_SESSION[user_id],1)");
    $rs2 = mysqli_query($con, "SELECT @user_id as user_id");
    if ($rs2 === false) {
        echo "Error retrieving user ID: " . mysqli_error($con);
        exit();
    }
    $row = mysqli_fetch_assoc($rs2);
    if ($row['user_id'] > 0) {
        echo $_POST['index_of_new_profile'];
    } else {
        echo "not_added";
    }
    mysqli_close($con);
    exit();
}

if (isset($_POST['check_entered_email_is_used_or_not'])) {
    $user_email_add = $_POST['user_email_add'];
    $get_records = "SELECT user_email_add FROM tbl_user WHERE user_email_add = '$user_email_add'";
    $result = mysqli_query($con, $get_records);
    $num = mysqli_num_rows($result);
    echo $_POST['index_of_new_profile'] . "#" . $num;
    mysqli_close($con);
    exit();
}

if (isset($_POST['disable_user'])) {
    mysqli_query($con, "set @user_id=$_POST[user_id]");
    mysqli_query($con, "CALL sp_user(@user_id,'',0,'','',$_POST[value],0,4)");
    $rs2 = mysqli_query($con, "SELECT @user_id as user_id ");
    $row = mysqli_fetch_assoc($rs2);
    echo $row['user_id'];
    mysqli_close($con);
    exit();
}

if (isset($_POST['save_changes'])) {
    try {
        mysqli_query($con, "set @user_id=$_POST[user_id]");
        mysqli_query($con, "CALL sp_user(@user_id,'$_POST[user_name]',$_POST[user_role],'$_POST[user_email_add]','$_POST[password]',0,$_SESSION[user_id],2)");
        $rs2 = mysqli_query($con, "SELECT @user_id as user_id ");
        $row = mysqli_fetch_assoc($rs2);
        echo $row['user_id'];
    } catch (Exception $e) {
        echo 'Message: ' . $e->getMessage();
    }
    mysqli_close($con);
    exit();
}
