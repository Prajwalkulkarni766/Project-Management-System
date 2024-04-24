<!DOCTYPE html>
<html lang="en">

<head>
	<?php
	include 'header.php';
	?>
</head>

<body onload="get_project()">
	<?php
	include 'dal/dal_db.php';
	include 'menu.php';
	?>
	<div class="w3-container ">
		<?php
		// checking user have right or privilege to view project
		if (isset($_SESSION['privilege_for_view_project']) && $_SESSION['privilege_for_view_project'] > 0) {
		?>
			<script src="jquery/project.js"></script>
			<h1>Project
				<?php
				// checking user have right or privilege to add new project
				if (isset($_SESSION['privilege_for_add_new_project']) && $_SESSION['privilege_for_add_new_project'] > 0) {
				?>
					<a href="javascript:void(0)" onclick="document.getElementById('modal_of_add_project').style.display='block'" class="w3-right w3-xlarge w3-button" title="Add"><i class="fa fa-plus" aria-hidden="true"></i></a>

				<?php
				}
				?>
			</h1>
	</div>
	<?php
			include 'project_list.php';
	?>

	<!-- div that show info about project -->
	<div id="project_info_div" class="w3-margin-top w3-col l9 m9 s12" style="height:30rem;overflow-y: auto;display:none;">
		<h3 class="w3-padding-left"><img src="img/microsoft-project-480.png" alt="Project Management System Icon" class="w3-image" height="2vh" width="40vw"> Project Information</h3>
		<div class="w3-bar">
			<div class="w3-padding w3-row">
				<div class="w3-bar-item w3-col l4 m4 s12 w3-padding group">
					<label>Project Name</label><label class="w3-right w3-text-grey"><span id="project_name_word_count">0</span>/20</label>
					<input id="modal_project_name" class="w3-input" type="text" oninput="document.getElementById('project_name_word_count').innerHTML = (document.getElementById('modal_project_name').value).length;" maxlength="20" disabled>
				</div>
				<div class="w3-bar-item w3-col l4 m4 s12 w3-padding group">
					<label>Project Added Date</label>
					<input id="modal_project_date" class="w3-input" type="date" disabled>
				</div>

				<div class="w3-bar-item w3-col l4 m4 s12 w3-padding group">
					<label>Project Added Time</label>
					<input id="modal_project_time" class="w3-input" type="time" disabled>
				</div>

				<div class="w3-bar-item w3-col l4 m4 s12 w3-padding group w3-hide">
					<label>Project ID</label>
					<input id="modal_project_id" class="w3-input" type="text" disabled>
				</div>
			</div>
		</div>
		<div class="w3-margin-top w3-padding w3-contanier">
			<div class="w3-contanier"><label>Project Description : </label><label class="w3-right w3-text-grey"><span id="project_description_word_count">0</span>/1000</label><textarea id="modal_project_description" style="overflow-y:auto;" oninput="document.getElementById('project_description_word_count').innerHTML = (document.getElementById('modal_project_description').value).length;" maxlength="1000" disabled></textarea></div>
		</div>

		<?php
			// checking user have right or privilege to edit project
			if (isset($_SESSION['privilege_for_edit_project']) && $_SESSION['privilege_for_edit_project'] > 0) {
		?>
			<div class="w3-margin-top w3-padding w3-contanier">
				<a id="edit_project" href="javascript:void(0)" onclick="edit_project()" class="w3-right w3-xlarge w3-button" title="Edit"><i class="fa fa-pencil" aria-hidden="true"></i></a>
				<a id="save_edited_project" href="javascript:void(0)" onclick="save_edited_project()" style="display:none" class="w3-right w3-xlarge w3-button" title="Save"><i class="fa fa-floppy-o" aria-hidden="true"></i></a>
			</div>
		<?php
			}
		?>
	</div>
	<script async>
		$(document).ready(function() {
			get_project();
		});
	</script>
	<?php
			// checking user have right or privilege to add project
			if (isset($_SESSION['privilege_for_add_new_project']) && $_SESSION['privilege_for_add_new_project'] > 0) {
	?>
		<!-- modal to add a project -->
		<div id="modal_of_add_project" class="w3-modal">
			<div class="w3-modal-content">
				<header class="w3-container">
					<span onclick="document.getElementById('modal_of_add_project').style.display='none';document.getElementById('project_name').value = '';document.getElementById('project_description').value = ''" class="w3-xlarge w3-button w3-display-topright">&times;</span>
					<h3 class="w3-padding-left">Add Project</h3>
				</header>
				<div>
					<div class="w3-padding">
						<div class="w3-bar-item"><label>Project Name : </label><label class="w3-right w3-text-grey"><span id="word_count_for_project_name">0</span>/20</label></div>
						<div class="w3-bar-item"><input id="project_name" class="w3-input w3-border" maxlength="20" oninput="document.getElementById('word_count_for_project_name').innerHTML = (document.getElementById('project_name').value).length;"></div>
					</div>
					<div class="w3-margin-top w3-padding ">
						<div class="w3-bar-item"><label>Project Description : </label><label class="w3-right w3-text-grey"><span id="word_count_for_project_description">0</span>/1000</label></div>
						<div class="w3-bar-item"><textarea id="project_description" oninput="document.getElementById('word_count_for_project_description').innerHTML = (document.getElementById('project_description').value).length;" maxlength="1000"></textarea></div>
					</div>
				</div>
				<footer class="w3-container">
					<div class="w3-right w3-padding-small">
						<button class="w3-button" title="cancel" onclick="document.getElementById('modal_of_add_project').style.display='none';document.getElementById('project_name').value = '';document.getElementById('project_description').value = ''">Cancel</button>
						<button class="w3-button" title="Save" onclick="add_project()">Save</button>
					</div>
				</footer>
			</div>
		</div>
	<?php
			}
		} else {
	?>
	<div class="w3-center w3-margin-top">You don't have privilege to see project</div>
<?php
		}
?>
</body>

</html>