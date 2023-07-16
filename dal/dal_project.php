<?php
include 'dal_db.php';
session_start();

if (isset($_POST['add_project_to_table'])) {
	$projectname = $_POST['project_name'];
	$user_id = $_SESSION['user_id'];
	$projectdescription = $_POST['project_description'];

	mysqli_query($con, "set @out_parameter=0");
       mysqli_query($con, "CALL project_management_system_sp1($user_id,'','$projectname','$projectdescription',0,0,0,CURRENT_TIMESTAMP,3,@out_parameter)");
       $rs2 = mysqli_query($con, "SELECT @out_parameter as out_parameter ");
       $row = mysqli_fetch_assoc($rs2);
	$date = date('Y-m-d H:i:s');

	if($row['out_parameter'] > 0)
	{
		echo "added#".$row['out_parameter']." " . $date;
	}
	else
	{
		echo "not_added#0";
	}
	mysqli_close($con);
	exit();
}
if (isset($_POST['get_project'])) {
	$total = "";
	$userid = $_SESSION['user_id'];
	$get_project_list = "SELECT project_id,project_name,project_description,project_added_date FROM tbl_project WHERE user_id = $userid";
	$result = mysqli_query($con, $get_project_list);
	if (isset($result)) {
		while ($row = mysqli_fetch_array($result)) {
			$total = $total . $row['project_id'] . "#" . $row['project_name'] . "#" . $row['project_description'] . "#" . $row['project_added_date'] . "*";
		}
	}
	echo $total;
	mysqli_close($con);
	exit();
}
