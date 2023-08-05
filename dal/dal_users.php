<?php
include 'dal_db.php';
session_start();

if (isset($_POST['get_users'])) {
    $result = mysqli_query($con, "CALL project_management_system_sp_to_fetch_all_related_user($_SESSION[user_id])");
    if (isset($result)) {
        $output_in_the_form_of_json = mysqli_fetch_all($result, MYSQLI_ASSOC);
        echo json_encode($output_in_the_form_of_json);
    } else {
        echo "Not found";
    }
    mysqli_close($con);
    exit();
}

if (isset($_POST['save_new_user'])) {
    mysqli_query($con, "set @user_id=0");
    mysqli_query($con, "CALL project_management_system_sp_for_user(@user_id,'$_POST[new_user_name]','$_POST[new_user_contact_no]',$_POST[new_user_gender],$_POST[new_user_role],'$_POST[new_user_email_add]','$_POST[new_user_password]',0,$_SESSION[user_id],CURRENT_TIMESTAMP,1)");
    $rs2 = mysqli_query($con, "SELECT @user_id as user_id ");
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
    mysqli_query($con, "CALL project_management_system_sp_for_user(@user_id,'','',0,0,'','',$_POST[value],$_SESSION[user_id],CURRENT_TIMESTAMP,3)");
    $rs2 = mysqli_query($con, "SELECT @user_id as user_id ");
    $row = mysqli_fetch_assoc($rs2);
    echo $row['user_id'];
    mysqli_close($con);
    exit();
}

if (isset($_POST['save_changes'])) {
    mysqli_query($con, "set @user_id=$_POST[user_id]");
    mysqli_query($con, "CALL project_management_system_sp_for_user(@user_id,'$_POST[user_name]','$_POST[user_contact_no]',$_POST[user_gender],$_POST[user_role],'$_POST[user_email_add]','$_POST[password]',0,$_SESSION[user_id],CURRENT_TIMESTAMP,2)");
    $rs2 = mysqli_query($con, "SELECT @user_id as user_id ");
    $row = mysqli_fetch_assoc($rs2);
    echo $row['user_id'];
    mysqli_close($con);
    exit();
}
