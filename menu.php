  <style>
   #bg_color 
{
  font-family:Arial; 
  background: -webkit-linear-gradient(to right, #155799, #159957); 
  background: linear-gradient(to right, #155799, #159957); 
  color:whitesmoke;
  }
  </style>
  <div>

    <?php
    $user_id = $_SESSION['user_id'];
    $user_name = $_SESSION['user_name'];
    ?>
    <div class="w3-bar w3-border-bottom" id="bg_color">
      <div class="w3-bar-item group" id="show_btn_div">
        <button class="w3-button w3-xlarge" onclick="w3_open()">&#9776;</button>
      </div>
      <div class="w3-bar-item group" id="hide_btn_div" style="display:none;">
        <button class="w3-bar-item w3-button w3-xlarge" onclick="w3_close()">&times;</button>
      </div>
      <div class="w3-bar-item group w3-padding-top w3-hide-small" >
        <label class=" w3-xlarge">Welcome <span id="user_name"> <?php echo $user_name; ?> </span></label>
      </div>
      <div class="w3-bar-item group w3-right">
        <button class="w3-button w3-xlarge" onclick="log_out()" title="Logout"><i class="fa fa-sign-out fa-fw"></i></button>
      </div>
    </div>

    <div class="w3-padding-top w3-sidebar w3-bar-block w3-dark-grey w3-animate-left" style="display:none;width:300px" id="mySidebar">
      <div class="w3-bar-item w3-padding-top w3-hide-large">
        <label class="w3-large">Welcome <?php echo $user_name; ?></label>
      </div>
      <a href="home.php" class="w3-bar-item w3-button">Home</a>
      <a href="project.php" class="w3-bar-item w3-button">Projects</a>
      <a href="reports.php" class="w3-bar-item w3-button">Reports</a>
      <a href="help.php" class="w3-bar-item w3-button">Help</a>
    </div>
  </div>

  <div id="popup_about_system_info" class="w3-modal">
    <div class="w3-modal-content">
      <header class="w3-container">
        <span onclick="document.getElementById('popup_about_system_info').style.display='none';" class="w3-xlarge w3-button w3-display-topright">&times;</span>
        <h3 class="w3-padding-left" id="heading_of_popup">Hello <?php echo $user_name; ?></h3>
        <label class="w3-hide" id="label_to_identify_no_of_popup">1</label>
      </header>
      <div class="w3-container" id="content_of_popup">
        <div class="w3-padding w3-center">
          <img src="img/microsoft-project-480.png" alt="Project Management System Icon" class="w3-image" height="2vh" width="200vw">
        </div>
        <div class="w3-padding">
          Welcome to <b>Project Management System</b>. Project management is a visual process and project management tool , it is a way to visualize your work and limit the amount of work in progress at any one time.
        </div>
      </div>
      <footer class="w3-container">
        <div class="w3-bar">
          <div id="backward_btn" class="w3-bar-item" style="display: none;">
            <button class="w3-button w3-border" onclick="get_previous_content_of_popup()"><i class="fa fa-chevron-circle-left" aria-hidden="true"></i></button>
          </div>
          <div id="forward_btn" class="w3-bar-item w3-right">
            <button class="w3-button w3-border w3-bar-item" onclick="document.getElementById('label_to_identify_no_of_popup').innerHTML = parseInt(document.getElementById('label_to_identify_no_of_popup').innerHTML) + 1;get_next_content_of_popup()"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i></button>
          </div>
        </div>
      </footer>
    </div>
  </div>

  <div class="alerty alerty-show" id="new-alert" style="margin-top: -85.5px;display:none">
    <div class="alerty-title">Alert</div>
    <div class="alerty-content">
      <p class="alerty-message" id="new-alert-msg"></p>
    </div>
    <div class="alerty-action"><a class="btn-ok" onclick='document.getElementById("new-alert").style.display = "none";'>OK</a></div>
  </div>

  <div id="modal_of_add_project" class="w3-modal">
    <div class="w3-modal-content">
      <header class="w3-container">
        <span onclick="document.getElementById('modal_of_add_project').style.display='none';document.getElementById('project_name').value = '';document.getElementById('project_description').value = ''" class="w3-xlarge w3-button w3-display-topright">&times;</span>
        <h3 class="w3-padding-left">Add Project</h3>
      </header>
      <div>
        <div class="w3-padding">
          <div class="w3-bar-item"><label>Project Name : </label></div>
          <div class="w3-bar-item"><input id="project_name" class="w3-input w3-border" maxlength="20"></div>
        </div>
        <div class="w3-margin-top w3-padding ">
          <div class="w3-bar-item"><label>Project Description : </label></div>
          <div class="w3-bar-item"><textarea id="project_description" maxlength="1000"></textarea></div>
        </div>
      </div>
      <footer class="w3-container">
        <div class="w3-right w3-padding-small">
          <button class="w3-button w3-red w3-border" title="cancel" onclick="document.getElementById('modal_of_add_project').style.display='none';document.getElementById('project_name').value = '';document.getElementById('project_description').value = ''">Cancel</button>
          <button class="w3-button w3-green w3-border" title="Save" onclick="add_project()">Save</button>
        </div>
      </footer>
    </div>
  </div>

  <div id="loading_gif" class="w3-display-middle" style="display:none;"><img src="img/spinner.gif"></div>
  <script>
    function add_project() {
      debugger;
      let project_name = document.getElementById("project_name").value;
      let project_description = document.getElementById(
        "project_description"
      ).value;
      let table = document.getElementById("tbl_id");
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
        success: function(response) {
          debugger;
          let splited_response = response.split("#");
          if (splited_response[0] == "added") {
            document.getElementById("modal_of_add_project").style.display =
              "none";
            document.getElementById("project_name").value = "";
            document.getElementById("project_description").value = "";
			if(table != null)
			{
				let sub_splited_response = splited_response[1].split(" ");
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
              project_name +
              "</td><td id='project_description" +
              table.rows.length +
              "' class='w3-center w3-hide'>" +
              project_description +
              "</td><td id='project_added_date" +
              table.rows.length +
              "' class='w3-center w3-hide'>" +
              sub_splited_response[1] +
              " " +
              sub_splited_response[2] +
              "</td><td class='w3-center'><a onclick='show_info(" +
              table.rows.length +
              ")'><i class='fa fa-info-circle' aria-hidden='true'></i></a></td></tr>";
            table.insertRow(table.rows.length).outerHTML = table_row;
			}
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

    function w3_open() {
      document.getElementById("show_btn_div").style.display = "none";
      document.getElementById("hide_btn_div").style.display = "block";
      document.getElementById("mySidebar").style.display = "block";
    }

    function w3_close() {
      document.getElementById("show_btn_div").style.display = "block";
      document.getElementById("hide_btn_div").style.display = "none";
      document.getElementById("mySidebar").style.display = "none";
    }

    function log_out() {
      debugger;
      $.ajax({
        type: "post",
        url: "dal/dal_login_signup.php",
        data: {
          log_out: "log_out",
        },
        success: function(response) {
          debugger;
          location.href = "login.php";
        },
      });
    }

    $(document).ajaxStart(function() {
      debugger;
      document.getElementById("loading_gif").style.display = "block";
    });
    $(document).ajaxStop(function() {
      debugger;
      document.getElementById("loading_gif").style.display = "none";
    });
  </script>