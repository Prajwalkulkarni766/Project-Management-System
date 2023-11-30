// function to add new content / problem to do it section
function save_do_it_content() {
  debugger;
  let do_it_content = document.getElementById("do_it_content").value;
  if (do_it_content == "") {
    document.getElementById("new-alert-msg").innerHTML =
      "Please enter some content to save it";
    document.getElementById("new-alert").style.display = "block";
    document.getElementById("do_it_content").focus();
    return;
  }
  let project_name = document.getElementById("project").value;
  let project_id = $('#project_list option[value="' + project_name + '"]').attr(
    "id"
  );
  $.ajax({
    type: "post",
    url: "dal/dal_home.php",
    data: {
      save_do_it_content_to_tbl: "save_do_it_content_to_tbl",
      do_it_content: do_it_content,
      project_id: project_id,
    },
    success: function (response) {
      debugger;
      let splitted_response = response.split("#");
      if (splitted_response[0] == "added") {
        document.getElementById("modal_to_take_do_it_content").style.display =
          "none";
        document.getElementById("do_it_content").value = "";
        document.getElementById("new-alert-msg").innerHTML =
          "The content added";
        document.getElementById("new-alert").style.display = "block";
        let div =
          '<div id="drag' +
          splitted_response[1] +
          '" class="w3-border w3-padding w3-margin-bottom w3-conatiner w3-round" draggable="true" ondragstart="drag(event)">' +
          do_it_content +
          "</div>";

        document.getElementById("do_it_content_div").innerHTML += div;
      } else if (splitted_response[0] == "not_added") {
        document.getElementById("new-alert-msg").innerHTML =
          "The content is not saved please try again";
        document.getElementById("new-alert").style.display = "block";
      }
      calculate_no_of_content();
    },
  });
}

// function to get content / problem of selected project
function search_of_selected_project() {
  debugger;
  let project_name = document.getElementById("project").value;
  let project_id = $('#project_list option[value="' + project_name + '"]').attr(
    "id"
  );
  localStorage.setItem("project_name", project_name);
  if (!project_name && !project_id) {
    valid_project_choice(1);
  }
  $.ajax({
    type: "post",
    url: "dal/dal_home.php",
    data: {
      get_content_of_selected_project: "get_content_of_selected_project",
      project_id: project_id,
    },
    success: function (response) {
      debugger;
      if (document.getElementById("plus_icon_to_add_content")) {
        document.getElementById("plus_icon_to_add_content").style.display = "block";
      }
      document.getElementById("do_it_content_div").innerHTML = "";
      document.getElementById("in_progress_content_div").innerHTML = "";
      document.getElementById("verify_content_div").innerHTML = "";
      document.getElementById("done_content_div").innerHTML = "";
      let splitted_response = response.split("#");
      let div_index = 0;
      while (div_index < splitted_response.length) {
        let sub_splitted_response = splitted_response[div_index].split("@");
        if (sub_splitted_response[0] == 1) {
          document.getElementById("do_it_content_div").innerHTML +=
            sub_splitted_response[1];
        } else if (sub_splitted_response[0] == 2) {
          document.getElementById("in_progress_content_div").innerHTML +=
            sub_splitted_response[1];
        } else if (sub_splitted_response[0] == 3) {
          document.getElementById("verify_content_div").innerHTML +=
            sub_splitted_response[1];
        } else if (sub_splitted_response[0] == 4) {
          document.getElementById("done_content_div").innerHTML +=
            sub_splitted_response[1];
        }
        div_index++;
      }
      calculate_no_of_content();
    },
  });
}

// function to check user have previously selected any project if yes then add this to input box and fetch data
function to_check_previous_project_input_value() {
  debugger;
  if (
    localStorage.getItem("user_name") ==
    document.getElementById("user_name").innerHTML
  ) {
    if (
      localStorage.getItem("project_name") &&
      localStorage.getItem("project_name") != ""
    ) {
      document.getElementById("project").value =
        localStorage.getItem("project_name");
      valid_project_choice(1);
      search_of_selected_project();
    }
  } else {
    localStorage.setItem(
      "user_name",
      document.getElementById("user_name").innerHTML
    );
  }
}

// function to allow drop in the section
function allowDrop(ev) {
  ev.preventDefault();
}

// function to drag the content / problem
function drag(ev) {
  ev.dataTransfer.setData("text", ev.target.id);
}

// function to drop the content in another section and save it
function drop_and_save(ev, id) {
  debugger;
  ev.preventDefault();
  var data = ev.dataTransfer.getData("text");
  var content = ev.dataTransfer.getData("text");
  var content_id = content.replace(/^\D+/g, "");
  let project_name = document.getElementById("project").value;
  let project_id = $('#project_list option[value="' + project_name + '"]').attr(
    "id"
  );
  $.ajax({
    type: "post",
    url: "dal/dal_home.php",
    data: {
      move_content: "move_content",
      id: id,
      project_id: project_id,
      content_id: content_id,
    },
    success: function (response) {
      debugger;
      if (response == "added") {
        if (id == 1) {
          document
            .getElementById("do_it_content_div")
            .appendChild(document.getElementById(data));
        } else if (id == 2) {
          document
            .getElementById("in_progress_content_div")
            .appendChild(document.getElementById(data));
        } else if (id == 3) {
          document
            .getElementById("verify_content_div")
            .appendChild(document.getElementById(data));
        } else if (id == 4) {
          document
            .getElementById("done_content_div")
            .appendChild(document.getElementById(data));
        }
      } else if (response == "not_added") {
        document.getElementById("new-alert-msg").innerHTML =
          "Problem while moving content";
        document.getElementById("new-alert").style.display = "block";
      }
      calculate_no_of_content();
    },
  });
}

// function to check user selected valid project or not
function valid_project_choice(id) {
  debugger;
  if (id != "") {
    let project_name = document.getElementById("project").value;
    if (project_name != "") {
      let project_id = $(
        '#project_list option[value="' + project_name + '"]'
      ).attr("id");
      if (project_id == undefined) {
        document.getElementById("new-alert-msg").innerHTML =
          "Please select valid project name from list";
        document.getElementById("new-alert").style.display = "block";
        document.getElementById("project").value = "";
        document.getElementById("project").focus();
        document.getElementById("do_it_content_div").innerHTML = "";
        document.getElementById("in_progress_content_div").innerHTML = "";
        document.getElementById("verify_content_div").innerHTML = "";
        document.getElementById("done_content_div").innerHTML = "";
        document.getElementById("no_of_content_of_do_it_section").style.display = "none";
        document.getElementById("no_of_content_of_in_progress_section").style.display = "none";
        document.getElementById("no_of_content_of_verify_section").style.display = "none";
        document.getElementById("no_of_content_of_done_section").style.display = "none";
        if (document.getElementById("plus_icon_to_add_content")) {
          document.getElementById("plus_icon_to_add_content").style.display = "none";
        }
        return;
      }
      else {
        search_of_selected_project()
      }
    }
    else {
      document.getElementById("do_it_content_div").innerHTML = "";
      document.getElementById("in_progress_content_div").innerHTML = "";
      document.getElementById("verify_content_div").innerHTML = "";
      document.getElementById("done_content_div").innerHTML = "";
      document.getElementById("no_of_content_of_do_it_section").style.display = "none";
      document.getElementById("no_of_content_of_in_progress_section").style.display = "none";
      document.getElementById("no_of_content_of_verify_section").style.display = "none";
      document.getElementById("no_of_content_of_done_section").style.display = "none";
      if (document.getElementById("plus_icon_to_add_content")) {
        document.getElementById("plus_icon_to_add_content").style.display = "none";
      }
    }
  }
}

// function to calculate no of content present in the section
function calculate_no_of_content() {
  debugger;
  document.getElementById("no_of_content_of_do_it_section").style.display = "inline-block";
  document.getElementById("no_of_content_of_in_progress_section").style.display = "inline-block";
  document.getElementById("no_of_content_of_verify_section").style.display = "inline-block";
  document.getElementById("no_of_content_of_done_section").style.display = "inline-block";
  document.getElementById("no_of_content_of_do_it_section").innerHTML =
    $("#do_it_content_div").children("div").length;
  document.getElementById("no_of_content_of_in_progress_section").innerHTML = $(
    "#in_progress_content_div"
  ).children("div").length;
  document.getElementById("no_of_content_of_verify_section").innerHTML = $(
    "#verify_content_div"
  ).children("div").length;
  document.getElementById("no_of_content_of_done_section").innerHTML =
    $("#done_content_div").children("div").length;
}

function convertToExcel(){
  let project_name = document.getElementById("project").value;
  let project_id = $('#project_list option[value="' + project_name + '"]').attr(
    "id"
  );
  window.open(`hometoexcel.php?project_id=${project_id}`);
}