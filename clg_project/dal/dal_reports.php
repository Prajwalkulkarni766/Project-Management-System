<?php
include 'dal_db.php';
session_start();

if (isset($_POST['get_project_content_to_generate_report'])) {
	$query = "SELECT count_doit,count_inprogress,count_verify,count_done,count_document, count_gallery FROM tbl_count WHERE project_id =" . $_POST['id'];
	$result = mysqli_query($con, $query);
	$div = "";
	if (isset($result)) {
		$row = mysqli_fetch_assoc($result);
		$div .= ($row["count_doit"] ?? 0) . "#" .
			($row["count_inprogress"] ?? 0) . "#" .
			($row["count_verify"] ?? 0) . "#" .
			($row["count_done"] ?? 0) . "#" .
			($row['count_document'] ?? 0) . "#" .
			($row['count_gallery'] ?? 0);
	}
	echo $div;
	mysqli_close($con);
	exit();
}
