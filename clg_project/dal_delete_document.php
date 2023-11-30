<?php
include 'dal/dal_db.php';
session_start();

if (isset($_POST['delete_the_file'])) {
    mysqli_query($con, "set @out_parameter=" . $_POST['document_id']);
    mysqli_query($con, "CALL sp_document(@out_parameter,'','','',$_POST[project_id],0,2)");
    $rs2 = mysqli_query($con, "SELECT @out_parameter as out_parameter ");
    $row = mysqli_fetch_assoc($rs2);
    if ($row['out_parameter'] > 0) {
        $path = $_POST['path'];
        unlink("$path");
        echo $row['out_parameter'];
    }
    mysqli_close($con);
    exit();
}
