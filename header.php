<title>Project</title>
<script src="jquery/jquery.js"></script>
<script src="jquery/jquery.min.js"></script>
<link rel="stylesheet" href="css/font-awesome.min.css">
<link rel="stylesheet" href="css/scroll-bar.min.css">
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="css/alert.min.css">
<link rel="icon" href="img/microsoft-project-480.png" />
<?php
session_start();
if (!isset($_SESSION['user_id']) && !isset($_SESSION['user_name'])) {
       header("Location: login.php");
}
?>