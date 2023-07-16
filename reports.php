<!DOCTYPE html>
<html lang="en">

<head>
	<?php
	include 'header.php';
	?>
	<script src="jquery/reports.js"></script>
	<style>
   .scroll {
        max-width: 99vw;
        overflow-x: auto;
        overflow-y: hidden;
        white-space: nowrap;
		background-color:#4169E1
   }
   .scroll_for_small{
        max-width: 90vw;
        overflow-x: auto;
        overflow-y: hidden;
        white-space: nowrap;
		background-color:#4169E1
   }
</style>
</head>

<body class="">
	<?php
	$user_id = $_SESSION['user_id'];
	include 'dal/dal_db.php';
	include 'menu.php';
	?>
  <div class="w3-container">
	  <h1>Report</h1>
  </div>
  <div class="w3-margin">
            <div class="scroll_for_small w3-hide-large w3-text-white " id="div_for_showing_btn_when_screen_is_small">
			  
		    </div>
			<div class="scroll w3-hide-small w3-text-white " id="div_for_showing_btn_when_screen_is_large">
			
			</div>
        </div>

<div id="report_holding_div" class="w3-container w3-display-container city" style="display:none">
  <span onclick="this.parentElement.style.display='none'"
  class="w3-button w3-large w3-display-topright">&times;</span>
  <h2 id="project_name_heading_for_report"></h2>
  <div>	<div class="w3-section w3-light-gray w3-padding">
			<div class="w3-container w3-padding-small w3-green w3-center" id="percentage_holding_div"></div>
		</div>
	  <div class="w3-row">
		<div class="w3-col l3 m3 s12">
			<label>Do it : <span id="count_of_do_it"></span></label>
		</div>
		<div class="w3-col l3 m3 s12">
			<label>Verify : <span id="count_of_verify"></span></label>
		</div>
		<div class="w3-col l3 m3 s12">
			<label>In progress : <span id="count_of_in_progess"></span></label>
		</div>
		<div class="w3-col l3 m3 s12">
			<label>Done : <span id="count_of_done"></span></label>
		</div>
	  </div>
	  <br>
	</div>
</div>



<script>
$( document ).ready(function(){
    $.ajax({
    type: "post",
    url: "dal/dal_reports.php",
    data: {
     get_project_name_list:"get_project_name_list",
    },
    success: function (response) {
      debugger;
	  let splitted_response = response.split("@");
	  var index_of_response = 0;
	  while(index_of_response < splitted_response.length){
		$( "#div_for_showing_btn_when_screen_is_small" ).append(splitted_response[index_of_response]);
	    $( "#div_for_showing_btn_when_screen_is_large" ).append(splitted_response[index_of_response]);  
		index_of_response++;
	  }
    },
  });
});
</script>
</body>
</html>