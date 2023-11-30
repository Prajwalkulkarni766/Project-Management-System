<?php
include 'dal_db.php';
session_start();

if (isset($_POST['add_project_to_table'])) {
	mysqli_query($con, "set @out_parameter = 0");
	mysqli_query($con, "CALL sp_project($_SESSION[user_id],0,'$_POST[project_name]','$_POST[project_description]',1,@out_parameter)");
	$rs2 = mysqli_query($con, "SELECT @out_parameter as out_parameter");
	$row = mysqli_fetch_assoc($rs2);
	$date = date('Y-m-d H:i:s');

	if ($row['out_parameter'] > 0) {
		echo "added#" . $row['out_parameter'] . " " . $date;
	} else {
		echo "not_added#0";
	}
	mysqli_close($con);
	exit();
}

if (isset($_POST['get_project'])) {
	$total = "";
	mysqli_query($con, "set @project_id_and_name_list=''");
	mysqli_query($con, "CALL sp_fetchproject($_SESSION[user_id],@project_id_and_name_list)");
	$result = mysqli_query($con, "SELECT @project_id_and_name_list");
	if (isset($result)) {
		while ($row = mysqli_fetch_array($result)) {
			$total .= $row[0];
		}
	}
	echo $total;
	mysqli_close($con);
	exit();
}

if (isset($_POST['edit_the_project'])) {
	mysqli_query($con, "set @out_parameter = 0");
	mysqli_query($con, "CALL sp_project($_SESSION[user_id],$_POST[project_id],'$_POST[project_name]','$_POST[project_description]',2,@out_parameter)");
	$rs2 = mysqli_query($con, "SELECT @out_parameter as out_parameter ");
	$row = mysqli_fetch_assoc($rs2);
	echo $row['out_parameter'];
	mysqli_close($con);
	exit();
}
