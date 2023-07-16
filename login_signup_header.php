<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="jquery/user_login_signup.js"></script>
<script src="jquery/jquery.js"></script>
<script src="jquery/jquery.min.js"></script>
<link rel="stylesheet" href="css/W3CSS.css">
<link rel="stylesheet" href="css/alert.min.css">
<link rel="icon" href="img/microsoft-project-480.png" />
<div class="alerty alerty-show" id="new-alert" style="margin-top: -85.5px;display:none">
  <div class="alerty-title">Alert</div>
  <div class="alerty-content">
    <p class="alerty-message" id="new-alert-msg"></p>
  </div>
  <div class="alerty-action"><a class="btn-ok" onclick='document.getElementById("new-alert").style.display = "none";'>OK</a></div>
</div>
<div id="loading_gif" class="w3-display-middle" style="display:none;"><img src="img/spinner.gif"></div>
<script>
 $(document).ajaxStart(function() {
      debugger;
      document.getElementById("loading_gif").style.display = "block";
    });
    $(document).ajaxStop(function() {
      debugger;
      document.getElementById("loading_gif").style.display = "none";
    });
</script>