<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <?php
    include 'header.php';
    ?>
    <script src="jquery/document_upload.js"></script>
</head>

<body onload="get_project()">
    <?php
    $user_name = $_SESSION['user_name'];
    include 'dal/dal_db.php';
    include 'menu.php';
    if (isset($_SESSION['privilege_for_upload_documents']) && $_SESSION['privilege_for_upload_documents'] > 0 || isset($_SESSION['privilege_for_delete_uploaded_documents']) &&  $_SESSION['privilege_for_delete_uploaded_documents'] > 0) {
    ?>
        <div class="w3-container ">
            <h1>Document Upload</h1>
        </div>
        <?php
        include 'project_list.php';
        ?>
        <div class="w3-container w3-col l9 m9 s12" id="document_upload_section" style="display:none">
            <?php
            if ($_SESSION['privilege_for_upload_documents'] > 0) {
            ?>
                <div class="w3-bar">
                    <div class="w3-bar-item w3-quarter w3-padding group" id="upload_btn_div">
                        <button class="w3-button w3-green" onclick="click_on_input()">Upload New Documents</button>
                    </div>
                    <div class="w3-bar-item w3-quarter w3-padding group" id="clear_selection_div" style="display: none;">
                        <button class="w3-button w3-red" onclick="clear_selection()">Clear Selection</button>
                    </div>
                    <div class="w3-bar-item w3-quarter w3-padding group" id="upload_selection_div" style="display: none;">
                        <button class="w3-button w3-green" onclick="upload_files()">Upload Selected Files</button>
                    </div>
                    <div class="w3-bar-item w3-quarter w3-padding group w3-hide">
                        <form method="post" action="" enctype="multipart/form-data" id="myform">
                            <input type="file" id="file" name="file" accept=".pdf,.doc,.docx,.docm,.dotx,.dotm,.dot,.xps,.odt,.csv,.xlsx,.xlsm,.xlsb,.xltx,.xls,.pptx,.pptm,.ppt,.xps,.potx,.potm,.pot,.ppsx,.pps,.ppsm,.ppa,.xml,.odp" onchange="showPreview(event)" multiple />
                            <p id="num-of-files" style="display: none">No files chosen</p>
                        </form>
                    </div>
                </div>
            <?php
            }
            ?>
            <input id="project_id" name="project_id" class="w3-hide" type="text" />
            <div class="w3-container" id="selected_file_heading_div" style="display:none">
                <h4>Selected Documents</h4>
                <div id="selected_file_display_div" class="w3-container"></div>
            </div>
            <div class="w3-container" id="uploaded_file_heading_div" style="display:none">
                <h4>Uploaded Documents</h4>
                <div id="uploaded_file_display_div" class="w3-container"></div>
            </div>
            <span class="w3-hide" id="status_of_delete_document_right"><?php echo $_SESSION['privilege_for_delete_uploaded_documents']; ?></span>
        </div>
    <?php
    } else {
    ?>
        <div class="w3-center w3-margin-top">You don't have privilege to upload the document</div>
    <?php
    }
    ?>
</body>

</html>