<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<?php
	include 'header.php';
	?>
	<script src="jquery/project.js"></script>
	<style>
	#tr_color{
	background-color:#4169E1
	
	}
	</style>
</head>

<body onload="get_project()">
	<?php
	include 'dal/dal_db.php';
	include 'menu.php';
	?>

	<div class="w3-container ">
		<h1>Project <a onclick="document.getElementById('modal_of_add_project').style.display='block'" class="w3-right w3-xlarge w3-button w3-hover-text-red" title="Add"><i class="fa fa-plus" aria-hidden="true"></i></a> </h1>
	</div>

	<div id="modal_to_display_info_about_project" class="w3-modal">
		<div class="w3-modal-content">
			<header class="w3-container">
				<h3 class="w3-padding-left"><img src="img/microsoft-project-480.png" alt="Project Management System Icon" class="w3-image" height="2vh" width="40vw">  Project Information</h3>
			</header>
			<div class="w3-bar">
				<div class="w3-padding w3-row">
					<div class="w3-bar-item w3-col l4 m4 s12 w3-padding group">
						<label>Project Name</label>
						<input id="modal_project_name" class="w3-input" type="text" disabled>
					</div>
					<div class="w3-bar-item w3-col l4 m4 s12 w3-padding group">
						<label>Project Added Date</label>
						<input id="modal_project_date" class="w3-input" type="date" disabled>
					</div>

					<div class="w3-bar-item w3-col l4 m4 s12 w3-padding group">
						<label>Project Added Time</label>
						<input id="modal_project_time" class="w3-input" type="time" disabled>
					</div>
				</div>
			</div>
			<div class="w3-margin-top w3-padding w3-contanier">
				<div class="w3-contanier"><label>Project Description : </label><textarea id="modal_project_description" style="overflow-y:auto;" disabled></textarea></div>
			</div>
			<footer class="w3-container">
				<div class="w3-right w3-padding-small">
					<button class="w3-button w3-red w3-border" onclick="document.getElementById('modal_to_display_info_about_project').style.display='none';document.getElementById('project_name').value = '';document.getElementById('project_description').value = ''">Ok</button>
				</div>
			</footer>
		</div>
	</div>

	<div class="w3-margin-top w3-padding" style="height:30rem;overflow-y: auto;">
		<table class="w3-table-all w3-padding-small" id="tbl_id">
			<tr id="tr_color">
				<th class="w3-center w3-text-white">Sr.No</th>
				<th class="w3-center w3-hide w3-text-white">Project Id</th>
				<th class="w3-center w3-text-white">Project Name</th>
				<th class="w3-center w3-hide w3-text-white">Project Description</th>
				<th class="w3-center w3-hide w3-text-white">Project Added Date</th>
				<th class="w3-center w3-text-white">Information</th>
			</tr>
		</table>
	</div>
</body>

</html>