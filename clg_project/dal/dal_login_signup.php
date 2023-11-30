<?php
include 'dal_db.php';
session_start();

if (isset($_POST['log_in'])) {
	$login = "SELECT * FROM vw_user_privileges WHERE user_email_add = '$_POST[user_email_add]' and user_password = '$_POST[user_password]'";
	$result = mysqli_query($con, $login);
	$num = mysqli_num_rows($result);
	if ($num) {
		while ($row = mysqli_fetch_array($result)) {
			if ($row['user_disabled'] > 0) {
				echo "-1";
				mysqli_close($con);
				exit();
			}
			$_SESSION['user_id'] = $row['user_id'];
			$_SESSION['user_name'] = $row['user_name'];
			$_SESSION['privilege_for_view_dashboard'] = $row['privilege_for_view_dashboard'];
			$_SESSION['privilege_for_move_dashboard_content'] = $row['privilege_for_move_dashboard_content'];
			$_SESSION['privilege_for_view_project'] = $row['privilege_for_view_project'];
			$_SESSION['privilege_for_add_new_project'] = $row['privilege_for_add_new_project'];
			$_SESSION['privilege_for_edit_project'] = $row['privilege_for_edit_project'];
			$_SESSION['privilege_for_view_reports'] = $row['privilege_for_view_reports'];
			$_SESSION['privilege_for_create_user'] = $row['privilege_for_create_user'];
			$_SESSION['privilege_for_view_and_edit_created_user'] = $row['privilege_for_view_and_edit_created_user'];
			$_SESSION['privilege_for_upload_images'] = $row['privilege_for_upload_images'];
			$_SESSION['privilege_for_delete_uploaded_images'] = $row['privilege_for_delete_uploaded_images'];
			$_SESSION['privilege_for_upload_documents'] = $row['privilege_for_upload_documents'];
			$_SESSION['privilege_for_delete_uploaded_documents'] = $row['privilege_for_delete_uploaded_documents'];
			$_SESSION['privilege_to_change_privilege'] = $row['privilege_to_change_privilege'];
			$admin_id =  mysqli_query($con, "SELECT user_id FROM tbl_user WHERE find_in_set($_SESSION[user_id], related_user)");
			$superadminid = mysqli_fetch_assoc($admin_id);
			echo "1";
		}
	} else {
		echo "0";
	}
	mysqli_close($con);
	exit();
}

if (isset($_POST['sign_up'])) {
	mysqli_query($con, "set @user_id = 0");
	mysqli_query($con, "CALL sp_user(@user_id,'$_POST[user_name]',1,'$_POST[user_email_add]','$_POST[user_password]',0,0,1)");
	$rs2 = mysqli_query($con, "SELECT @user_id as user_id ");
	$row = mysqli_fetch_assoc($rs2);
	if ($row['user_id'] > 0) {
		$_SESSION['user_id'] = $row['user_id'];
		$_SESSION['user_name'] = $_POST['user_name'];
		$newly_created_user_id = $row['user_id'];
		$set_privilege = "SELECT * FROM tbl_privileges WHERE privilege_user_id = $row[user_id]";
		$result = mysqli_query($con, $set_privilege);
		$num = mysqli_num_rows($result);
		if ($num) {
			while ($r = mysqli_fetch_array($result)) {
				$_SESSION['privilege_for_view_dashboard'] = $r['privilege_for_view_dashboard'];
				$_SESSION['privilege_for_move_dashboard_content'] = $r['privilege_for_move_dashboard_content'];
				$_SESSION['privilege_for_view_project'] = $r['privilege_for_view_project'];
				$_SESSION['privilege_for_add_new_project'] = $r['privilege_for_add_new_project'];
				$_SESSION['privilege_for_edit_project'] = $r['privilege_for_edit_project'];
				$_SESSION['privilege_for_view_reports'] = $r['privilege_for_view_reports'];
				$_SESSION['privilege_for_create_user'] = $r['privilege_for_create_user'];
				$_SESSION['privilege_for_view_and_edit_created_user'] = $r['privilege_for_view_and_edit_created_user'];
				$_SESSION['privilege_for_upload_images'] = $r['privilege_for_upload_images'];
				$_SESSION['privilege_for_delete_uploaded_images'] = $r['privilege_for_delete_uploaded_images'];
				$_SESSION['privilege_for_upload_documents'] = $r['privilege_for_upload_documents'];
				$_SESSION['privilege_for_delete_uploaded_documents'] = $r['privilege_for_delete_uploaded_documents'];
				$_SESSION['privilege_to_change_privilege'] = $r['privilege_to_change_privilege'];
			}
			$_SESSION['chatroom_id'] = 0;
			echo $newly_created_user_id;
		}
	} else {
		echo "0";
	}
	mysqli_close($con);
	exit();
}

if (isset($_POST['check_entered_email_is_used_or_not'])) {
	$get_records = "SELECT user_email_add FROM tbl_user WHERE user_email_add = '$_POST[user_email_add]'";
	$result = mysqli_query($con, $get_records);
	if (isset($result)) {
		$num = mysqli_num_rows($result);
		echo $num;
	} else {
		echo "0";
	}
	mysqli_close($con);
	exit();
}

if (isset($_POST['log_out'])) {
	session_destroy();
	mysqli_close($con);
}
