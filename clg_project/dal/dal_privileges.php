<?php
include 'dal_db.php';
session_start();

// if (isset($_POST['get_privilege_data'])) {
//     mysqli_query($con, "set @user = $_SESSION[user_id]");
//     $result = mysqli_query($con, "CALL sp_user(@user,'',0,'','',0,0,5)");
//     if (isset($result)) {
//         $output_in_the_form_of_json = mysqli_fetch_all($result, MYSQLI_ASSOC);
//         echo json_encode($output_in_the_form_of_json);
//     } else {
//         echo json_encode(array('message' => 'record not found', 'status' => false));
//     }
// }

if (isset($_POST['get_privilege_data'])) {
    mysqli_query($con, "set @user = $_SESSION[user_id]");
    $result = mysqli_query($con, "CALL sp_user(@user,'',0,'','',0,0,5)");
    if ($result === false) {
        $error_message = mysqli_error($con);
        echo json_encode(array('message' => 'Query failed: ' . $error_message, 'status' => false));
    } else {
        $output_in_the_form_of_json = mysqli_fetch_all($result, MYSQLI_ASSOC);
        if ($output_in_the_form_of_json !== null) {
            echo json_encode($output_in_the_form_of_json);
        } else {
            // echo json_encode(array('message' => 'No records found', 'status' => false));
            echo "abc";
        }
    }
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
