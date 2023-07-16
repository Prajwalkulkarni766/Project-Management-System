<?php
include 'dal_db.php';
session_start();
if(isset($_POST['get_project_name_list']))
{
	$user_id = $_SESSION['user_id'];
	$query = "SELECT project_id,project_name FROM tbl_project WHERE user_id =".$user_id;
	$result = mysqli_query($con,$query);
	$div = "";
	if(isset($result)){
	  while($row = mysqli_fetch_array($result))
	  {
		  $div = $div . "<button class='w3-button' id='project_name_btn".$row['project_id']."' onclick='open_project_reprot(".$row['project_id'].")'>".$row['project_name']."</button>@";
	  }		  
	}
	echo $div;
	mysqli_close($con);
	exit();
}
if(isset($_POST['get_project_content_to_generate_report']))
{
	$user_id = $_SESSION['user_id'];
	$project_id = $_POST['id'];
	$query = "SELECT count_doit,count_inprogress,count_verify,count_done FROM tbl_count WHERE user_id =".$user_id." AND project_id =".$project_id;
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
?>