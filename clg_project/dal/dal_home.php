<?php
include 'dal_db.php';
session_start();

if (isset($_POST['save_do_it_content_to_tbl'])) {
       try {
              mysqli_query($con, "set @out_parameter=0");
              mysqli_query($con, "CALL project_management_system_sp1($_SESSION[user_id],'$_POST[do_it_content]','','',$_POST[project_id],1,0,CURRENT_TIMESTAMP,1,@out_parameter)");
              $rs2 = mysqli_query($con, "SELECT @out_parameter as out_parameter ");
              $row = mysqli_fetch_assoc($rs2);
              if ($row['out_parameter'] > 0) {
                     echo "added#" . $row['out_parameter'];
              } else {
                     echo "not_added#0";
              }
       } catch (Exception $e) {
              echo "not_added#0";
       }
       mysqli_close($con);
       exit();
}

if (isset($_POST['get_content_of_selected_project'])) {
       $div = '';
       try {
              $get_content = "SELECT content_id,content,section_holding_ids FROM tbl_content WHERE project_id = $_POST[project_id]";
              $result = mysqli_query($con, $get_content);
              while ($content_result_row = mysqli_fetch_array($result)) {
                     if (isset($_SESSION['privilege_for_move_dashboard_content']) && $_SESSION['privilege_for_move_dashboard_content'] > 0) {
                            $div = $div . $content_result_row['section_holding_ids'] . '@<div id="drag' . $content_result_row['content_id'] . '" class="w3-border w3-padding w3-margin-bottom w3-conatiner w3-round" draggable="true" ondragstart="drag(event)">' . $content_result_row['content'] . '</div>#';
                     } else {
                            $div = $div . $content_result_row['section_holding_ids'] . '@<div id="drag' . $content_result_row['content_id'] . '" class="w3-border w3-padding w3-margin-bottom w3-conatiner w3-round">' . $content_result_row['content'] . '</div>#';
                     };
              }
       } catch (Exception $e) {
       }
       echo $div;
       mysqli_close($con);
       exit();
}

if (isset($_POST['move_content'])) {
       try {
              mysqli_query($con, "set @out_parameter=0");
              mysqli_query($con, "CALL project_management_system_sp1($_SESSION[user_id],'','','',$_POST[project_id],$_POST[id],$_POST[content_id],CURRENT_TIMESTAMP,2,@out_parameter)");
              $rs2 = mysqli_query($con, "SELECT @out_parameter as out_parameter ");
              $row = mysqli_fetch_assoc($rs2);

              if ($row['out_parameter'] > 0) {
                     echo "added";
              } else {
                     echo "not_added";
              }
       } catch (Exception $e) {
              echo "not_added";
       }
       mysqli_close($con);
       exit();
}
