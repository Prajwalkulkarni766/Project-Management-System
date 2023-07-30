<!DOCTYPE html>
<html lang="en">

<head>
    <?php
    include 'header.php';
    ?>
    <link rel="stylesheet" href="css/responsive-table.css">
    </link>
</head>

<body>
    <?php
    include 'dal/dal_db.php';
    include 'menu.php';
    // checking user have right or privilege to view privilege
    if (isset($_SESSION['privilege_to_change_privilege']) && $_SESSION['privilege_to_change_privilege'] > 0) {
    ?>
        <script src="jquery/privileges.js"></script>
        <div class="w3-container w3-bar">
            <h1 class="w3-bar-item">Privileges</h1>
            <button onclick="get_privilege_data()" class="w3-xlarge w3-bar-item w3-margin-top w3-hover-text-green w3-right w3-button" title="Refresh or Get"><i class="fa fa-refresh" aria-hidden="true"></i></i></button>
        </div>
        <div id="privilege_tbl_holding_div" class="w3-margin"></div>
    <?php
    } else {
    ?>
        <div class="w3-center w3-margin-top">You don't have privilege to see change privilege table</div>
    <?php
    }
    ?>
</body>

</html>