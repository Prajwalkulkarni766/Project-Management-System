<?php
include 'dal_db.php';
session_start();

if (isset($_POST['create_chat_room'])) {
    $get_records = "SELECT chatroom_name FROM tbl_chatroom WHERE chatroom_name = '$_POST[chatroom_name]'";
    $result = mysqli_query($con, $get_records);
    if (isset($result)) {
        $num = mysqli_num_rows($result);
        if ($num > 0) {
            echo "-1";
        } else {
            mysqli_query($con, "INSERT INTO tbl_chatroom (chatroom_name, chatroom_created_by, chatroom_created_date) VALUES ('$_POST[chatroom_name]', 1, current_date);");
            $last_id = mysqli_insert_id($con);
            $_SESSION['chatroom_id'] = $last_id;
            echo "1";
        }
    } else {
        echo "0";
    }
    mysqli_close($con);
    exit();
}

if (isset($_POST['get_msg'])) {
    $get_msg = "SELECT * FROM tbl_chat WHERE chatroom_id = $_SESSION[chatroom_id] AND chat_sendby != $_SESSION[user_id] AND chat_id > $_POST[previous_chat_count] LIMIT 3";
    $result = mysqli_query($con, $get_msg);
    if (isset($result)) {
        $output_in_the_form_of_json = mysqli_fetch_all($result, MYSQLI_ASSOC);
        echo json_encode($output_in_the_form_of_json);
    } else {
        echo "0";
    }
}

if (isset($_POST['send_msg'])) {
    $send_msg = "INSERT INTO tbl_chat(chat_msg, chat_sendby, chatroom_id, chat_datetime) VALUES ('$_POST[msg]',$_SESSION[user_id],$_SESSION[chatroom_id],CURRENT_TIMESTAMP)";
    mysqli_query($con, $send_msg);
    echo mysqli_insert_id($con);
}
