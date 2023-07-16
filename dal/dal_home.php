<?php
include 'dal_db.php';
session_start();

if (isset($_POST['save_do_it_content_to_tbl'])) {
       $user_id = $_SESSION['user_id'];
       $project_id = $_POST['project_id'];
       $section_holding_id = 1;
       $do_it_content = $_POST['do_it_content'];

       mysqli_query($con, "set @out_parameter=0");
       mysqli_query($con, "CALL project_management_system_sp1($user_id,'$do_it_content','','',$project_id,$section_holding_id,0,CURRENT_TIMESTAMP,1,@out_parameter)");
       $rs2 = mysqli_query($con, "SELECT @out_parameter as out_parameter ");
       $row = mysqli_fetch_assoc($rs2);
       if($row['out_parameter'] > 0)
       {
              echo "added#" . $row['out_parameter'];
       }
       else
       {
              echo "not_added#0";
       }
       mysqli_close($con);
       exit();
}

if (isset($_POST['get_content_of_selected_project'])) {
       $user_id = $_SESSION['user_id'];
       $project_id = $_POST['project_id'];
       $div = '';

       $get_content = "SELECT content_id,content,section_holding_ids FROM tbl_content WHERE user_id = $user_id AND project_id = $project_id";

       $result = mysqli_query($con, $get_content);

       while ($content_result_row = mysqli_fetch_array($result)) {
              $div = $div . $content_result_row['section_holding_ids'] . '@<div id="drag' . $content_result_row['content_id'] . '" class="w3-border w3-padding w3-margin-bottom w3-conatiner w3-round" draggable="true" ondragstart="drag(event)">' . $content_result_row['content'] . '</div>#';
       }
       echo $div;
       mysqli_close($con);
       exit();
}

if (isset($_POST['move_content'])) {
       $section_holding_ids = $_POST['id'];
       $project_id = $_POST['project_id'];
       $user_id = $_SESSION['user_id'];
       $content_id = $_POST['content_id'];

       mysqli_query($con, "@out_parameter=0");
       mysqli_query($con, "CALL project_management_system_sp1($user_id,'','','',$project_id,$section_holding_ids,$content_id,CURRENT_TIMESTAMP,2,@out_parameter)");
       $rs2 = mysqli_query($con, "SELECT @out_parameter as out_parameter ");
       $row = mysqli_fetch_assoc($rs2);

       if ($row['out_parameter'] > 0) {
              echo "added";
       } else {
              echo "not_added";
       }
       mysqli_close($con);
       exit();
}
