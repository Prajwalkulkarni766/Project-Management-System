<?php
include 'dal_db.php';
session_start();

function is_dir_empty($dir)
{
    if (!is_readable($dir)) return null;
    return (count(scandir($dir)) == 2);
}

if (isset($_POST['create_folder'])) {
    $filename = "";
    $project_id = $_POST['project_id'];
    $dir = "../user_uploaded_gallery/" . $project_id;
    if (is_dir($dir) == true) {
        if (is_dir_empty($dir)) {
            // folder is empty
            $show_folder_img = 0;
        } else {
            $show_folder_img = 1; // folder is NOT empty
        }
    } else {
        $creating_dir = mkdir("../user_uploaded_gallery/" . $project_id);
        if ($creating_dir == 1) {
            // folder created successfully
            $show_folder_img = 0;
        } else {
            $show_folder_img = 2;
        }
    }
    if ($show_folder_img == 1) {
        $uploaded_filename = mysqli_query($con, "SELECT * FROM tbl_gallery where project_id = $project_id");
        if (isset($uploaded_filename)) {
            while ($row = mysqli_fetch_array($uploaded_filename)) {
                $filename .= $row['gallery_original_name'] . "+" . $row['gallery_path'] . "+" . $row['gallery_new_name'] . "+" . $row['gallery_id'] . "#";
            }
            echo $filename;
        }
    } else if ($show_folder_img == 0) {
        echo $filename;
    } else if ($show_folder_img == 2) {
        echo "failed";
    }
    exit();
}

if (isset($_FILES['file']['name']) and $_FILES['file']['size'] > 0 and isset($_POST['project_id'])) {
    $fileName = $_FILES['file']['name'];
    $fileTmpName = $_FILES['file']['tmp_name'];
    $fileSize = $_FILES['file']['size'];
    $fileExt = explode('.', $fileName);
    $fileActualExt = strtolower(end($fileExt));
    $fileNameNew = uniqid('', true) . "." . $fileActualExt;
    $fileDestination = "../user_uploaded_gallery/" . $_POST['project_id'] . "/" . $fileNameNew;
    $fileDestinationForUpload = "user_uploaded_gallery/" . $_POST['project_id'] . "/" . $fileNameNew;
    if (move_uploaded_file($fileTmpName, $fileDestination)) {
        mysqli_query($con, "set @out_parameter=0");
        mysqli_query($con, "CALL sp_gallery(@out_parameter,'$fileName','$fileNameNew','$fileDestinationForUpload',$_POST[project_id],$_SESSION[user_id],1)");
        $rs2 = mysqli_query($con, "SELECT @out_parameter as out_parameter ");
        $row = mysqli_fetch_assoc($rs2);
        echo $row['out_parameter'];
        mysqli_close($con);
    } else {
        echo "not uploaded";
    }
    exit();
}