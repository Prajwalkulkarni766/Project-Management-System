<?php
include 'dal/dal_db.php';
session_start();

if (isset($_POST['delete_the_image'])) {
    mysqli_query($con, "set @out_parameter=" . $_POST['img_id']);
    mysqli_query($con, "CALL project_management_system_sp_of_gallery_details('','','',0,0,CURRENT_TIMESTAMP,2,@out_parameter)");
    $rs2 = mysqli_query($con, "SELECT @out_parameter as out_parameter ");
    $row = mysqli_fetch_assoc($rs2);
    if (isset($row['out_parameter'])) {
        unlink("$row[out_parameter]");
        echo "1";
    }
    else{
        echo "0";
    }
    mysqli_close($con);
    exit();
}
