<?php
include 'dal_db.php';
session_start();

if (isset($_POST['log_in'])) {

	$user_email_add = $_POST['user_email_add'];
	$user_password = $_POST['user_password'];

	$login = "SELECT user_id,user_name FROM tbl_user WHERE user_email_add = '$user_email_add' and user_password = '$user_password'";

	$result = mysqli_query($con, $login);
	$num = mysqli_num_rows($result);

	if ($num) {
		while ($row = mysqli_fetch_array($result)) {
			$_SESSION['user_id'] = $row['user_id'];
			$_SESSION['user_name'] = $row['user_name'];
			echo "1";
		}
	} else {
		echo "0";
	}
	mysqli_close($con);
	exit();
}

if (isset($_POST['sign_up'])) {

	$user_name = $_POST['user_name'];
	$user_contact_no = $_POST['user_contact_no'];
	$user_email_add = $_POST['user_email_add'];
	$user_password = $_POST['user_password'];

	$signup = "INSERT INTO `tbl_user` (`user_name`, `user_contact_no`, `user_email_add`, `user_password`, `user_signup_date`) VALUES ('$user_name', '$user_contact_no', '$user_email_add', '$user_password', CURRENT_TIMESTAMP)";

	if (mysqli_query($con, $signup)) {
		$last_id = mysqli_insert_id($con);
		$_SESSION['user_id'] = $last_id;
		$_SESSION['user_name'] = $user_name;
		echo "1";
	} else {
		echo "0";
	}
	mysqli_close($con);
	exit();
}

if (isset($_POST['check_entered_email_is_used_or_not'])) {
	$user_email_add = $_POST['user_email_add'];

	$get_records = "SELECT user_email_add FROM tbl_user WHERE user_email_add = '$user_email_add'";

	$result = mysqli_query($con, $get_records);
	$num = mysqli_num_rows($result);
	echo $num;
	mysqli_close($con);
	exit();
}
if (isset($_POST['log_out'])) {
	session_destroy();
	mysqli_close($con);
}
