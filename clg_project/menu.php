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
     <div class="w3-bar-item group w3-padding-top w3-hide-small">
       <label class=" w3-xlarge">Welcome <span id="user_name"> <?php echo $user_name; ?> </span></label>
     </div>
     <div class="w3-bar-item group w3-right">
       <button class="w3-button w3-xlarge" onclick="log_out()" title="Logout"><i class="fa fa-sign-out fa-fw"></i></button>
     </div>
   </div>

   <div class="w3-padding-top w3-sidebar w3-bar-block w3-dark-grey w3-animate-left" style="display:none;width:300px" id="mySidebar">
     <div class="w3-bar-item w3-margin-top w3-hide-large w3-hide-medium">
       <label class="w3-large">Welcome <?php echo $user_name; ?></label>
     </div>
     <?php
      if ($_SESSION['privilege_for_view_dashboard'] > 0) {
      ?>
       <a href="home.php" class="w3-bar-item w3-button"><i class="fa fa-home" aria-hidden="true"></i>
         &nbsp; Home</a>
     <?php
      }
      ?>
     <?php
      if ($_SESSION['privilege_for_view_project'] > 0) {
      ?>
       <a href="project.php" class="w3-bar-item w3-button"><i class="fa fa-folder-open" aria-hidden="true"></i>
         &nbsp; Project</a>
     <?php
      }
      ?>
     <?php
      if ($_SESSION['privilege_for_view_reports'] > 0) {
      ?>
       <a href="reports.php" class="w3-bar-item w3-button"><i class="fa fa-file" aria-hidden="true"></i>
         &nbsp; Report</a>
     <?php
      }
      ?>
     <?php
      if ($_SESSION['privilege_to_change_privilege'] > 0) {
      ?>
       <a href="privileges.php" class="w3-bar-item w3-button"><i class="fa fa-eye-slash" aria-hidden="true"></i>
         &nbsp; Privilege</a>
     <?php
      }
      ?>
     <?php
      if ($_SESSION['privilege_for_create_user'] > 0 || $_SESSION['privilege_for_view_and_edit_created_user'] > 0) {
      ?>
       <a href="users.php" class="w3-bar-item w3-button"><i class="fa fa-users" aria-hidden="true"></i>
         &nbsp; User</a>
     <?php
      }
      ?>
     <?php
      if ($_SESSION['privilege_for_upload_images'] > 0 || $_SESSION['privilege_for_delete_uploaded_images'] > 0) {
      ?>
       <a href="gallery.php" class="w3-bar-item w3-button"><i class="fa fa-camera" aria-hidden="true"></i>
         &nbsp; Gallery</a>
     <?php
      }
      ?>
     <?php
      if ($_SESSION['privilege_for_upload_documents'] > 0 || $_SESSION['privilege_for_delete_uploaded_documents'] > 0) {
      ?>
       <a href="document_upload.php" class="w3-bar-item w3-button"><i class="fa fa-book" aria-hidden="true"></i>
         &nbsp; Document Upload</a>
     <?php
      }
      ?>
     <a href="help.php" class="w3-bar-item w3-button"><i class="fa fa-question" aria-hidden="true"></i>
       &nbsp; Help</a>
     <a href="issue.php" class="w3-bar-item w3-button"><i class="fa fa-question" aria-hidden="true"></i>
       &nbsp; Report issue</a>
   </div>
 </div>

 <div id="popup_about_system_info" class="w3-modal">
   <div class="w3-modal-content">
     <header class="w3-container">
       <span onclick="document.getElementById('popup_about_system_info').style.display='none';" class="w3-xlarge w3-button w3-display-topright">&times;</span>
       <h3 class="w3-padding-left" id="heading_of_popup">Hello <?php echo $user_name; ?></h3>
     </header>
     <div class="w3-container" id="content_of_popup">
       <div class="w3-padding w3-center">
         <img src="img/microsoft-project-480.png" alt="Project Management System Icon" class="w3-image" height="2vh" width="200vw">
       </div>
       <div class="w3-padding">
         Welcome to <b>Project Management System</b>. Project management is a visual process and project management tool , it is a way to visualize your work and limit the amount of work in progress at any one time.
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

 <div class="alerty alerty-show" id="new-confirm" style="margin-top: -85.5px;display:none">
   <div class="alerty-title">Confirm</div>
   <div class="alerty-content">
     <p class="alerty-prompt" id="new-confirm-msg"></p>
   </div>
   <div class="alerty-action"><a class="btn-ok" onclick='ask_question()'>OK</a><a class="btn-cancel" onclick='document.getElementById("new-confirm").style.display = "none";'>Cancel</a></div>
 </div>

 <div id="loading_gif" class="w3-display-middle" style="display:none;"><img src="img/spinner.gif"></div>
 <script>
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
    //  debugger;
     $.ajax({
       type: "post",
       url: "dal/dal_login_signup.php",
       data: {
         log_out: "log_out",
       },
       success: function(response) {
        //  debugger;
         location.href = "login.php";
       },
     });
   }

   $(document).ajaxStart(function() {
    //  debugger;
     document.getElementById("loading_gif").style.display = "block";
   });
   $(document).ajaxStop(function() {
    //  debugger;
     document.getElementById("loading_gif").style.display = "none";
   });
 </script>