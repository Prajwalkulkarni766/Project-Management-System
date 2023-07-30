// function to create str of img
function create_str_of_img(src, isdelete, id) {
    // debugger;
    let img_str = '';
    let status_of_delete_images = document.getElementById("status_of_delete_images").innerHTML;
    img_str = '<div class="w3-quarter" id="img_div' + id + '"><div class="w3-display-container w3-text-dark"><img src="' + src + '" width="180" height="240">';
    if (isdelete && status_of_delete_images > 0) {
        img_str += '<div style="cursor:pointer;" class="w3-display-topright w3-xxlarge w3-display-hover" onclick="delete_img(' + id + ')">&times;</div>';
    }
    img_str += '</div></div>';
    return img_str;
}

// function to open modal to display the files
function click_on_input_of_upload_image() {
    // debugger;
    document.getElementById("image").click();
}

// function to clear selection of images
function clear_selection_of_images() {
    // debugger;
    document.getElementById("upload_selection_image_div").style.display = "none";
    document.getElementById("clear_selection_div").style.display = "none";
    document.getElementById("selected_image_heading_div").style.display = "none";
    document.getElementById("image").value = "";
    document.getElementById("selected_image_display_div").innerHTML = "";
    document.getElementById("upload_btn_div").style.display = "block";
}

// function to showPreview of selected images
function showPreview(event) {
    // debugger;
    document.getElementById("upload_btn_div").style.display = "none";
    document.getElementById("clear_selection_div").style.display = "block";
    document.getElementById("upload_selection_image_div").style.display = "block";
    document.getElementById("selected_image_heading_div").style.display = "block";
    let selected_file = $("#image")[0].files;
    let img_holding_div = document.getElementById("selected_image_display_div");
    let img_index = 0;
    let img;
    while (img_index < selected_file.length) {
        let src = URL.createObjectURL(selected_file[img_index]);
        img = create_str_of_img(src, false, img_index);
        img_holding_div.innerHTML += img;
        img_index++;
    }
}

// function to create folder of project image
function create_folder_of_project_image(project_id) {
    // debugger;
    document.getElementById("uploaded_image_display_div").innerHTML = " ";
    $.ajax({
        type: "post",
        url: "dal/dal_gallery.php",
        data: {
            create_folder: "create_folder",
            project_id: project_id,
        },
        success: function (response) {
            // debugger;
            if (response != "") {
                let subsplitted_response = response.split("#");
                let length_of_file_name = subsplitted_response.length;
                let index_of_file_name = 0;
                let file = "";
                while (index_of_file_name < length_of_file_name - 1) {
                    splitted_response_to_get_file_name_and_path = subsplitted_response[index_of_file_name].split("+");
                    file += create_str_of_img(splitted_response_to_get_file_name_and_path[1], true, splitted_response_to_get_file_name_and_path[3]);
                    index_of_file_name++;
                }
                document.getElementById("uploaded_image_display_div").innerHTML = file;
                document.getElementById("image_upload_section").style.display = "block";
                document.getElementById("uploaded_image_heading_div").style.display = "block";
                if (document.getElementById("project_id") != null) {
                    document.getElementById("project_id").value = project_id;
                }
            }
            else if (response == "failed") {
                document.getElementById("new-alert-msg").innerHTML =
                    "Problem while creating project folder. Please try again later.";
                document.getElementById("new-alert").style.display = "block";
            }
            else {
                document.getElementById("image_upload_section").style.display = "block";
                document.getElementById("project_id").value = project_id;
            }
        },
    });
}

// function to upload files
function upload_files() {
    // debugger;
    var f1 = $("#image")[0].files;
    let uploaded_files_on_server = 0;
    if (f1.length != 0) {
        var file_index = 0;
        while (file_index < f1.length) {
            var fd = new FormData();
            fd.append("file", f1[file_index]);
            fd.append("project_id", document.getElementById("project_id").value);
            $.ajax({
                url: "dal/dal_gallery.php",
                type: "post",
                data: fd,
                contentType: false,
                processData: false,
                success: function (response) {
                    // debugger;
                    if (response > 0) {
                        uploaded_files_on_server++;
                    }
                    if (file_index == uploaded_files_on_server) {
                        clear_selection_of_images();
                        document.getElementById("new-alert-msg").innerHTML =
                            "All files are uploaded";
                        document.getElementById("new-alert").style.display = "block";
                        create_folder_of_project_image(document.getElementById("project_id").value);
                    }
                },
            });
            file_index++;
        }
    } else {
        alert("Please select file");
    }
}

// function to delete img
function delete_img(img_id) {
    // debugger;
    $.ajax({
        url: "dal_delete_image.php",
        type: "post",
        data: {
            delete_the_image: "delete_the_image",
            img_id: img_id,
        },
        success: function (response) {
            // debugger;
            if (response > 0) {
                $("#img_div" + img_id).remove();
                if (document.getElementById("uploaded_image_display_div").innerHTML == "") {
                    document.getElementById("uploaded_image_heading_div").style.display = "none";
                }
                document.getElementById("new-alert-msg").innerHTML =
                    "Image deleted successfully";
                document.getElementById("new-alert").style.display = "block";
            }
            else {
                document.getElementById("new-alert-msg").innerHTML =
                    "There was a problem while deleting a Image";
                document.getElementById("new-alert").style.display = "block";
            }
        },
    });
}