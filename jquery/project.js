function get_project() {
  debugger;
  let index_for_splited_response = 0;
  let table = document.getElementById("tbl_id");
  $.ajax({
    type: "post",
    url: "dal/dal_project.php",
    data: {
      get_project: "get_project",
    },
    success: function (response) {
      debugger;
      let splited_response = response.split("*");
      while (index_for_splited_response < splited_response.length - 1) {
        let sub_splited_response =
          splited_response[index_for_splited_response].split("#");
        table_row =
          "<tr><td class='w3-center'>" +
          table.rows.length +
          "</td><td id='project_id" +
          table.rows.length +
          "' class='w3-center w3-hide'>" +
          sub_splited_response[0] +
          "</td><td id='project_name" +
          table.rows.length +
          "' class='w3-center'>" +
          sub_splited_response[1] +
          "</td><td id='project_description" +
          table.rows.length +
          "' class='w3-center w3-hide'>" +
          sub_splited_response[2] +
          "</td><td id='project_added_date" +
          table.rows.length +
          "' class='w3-center w3-hide'>" +
          sub_splited_response[3] +
          "</td><td class='w3-center' onclick='show_info(" +
          table.rows.length +
          ")'><a><i class='fa fa-info-circle' aria-hidden='true'></i></a></td></tr>";
        table.insertRow(table.rows.length).outerHTML = table_row;
        index_for_splited_response++;
      }
    },
  });
}

function show_info(id) {
  debugger;
  document.getElementById("modal_project_name").value = document.getElementById(
    "project_name" + id
  ).innerHTML;
  document.getElementById("modal_project_date").value = document
    .getElementById("project_added_date" + id)
    .innerHTML.split(" ")[0];
  document.getElementById("modal_project_time").value = document
    .getElementById("project_added_date" + id)
    .innerHTML.split(" ")[1];
  document.getElementById("modal_project_description").value =
    document.getElementById("project_description" + id).innerHTML;
  document.getElementById("modal_to_display_info_about_project").style.display =
    "block";
}