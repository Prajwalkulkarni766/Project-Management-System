<!DOCTYPE html>
<html lang="en">

<head>
	<?php
	include 'header.php';
	?>
</head>

<body>
	<?php
	include 'dal/dal_db.php';
	include 'menu.php';
	// checking user have right or privilege to access the home page
	if (isset($_SESSION['privilege_for_view_dashboard']) && $_SESSION['privilege_for_view_dashboard'] > 0) {
	?>
		<script src="jquery/home.js"></script>
		<div class="w3-contanier">
			<div class="w3-bar w3-padding">
				<!-- project input box -->
				<div class="w3-bar-item w3-quarter w3-padding group">
					<label class="">Project</label>
					<input id="project" class="w3-input" type="text" list="project_list" onchange="valid_project_choice(1)">
					<datalist id="project_list">
						<?php
						// getting project list
						mysqli_query($con, "set @project_id_and_name_list=''");
						mysqli_query($con, "CALL sp_fetchproject($_SESSION[user_id],@project_id_and_name_list)");
						$result = mysqli_query($con, "SELECT @project_id_and_name_list");
						if (isset($result)) {
							while ($row = mysqli_fetch_array($result)) {
								$project_arr = explode("*", $row[0]);
								foreach ($project_arr as $single_project_arr) {
									$project = explode("#", $single_project_arr);
									echo $project[0];
									echo $project[1];
									echo "<option id=" . $project[0] . " value='" . $project[1] . "'></option>";
								}
							}
						}
						?>
					</datalist>
				</div>
				<div class="w3-endw3-bar-item w3-quarter group w3-right">
					<button class="w3-button w3-right w3-xlarge" title="Conver to excel" onclick="convertToExcel()"><i class="fa fa-file-excel-o" aria-hidden="true"></i></button>
				</div>
			</div>
		</div>

		<div class="w3-row">
			<div class="w3-container w3-padding">
				<!-- do it section -->
				<div class="w3-quarter w3-container w3-padding">
					<h4 class="w3-border w3-center w3-padding w3-light-gray" id="bg_color">Do it <span id="no_of_content_of_do_it_section" class="w3-large w3-margin-left w3-badge"></span>

						<?php
						// checking user have right or privilege to add the content if yes then add button
						if (isset($_SESSION['privilege_for_move_dashboard_content']) && $_SESSION['privilege_for_move_dashboard_content'] > 0) {
						?>
							<i id="plus_icon_to_add_content" class="w3-right w3-padding-top fa fa-plus icon" onclick="document.getElementById('modal_to_take_do_it_content').style.display='block';document.getElementById('do_it_content').focus()" aria-hidden="true" style="text-align:right;display:none;"></i>
						<?php
						}
						?>
					</h4>
					<div id="do_it_content_div" class="content_holding_divs"></div>
					<div id="do_it" class="w3-border" ondrop="drop_and_save(event,1)" ondragover="allowDrop(event)"></div>
				</div>
				<!-- in progress section -->
				<div class="w3-quarter w3-container w3-padding">
					<h4 class="w3-border w3-center w3-padding w3-light-gray " id="bg_color">In progress <span id="no_of_content_of_in_progress_section" class="w3-large w3-margin-left w3-badge"></span></h4>
					<div id="in_progress_content_div" class="content_holding_divs"></div>
					<div id="in_progress" class="w3-border" ondrop="drop_and_save(event,2)" ondragover="allowDrop(event)"></div>
				</div>
				<!-- verify section -->
				<div class="w3-quarter w3-container w3-padding">
					<h4 class="w3-border w3-center w3-padding w3-light-gray" id="bg_color">Verify <span id="no_of_content_of_verify_section" class="w3-large w3-margin-left w3-badge"></span></h4>
					<div id="verify_content_div" class="content_holding_divs"></div>
					<div id="verify" class="w3-border" ondrop="drop_and_save(event,3)" ondragover="allowDrop(event)"></div>
				</div>
				<!-- done section -->
				<div class="w3-quarter w3-container w3-padding">
					<h4 class=" w3-border w3-center w3-padding w3-light-gray" id="bg_color">Done <span id="no_of_content_of_done_section" class="w3-large w3-margin-left w3-badge"></span></h4>
					<div id="done_content_div" class="content_holding_divs"></div>
					<div id="done" class="w3-border" ondrop="drop_and_save(event,4)" ondragover="allowDrop(event)"></div>
				</div>
			</div>
		</div>

		<?php
		// checking user have right or privilege to add the content if yes the add modal
		if (isset($_SESSION['privilege_for_move_dashboard_content']) && $_SESSION['privilege_for_move_dashboard_content'] > 0) {
		?>
			<!-- modal to add new problem / content in do it section -->
			<div id="modal_to_take_do_it_content" class="w3-modal">
				<div class="w3-modal-content">
					<header class="w3-container">
						<span onclick="document.getElementById('modal_to_take_do_it_content').style.display='none';document.getElementById('do_it_content').value = ''" class="w3-xlarge w3-button w3-display-topright">&times;</span>
						<h3 class="w3-padding-left"><img src="img/microsoft-project-480.png" alt="Project Management System Icon" class="w3-image" height="2vh" width="40vw"> Add content</h3>
					</header>
					<div class="w3-container">
						<div class="w3-padding">
							<textarea id="do_it_content" placeholder="Add your Do it here" maxlength="100" autofocus></textarea>
						</div>
					</div>
					<footer class="w3-container">
						<div class="w3-container w3-padding-small">
							<button class="w3-right w3-button" onclick="save_do_it_content()">Save</button>
						</div>
					</footer>
				</div>
			</div>
		<?php
		}
		?>
		<!-- checking whether user is new or not if new then show info modal -->
		<script>
			$(document).ready(function() {
				if (sessionStorage.getItem("new_user")) {
					sessionStorage.removeItem("new_user");
					document.getElementById('popup_about_system_info').style.display = 'block';
				} else {
					to_check_previous_project_input_value();
				}
			});
		</script>
	<?php
	} else {
	?>
		<div class="w3-center w3-margin-top">You don't have privilege to see dashboard</div>
	<?php
	}
	?>
</body>

</html>