<?php
include 'dal_db.php';
session_start();

if(isset($_POST['get_project_content_to_generate_report']))
{
	$query = "SELECT count_doit,count_inprogress,count_verify,count_done FROM tbl_count WHERE project_id =".$_POST['id'];
	$result = mysqli_query($con,$query);
	$div = "";
	if(isset($result)){
	  $row = mysqli_fetch_assoc($result);
	  $div .= $row["count_doit"] ."#". $row["count_inprogress"] ."#". $row["count_verify"] ."#".  $row["count_done"];	
	}
	echo $div;
	mysqli_close($con);
	exit();
}
