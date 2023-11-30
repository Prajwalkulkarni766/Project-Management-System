<!DOCTYPE html>
<html lang="en">

<head>
    <?php
    include 'header.php';
    ?>
</head>

<body>
    <?php
    include 'dal/dal_db.php';
    include 'menu.php';
    ?>
    <div class="w3-container">
        <div style="width: 70vw; margin: auto;" class="w3-padding">
            <label for="issue" class="">Issue</label>
            <textarea name="issue" id="issue" cols="30" rows="10" placeholder="Enter your issue here ..."></textarea>
            <button class="w3-button w3-xlarge" onclick="reportIssue()"><i class="fa fa-floppy-o" aria-hidden="true"></i></button>
        </div>
    </div>
    <script>
        function reportIssue() {
            debugger;
            let issue = document.getElementById("issue").value;
            $.ajax({
                type: "post",
                url: "dal/dal_issue.php",
                data: {
                    reportIssue: "reportIssue",
                    issue: issue,
                },
                success: function(response) {
                    debugger;
                    if (response == 1) {
                        document.getElementById("issue").value = "";
                        document.getElementById("new-alert-msg").innerHTML =
                            "Issued reported";
                        document.getElementById("new-alert").style.display = "block";
                    } else {
                        document.getElementById("new-alert-msg").innerHTML =
                            "Problem while reporting issue";
                        document.getElementById("new-alert").style.display = "block";
                    }
                },
            });
        }
    </script>

</body>

</html>