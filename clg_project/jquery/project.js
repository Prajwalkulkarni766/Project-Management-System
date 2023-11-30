// function to show info of project
function show_info(id) {
  debugger;
  if (document.getElementById("save_edited_project")) {
    document.getElementById("save_edited_project").style.display = "none";
  }
  document.getElementById("modal_project_name").disabled = true;
  document.getElementById("modal_project_description").disabled = true;
  if (document.getElementById("edit_project")) {
    document.getElementById("edit_project").style.display = "inline-block";
  }
  document.getElementById("modal_project_name").value = document.getElementById(
    "project_name" + id
  ).innerHTML;
  document.getElementById("modal_project_id").value = document.getElementById("project_id" + id).innerHTML
  document.getElementById("modal_project_date").value = document
    .getElementById("project_added_date" + id)
    .innerHTML.split(" ")[0];
  document.getElementById("modal_project_time").value = document
    .getElementById("project_added_date" + id)
    .innerHTML.split(" ")[1];
  document.getElementById("modal_project_description").value =
    document.getElementById("project_description" + id).innerHTML;
  document.getElementById("project_name_word_count").innerHTML = (document.getElementById("modal_project_name").value).length;
  document.getElementById("project_description_word_count").innerHTML = (document.getElementById("modal_project_description").value).length;
  document.getElementById("project_info_div").style.display = "block";
}

// function to edit project
function edit_project() {
  debugger;
  document.getElementById("edit_project").style.display = "none";
  document.getElementById("modal_project_name").disabled = false;
  document.getElementById("modal_project_description").disabled = false;
  document.getElementById("save_edited_project").style.display = "inline-block";
}

// function to save edited project
function save_edited_project() {
  debugger;
  let project_name = document.getElementById("modal_project_name").value;
  let project_description = document.getElementById("modal_project_description").value;
  let project_id = document.getElementById("modal_project_id").value;
  $.ajax({
    type: "post",
    url: "dal/dal_project.php",
    data: {
      edit_the_project: "edit_the_project",
      project_name: project_name,
      project_description: project_description,
      project_id: project_id,
    },
    success: function (response) {
      debugger;
      if (response > 0) {
        document.getElementById("save_edited_project").style.display = "none";
        document.getElementById("modal_project_name").disabled = true;
        document.getElementById("modal_project_description").disabled = true;
        document.getElementById("edit_project").style.display = "inline-block";
        document.getElementById("project_name" + response).innerHTML = document.getElementById("modal_project_name").value;
        document.getElementById("project_description" + response).innerHTML = document.getElementById("modal_project_description").value;
      }
      else {
        document.getElementById("new-alert-msg").innerHTML =
          "Edited project not saved";
        document.getElementById("new-alert").style.display = "block";
      }
    },
  });
}

// function to add project
function add_project() {
  debugger;
  let project_name = document.getElementById("project_name").value;
  let project_description = document.getElementById(
    "project_description"
  ).value;
  if (project_name == "") {
    document.getElementById("new-alert-msg").innerHTML =
      "Please enter project name";
    document.getElementById("new-alert").style.display = "block";
    document.getElementById("project_name").focus();
    return;
  }
  if (project_description == "") {
    document.getElementById("new-alert-msg").innerHTML =
      "Please enter project description";
    document.getElementById("new-alert").style.display = "block";
    document.getElementById("project_description").focus();
    return;
  }
  $.ajax({
    type: "post",
    url: "dal/dal_project.php",
    data: {
      add_project_to_table: "add_project_to_table",
      project_name: project_name,
      project_description: project_description,
    },
    success: function (response) {
      debugger;
      let project_list_div = document.getElementById("project_list").innerHTML;
      let splited_response = response.split("#");
      if (splited_response[0] == "added") {
        document.getElementById("modal_of_add_project").style.display =
          "none";
        document.getElementById("project_name").value = "";
        document.getElementById("project_description").value = "";
          let sub_splited_response = splited_response[1].split(" ");
          project_list += '<a href="javascript:void(0)" onclick="show_info(' + sub_splited_response[0] + ')" class="w3-bar"><img src="img/microsoft-project-480.png" class="w3-bar-item w3-circle" style="width:85px">';
          project_list += '<div class="w3-large"><h4 id="project_name' + sub_splited_response[0] + '" class="">' + project_name + '</h4><br>';
          project_list += '<span id="project_id' + sub_splited_response[0] + '" class="w3-hide">' + sub_splited_response[0] + '</span>';
          project_list += '<span id="project_description' + sub_splited_response[0] + '" class="w3-hide">' + project_description + '</span>';
          project_list += '<span id="project_added_date' + sub_splited_response[0] + '" class="w3-hide">' +
            sub_splited_response[1] +
            " " +
            sub_splited_response[2] + '</span>';
          project_list += '</div></a>';
          document.getElementById("project_list").innerHTML = " ";
          document.getElementById("project_list").innerHTML = project_list;
        document.getElementById("new-alert-msg").innerHTML =
          "New project added";
        document.getElementById("new-alert").style.display = "block";
      } else {
        document.getElementById("new-alert-msg").innerHTML =
          "There was problem while creating new project";
        document.getElementById("new-alert").style.display = "block";
      }
    },
  });
}