<?php
include 'dal/dal_db.php';
session_start();

if (isset($_POST['delete_the_image'])) {
    mysqli_query($con, "set @out_parameter=" . $_POST['img_id']);
    mysqli_query($con, "CALL sp_gallery(@out_parameter,'','','',$_POST[project_id],0,2)");
    $rs2 = mysqli_query($con, "SELECT @out_parameter as out_parameter ");
    $row = mysqli_fetch_assoc($rs2);
    if (isset($row['out_parameter'])) {
        unlink("$row[out_parameter]");
        echo "1";
    } else {
        echo "0";
    }
    mysqli_close($con);
    exit();
}
