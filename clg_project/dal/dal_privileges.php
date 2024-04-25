<?php
include 'dal_db.php';
session_start();

if (isset($_POST['get_privilege_data'])) {
    $relatedUsers = mysqli_query($con, "SELECT related_user FROM tbl_user WHERE user_id = $_SESSION[user_id]");
    $row = mysqli_fetch_assoc($relatedUsers);
    $array = explode(",", $row['related_user']);
    $output_in_the_form_of_json = array();
    foreach ($array as $key => $value) {
        if ($value == $_SESSION["user_id"]) {
            continue;
        }
        $userData = mysqli_query($con, "SELECT * FROM tbl_privileges WHERE privilege_user_id = $value");
        $userNameResult = mysqli_query($con, "SELECT user_name FROM tbl_user WHERE user_id = $value");
        if ($userData && $userNameResult) {
            $userNameRow = mysqli_fetch_assoc($userNameResult);
            $userName = $userNameRow['user_name']; // Fetch the user name
            while ($row = mysqli_fetch_assoc($userData)) {
                $row['user_id'] = $value;
                $row['user_name'] = $userName;
                $output_in_the_form_of_json[] = $row;
            }
        }
    }
    echo json_encode($output_in_the_form_of_json);
    mysqli_close($con);
    exit();
}


if (isset($_POST['save_changed_privilege'])) {
    mysqli_query($con, "set @p_privilegeid=0");
    mysqli_query($con, "CALL sp_privileges(@p_privilegeid,$_POST[privilege_for_view_dashboard],$_POST[privilege_for_move_dashboard_content],$_POST[privilege_for_view_project],$_POST[privilege_for_add_new_project],$_POST[privilege_for_edit_project],$_POST[privilege_for_view_reports],$_POST[privilege_to_change_privilege],$_POST[privilege_for_create_user],$_POST[privilege_for_view_and_edit_created_user],$_POST[privilege_for_upload_images],$_POST[privilege_for_delete_uploaded_images],$_POST[privilege_for_upload_documents],$_POST[privilege_for_delete_uploaded_documents],$_POST[id],$_SESSION[user_id],CURRENT_TIMESTAMP,6)");
    $rs2 = mysqli_query($con, "SELECT @p_privilegeid as p_privilegeid ");
    $row = mysqli_fetch_assoc($rs2);

    echo $row['p_privilegeid'] > 0 ? $row['p_privilegeid'] : "0";
    mysqli_close($con);
    exit();
}
