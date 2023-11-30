<?php
include "dal_db.php";
session_start();

if (isset($_POST["reportIssue"])) {
    if (mysqli_query($con, "Insert into tbl_issue (issue, issue_reported_by, issue_reported_date) values ('$_POST[issue]', $_SESSION[user_id], current_timestamp)")) {
        echo "1";
    } else {
        echo "0";
    }
}
