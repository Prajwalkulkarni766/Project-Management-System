// open report of clicked project
function open_project_reprot(id) {
	// debugger;
	$.ajax({
		type: "post",
		url: "dal/dal_reports.php",
		data: {
			get_project_content_to_generate_report: "get_project_content_to_generate_report",
			id: id,
		},
		success: function (response) {
			// debugger;
			if (response != "") {
				document.getElementById("project_name_heading_for_report").innerHTML = document.getElementById("project_name" + id).innerHTML;
				let splitted_response = response.split("#");
				document.getElementById("count_of_do_it").innerHTML = splitted_response[0];
				document.getElementById("count_of_in_progess").innerHTML = splitted_response[1];
				document.getElementById("count_of_verify").innerHTML = splitted_response[2];
				document.getElementById("count_of_done").innerHTML = splitted_response[3];
				document.getElementById("count_of_documents").innerHTML = splitted_response[4];
				document.getElementById("count_of_images").innerHTML = splitted_response[5];
				let percentage = parseFloat(parseFloat(splitted_response[3]) / (parseFloat(splitted_response[3]) + parseFloat(splitted_response[2]) + parseFloat(splitted_response[1]) + parseFloat(splitted_response[0]))) * 100;
				if (isNaN(parseFloat(percentage))) {
					percentage = 0;
				}
				percentage = percentage.toFixed(2);
				document.getElementById("percentage_holding_div").style.width = percentage + "%";
				document.getElementById("percentage_holding_div").innerHTML = percentage + "%";
				document.getElementById("report_holding_div").style.display = "block";
			}
		},
	});
}