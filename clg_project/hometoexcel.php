<?php
include 'dal/dal_db.php';
$project_id = mysqli_real_escape_string($con, $_GET['project_id']);

$resultOfDoitSection = mysqli_query($con, "select * from tbl_content where project_id = $project_id and section_holding_ids = 1");

if (mysqli_num_rows($resultOfDoitSection) > 0) {
    $contentOfDoit = "<table style='border: 1px solid black;border-collapse:collapse;'><tr><td style='text-align:center;font-weight:bold;' colspan='2'>Do it content</td></tr>";
    $contentOfDoit .= "<tr><th style='border: 1px solid black;'>Content</th><th style='border: 1px solid black;'>Content added date</th></tr><tbody>";
    while ($row = mysqli_fetch_array($resultOfDoitSection)) {
        $contentOfDoit .= "<tr>";
        $contentOfDoit .= "<td style='border: 1px solid black;'>" . $row["content"] . "</td>";
        $contentOfDoit .= "<td style='border: 1px solid black;'>" . $row["content_added_date"] . "</td>";
        $contentOfDoit .= "</tr>";
    }
    $contentOfDoit .= "</tbody></table>";
    echo $contentOfDoit . "<br><br>";
}

$resultOfInProgressSection = mysqli_query($con, "select * from tbl_content where project_id = $project_id and section_holding_ids = 2");

if (mysqli_num_rows($resultOfInProgressSection) > 0) {
    $contentOfInProgress = "<table style='border: 1px solid black;border-collapse:collapse;'><tr><td style='text-align:center;font-weight:bold;' colspan='2'>In progress content</td></tr>";
    $contentOfInProgress .= "<tr><th style='border: 1px solid black;'>Content</th><th style='border: 1px solid black;'>Content added date</th></tr>";
    $contentOfInProgress .= "<tbody>";
    while ($row = mysqli_fetch_array($resultOfInProgressSection)) {
        $contentOfInProgress .= "<tr>";
        $contentOfInProgress .= "<td style='border: 1px solid black;'>" . $row["content"] . "</td>";
        $contentOfInProgress .= "<td style='border: 1px solid black;'>" . $row["content_added_date"] . "</td>";
        $contentOfInProgress .= "</tr>";
    }
    $contentOfInProgress .= "</tbody></table>";
    echo $contentOfInProgress . "<br><br>";
}

$resultOfVerifySection = mysqli_query($con, "select * from tbl_content where project_id = $project_id and section_holding_ids = 3");

if (mysqli_num_rows($resultOfVerifySection) > 0) {
    $contentOfVerify = "<table style='border: 1px solid black;border-collapse:collapse;'><tr><td style='text-align:center;font-weight:bold;' colspan='2'>Verify content</td></tr>";
    $contentOfVerify .= "<tr><th style='border: 1px solid black;'>Content</th><th style='border: 1px solid black;'>Content added date</th></tr>";
    $contentOfVerify .= "<tbody>";
    while ($row = mysqli_fetch_array($resultOfVerifySection)) {
        $contentOfVerify .= "<tr>";
        $contentOfVerify .= "<td style='border: 1px solid black;'>" . $row["content"] . "</td>";
        $contentOfVerify .= "<td style='border: 1px solid black;'>" . $row["content_added_date"] . "</td>";
        $contentOfVerify .= "</tr>";
    }
    $contentOfVerify .= "</tbody></table>";
    echo $contentOfVerify . "<br><br>";
}

$resultOfDoneSection = mysqli_query($con, "select * from tbl_content where project_id = $project_id and section_holding_ids = 4");

if (mysqli_num_rows($resultOfDoneSection) > 0) {
    $contentOfDone = "<table style='border: 1px solid black;border-collapse:collapse;'><tr><td style='text-align:center;font-weight:bold;' colspan='2'>Done content</td></tr>";
    $contentOfDone .= "<tr><th style='border: 1px solid black;'>Content</th><th style='border: 1px solid black;'>Content added date</th></tr>";
    $contentOfDone .= "<tbody>";
    while ($row = mysqli_fetch_array($resultOfDoneSection)) {
        $contentOfDone .= "<tr>";
        $contentOfDone .= "<td style='border: 1px solid black;'>" . $row["content"] . "</td>";
        $contentOfDone .= "<td style='border: 1px solid black;'>" . $row["content_added_date"] . "</td>";
        $contentOfDone .= "</tr>";
    }
    $contentOfDone .= "</tbody></table>";
    echo $contentOfDone . "<br><br>";
}

header("Content-Type:application/vnd.ms-excel");
header('Content-Disposition: attachment; filename="name_of_excel_file.xls"');
