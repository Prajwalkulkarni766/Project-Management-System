<!DOCTYPE html>
<html lang="en">

<head>
    <?php
    include 'header.php';
    ?>
</head>

<body onload="get_project()">
    <?php
    include 'dal/dal_db.php';
    include 'menu.php';
    // checking user have right or privilege to view or upload images
    if (isset($_SESSION['privilege_for_upload_images']) && $_SESSION['privilege_for_upload_images'] > 0 || isset($_SESSION['privilege_for_delete_uploaded_images']) && $_SESSION['privilege_for_delete_uploaded_images'] > 0) {
    ?>
        <script src="jquery/gallery.js"></script>
        <div class="w3-container ">
            <h1>Gallery</h1>
        </div>
        <?php
        include 'project_list.php';
        ?>
        <div class="w3-container w3-col l9 m9 s12" id="image_upload_section" style="display:none">
            <?php
            if ($_SESSION['privilege_for_upload_images'] > 0) {
            ?>
                <div class="w3-bar">
                    <div class="w3-bar-item w3-quarter w3-padding group" id="upload_btn_div">
                        <button class="w3-button w3-green" onclick="click_on_input_of_upload_image()">Upload New Images</button>
                    </div>
                    <div class="w3-bar-item w3-quarter w3-padding group" id="clear_selection_div" style="display: none;">
                        <button class="w3-button w3-red" onclick="clear_selection_of_images()">Clear Selection</button>
                    </div>
                    <div class="w3-bar-item w3-quarter w3-padding group" id="upload_selection_image_div" style="display: none;">
                        <button class="w3-button w3-green" onclick="upload_files()">Upload Selected Images</button>
                    </div>
                    <div class="w3-bar-item w3-quarter w3-padding group w3-hide">
                        <form method="post" action="" enctype="multipart/form-data" id="myform">
                            <input type="file" id="image" name="file" accept="image/*" onchange="showPreview(event)" multiple />
                            <input id="project_id" name="project_id" type="text" />
                            <p id="num-of-files" style="display: none">No files chosen</p>
                        </form>
                    </div>
                </div>
            <?php
            } ?>
            <div class="w3-container" id="selected_image_heading_div" style="display:none">
                <h4>Selected Images</h4>
                <div id="selected_image_display_div" class="w3-container"></div>
            </div>
            <div class="w3-container" id="uploaded_image_heading_div" style="display:none">
                <h4>Uploaded Images</h4>
                <div id="uploaded_image_display_div" class="w3-container"></div>
            </div>
            <span id="status_of_delete_images" class="w3-hide"><?php echo $_SESSION['privilege_for_delete_uploaded_images']; ?></span>
        </div>
    <?php
    } else {
    ?>
        <div class="w3-center w3-margin-top">You don't have privilege to upload the image</div>
    <?php
    }
    ?>
</body>

</html>