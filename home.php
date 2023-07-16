<!DOCTYPE html>
<html lang="en">

<head>
	<?php
	include 'header.php';
	?>
	<script src="jquery/home.js"></script>
	<style>
	 #bg_color 
{
  font-family:Arial; 
  background: -webkit-linear-gradient(to right, #155799, #159957); 
  background: linear-gradient(to right, #155799, #159957); 
  color:whitesmoke;
  }
	</style>
</head>

<body>
	<?php
	$user_id = $_SESSION['user_id'];
	include 'dal/dal_db.php';
	include 'menu.php';
	?>

	<div class="w3-contanier">
		<div class="w3-bar w3-padding">
			<div class="w3-bar-item w3-quarter w3-padding group">
				<label class="">Project</label>
				<input id="project" class="w3-input" type="text" list="project_list" onchange="valid_project_choice(1)">
				<datalist id="project_list">
					<?php
					$project_name = "SELECT project_id, project_name FROM `tbl_project` WHERE user_id = $user_id";

					$result = mysqli_query($con, $project_name);

					if (isset($result)) {
						while ($row = mysqli_fetch_array($result)) {
							echo "<option id=" . $row['project_id'] . " value='" . $row['project_name'] . "'></option>";
						}
					}
					?>
				</datalist>
			</div>
			<div class="w3-bar-item w3-quarter w3-padding group">
				<button onclick="search_of_selected_project()" class="w3-button w3-round"><a href="#" class="w3-xlarge w3-right" title="Search" title="Search"><i class="w3-padding-top fa fa-search fa-fw"></i></a></button>
			</div>
		</div>
	</div>

	<div class="w3-row">
		<div class="w3-container w3-padding">
			<div class="w3-quarter w3-container w3-padding">

				<h4 class="w3-border w3-center w3-padding w3-light-gray" id="bg_color">Do it <span id="no_of_content_of_do_it_section" class="w3-large w3-margin-left w3-badge"></span><i class="w3-right w3-padding-top fa fa-plus icon" onclick="document.getElementById('modal_to_take_do_it_content').style.display='block'" aria-hidden="true" style="color:white;text-align:right"></i></h4>

				<div id="do_it_content_div" class="content_holding_divs"></div>


				<div id="do_it" class="w3-border" ondrop="drop_and_save(event,1)" ondragover="allowDrop(event)"></div>
			</div>

			<div class="w3-quarter w3-container w3-padding">
				<h4 class="w3-border w3-center w3-padding w3-light-gray " id="bg_color">In progress <span id="no_of_content_of_in_progress_section" class="w3-large w3-margin-left w3-badge"></span></h4>

				<div id="in_progress_content_div" class="content_holding_divs"></div>

				<div id="in_progress" class="w3-border" ondrop="drop_and_save(event,2)" ondragover="allowDrop(event)"></div>


			</div>

			<div class="w3-quarter w3-container w3-padding">
				<h4 class="w3-border w3-center w3-padding w3-light-gray" id="bg_color">Verify <span id="no_of_content_of_verify_section" class="w3-large w3-margin-left w3-badge"></span></h4>

				<div id="verify_content_div" class="content_holding_divs"></div>

				<div id="verify" class="w3-border" ondrop="drop_and_save(event,3)" ondragover="allowDrop(event)"></div>
			</div>

			<div class="w3-quarter w3-container w3-padding">
				<h4 class=" w3-border w3-center w3-padding w3-light-gray" id="bg_color">Done <span id="no_of_content_of_done_section" class="w3-large w3-margin-left w3-badge"></span></h4>

				<div id="done_content_div" class="content_holding_divs"></div>

				<div id="done" class="w3-border" ondrop="drop_and_save(event,4)" ondragover="allowDrop(event)"></div>
			</div>
		</div>
	</div>
	<script>
		if (sessionStorage.getItem("new_user")) {
			sessionStorage.removeItem("new_user");
			document.getElementById('popup_about_system_info').style.display = 'block';
		} else {
			to_check_previous_project_input_value();
		}
	</script>
	<div id="modal_to_take_do_it_content" class="w3-modal">
		<div class="w3-modal-content">
			<header class="w3-container">
				<span onclick="document.getElementById('modal_to_take_do_it_content').style.display='none';document.getElementById('do_it_content').value = ''" class="w3-xlarge w3-button w3-display-topright">&times;</span>
				<h3 class="w3-padding-left"><img src="img/microsoft-project-480.png" alt="Project Management System Icon" class="w3-image" height="2vh" width="40vw">  Add content</h3>
			</header>
			<div class="w3-container">
				<div class="w3-padding">
					<textarea id="do_it_content" placeholder="Add your Do it here" maxlength="100" autofocus></textarea>
				</div>
			</div>
			<footer class="w3-container">
				<div class="w3-container w3-padding-small">
					<button class="w3-right w3-btn w3-green" onclick="save_do_it_content()">Save</button>
				</div>
			</footer>
		</div>
	</div>
</body>

</html>