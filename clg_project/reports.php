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
	// checking user have right or privilege to view report
	if (isset($_SESSION['privilege_for_view_reports']) && $_SESSION['privilege_for_view_reports'] > 0) {
	?>
		<script src="jquery/reports.js"></script>
		<div class="w3-container">
			<h1>Reports</h1>
		</div>

		<?php
		include 'project_list.php';
		?>

		<div id="report_holding_div" class="w3-container w3-display-container w3-col l9 m9 s12 city" style="display:none">
			<h2 id="project_name_heading_for_report"></h2>
			<div>
				<div class="w3-section w3-light-gray w3-padding">
					<div class="w3-container w3-padding-small w3-green w3-center" id="percentage_holding_div"></div>
				</div>
				<div class="w3-row">
					<div class="w3-col l3 m3 s12">
						<label>Do it : <span id="count_of_do_it"></span></label>
					</div>
					<div class="w3-col l3 m3 s12">
						<label>In progress : <span id="count_of_in_progess"></span></label>
					</div>
					<div class="w3-col l3 m3 s12">
						<label>Verify : <span id="count_of_verify"></span></label>
					</div>
					<div class="w3-col l3 m3 s12">
						<label>Done : <span id="count_of_done"></span></label>
					</div>
				</div>
				<div class="w3-row w3-margin-top">
					<div class="w3-col l6 m6 s12">
						<label>Total documents uploaded : <span id="count_of_documents"></span></label>
					</div>
					<div class="w3-col l6 m6 s12">
						<label>Total images uploaded : <span id="count_of_images"></span></label>
					</div>
				</div>
				<br>
			</div>
		</div>
		<script>
			$(document).ready(function() {
				get_project();
			});
		</script>
	<?php
	} else {
	?>
		<div class="w3-center w3-margin-top">You don't have privilege to see reports</div>
	<?php
	}
	?>
</body>

</html>