// function to open modal which display all the files
function click_on_input() {
    debugger;
    document.getElementById("file").click();
}

// function to make file str
function make_file_str(filename, filetype, link_to_download, document_id) {
    debugger;
    let list = "";
    let status_of_delete_document_right = document.getElementById("status_of_delete_document_right").innerHTML;
    if (link_to_download != "") {
        list += '<li id="uploaded_document_str' + document_id + '" class="w3-bar w3-col l6 m12 s12">';
    }
    else {
        list += '<li class="w3-bar w3-col l6 m12 s12">';
    }
    if (filetype == "pdf") {
        list += '<i class="fa fa-file-pdf-o w3-bar-item w3-circle w3-xlarge w3-margin-top" aria-hidden="true"></i>';
    }
    else if (filetype == "doc" || filetype == "docx" || filetype == "docm" || filetype == "dotx" || filetype == "dotm" || filetype == "dot" || filetype == "xps" || filetype == "odt") {
        list = '<li class="w3-bar w3-col l6 m6 s12"><i class="fa fa-file-word-o w3-bar-item w3-circle w3-xlarge w3-margin-top" aria-hidden="true"></i>';
    }
    else if (filetype == "csv" || filetype == "xlsx" || filetype == "xlsm" || filetype == "xlsb" || filetype == "xltx" || filetype == "xls") {
        list = '<li class="w3-bar w3-col l6 m6 s12"><i class="fa fa-file-excel-o w3-bar-item w3-circle w3-xlarge w3-margin-top" aria-hidden="true"></i>';
    }
    else if (filetype == "pptx" || filetype == "pptm" || filetype == "ppt" || filetype == "xps" || filetype == "potx" || filetype == "potm" || filetype == "pot" || filetype == "ppsx" || filetype == "pps" || filetype == "ppsm" || filetype == "ppa" || filetype == "xml" || filetype == "odp") {
        list = '<li class="w3-bar w3-col l6 m6 s12"><i class="fa fa-file-powerpoint-o w3-bar-item w3-circle w3-xlarge w3-margin-top" aria-hidden="true"></i>';
    }
    list += '<div class="w3-bar-item w3-margin-top"><span class="">';
    if (link_to_download != "") {
        list += '<a href="' + link_to_download + '" download>'
    }
    list += filename;
    if (link_to_download != "") {
        list += '</a>';
    }
    list += '</span></div>';
    if (link_to_download != "" && status_of_delete_document_right == "1") {
        list += '<span onclick="delete_uploaded_file(' + document_id + ')" class="w3-bar-item w3-margin-top w3-large w3-right" style="cursor:pointer;">&times;</span><span class="w3-hide" id="path_of_document' + document_id + '">' + link_to_download + '</span>';
    }
    list += '</li>';
    return list;
}

// function to showPreview of selected files
function showPreview(event) {
    debugger;
    document.getElementById("upload_btn_div").style.display = "none";
    document.getElementById("clear_selection_div").style.display = "block";
    document.getElementById("upload_selection_div").style.display = "block";
    document.getElementById("selected_file_heading_div").style.display = "block";
    let selected_file = $("#file")[0].files;
    let file_holding_div = document.getElementById("selected_file_display_div");
    let file_index = 0;
    let file;
    while (file_index < selected_file.length) {
        let src = URL.createObjectURL(selected_file[file_index]);
        let file_type = (selected_file[file_index].name).split(".");
        file = make_file_str(selected_file[file_index].name, file_type[1], "", file_index);
        file_holding_div.innerHTML += file;
        file_index++;
    }
}

// function to clear selection
function clear_selection() {
    debugger;
    document.getElementById("upload_selection_div").style.display = "none";
    document.getElementById("clear_selection_div").style.display = "none";
    document.getElementById("selected_file_heading_div").style.display = "none";
    document.getElementById("file").value = "";
    document.getElementById("selected_file_display_div").innerHTML = "";
    document.getElementById("upload_btn_div").style.display = "block";
}

// function to upload files
function upload_files() {
    debugger;
    var f1 = $("#file")[0].files;
    let uploaded_files_on_server = 0;
    if (f1.length != 0) {
        var file_index = 0;
        while (file_index < f1.length) {
            // console.log("path : " + f1[file_index].value);
            var fd = new FormData();
            fd.append("file", f1[file_index]);
            fd.append("project_id", document.getElementById("project_id").value);
            $.ajax({
                url: "dal/dal_document_upload.php",
                type: "post",
                data: fd,
                contentType: false,
                processData: false,
                success: function (response) {
                    debugger;
                    if (response > 0) {
                        uploaded_files_on_server++;
                    }
                    if (file_index == uploaded_files_on_server) {
                        clear_selection();
                        document.getElementById("new-alert-msg").innerHTML =
                            "All files are uploaded";
                        document.getElementById("new-alert").style.display = "block";
                        create_folder_of_project(document.getElementById("project_id").value);
                    }
                },
            });
            file_index++;
        }
    } else {
        alert("Please select file");
    }
}

// function to create folder of project
function create_folder_of_project(project_id) {
    debugger;
    $.ajax({
        type: "post",
        url: "dal/dal_document_upload.php",
        data: {
            create_folder: "create_folder",
            project_id: project_id,
        },
        success: function (response) {
            debugger;
            if (response != "") {
                let subsplitted_response = response.split("#");
                let length_of_file_name = subsplitted_response.length;
                let index_of_file_name = 0;
                let file = "";
                while (index_of_file_name < length_of_file_name - 1) {
                    splitted_response_to_get_file_name_and_path = subsplitted_response[index_of_file_name].split("+");
                    file += make_file_str(splitted_response_to_get_file_name_and_path[0], splitted_response_to_get_file_name_and_path[0].split(".")[1], splitted_response_to_get_file_name_and_path[1], splitted_response_to_get_file_name_and_path[3]);
                    index_of_file_name++;
                }
                document.getElementById("uploaded_file_display_div").innerHTML = file;
                document.getElementById("document_upload_section").style.display = "block";
                document.getElementById("uploaded_file_heading_div").style.display = "block";
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
                document.getElementById("document_upload_section").style.display = "block";
                document.getElementById("uploaded_file_heading_div").style.display = "none";
                if (document.getElementById("project_id") != null) {
                    document.getElementById("project_id").value = project_id;
                }
            }
        },
    });
}

// function to delete uploaded file
function delete_uploaded_file(document_id) {
    debugger;
    let path = document.getElementById("path_of_document" + document_id).innerHTML;
    let project_id = document.getElementById("project_id").value;
    $.ajax({
        url: "dal_delete_document.php",
        type: "post",
        data: {
            delete_the_file: "delete_the_file",
            document_id: document_id,
            project_id: project_id,
            path: path,
        },
        success: function (response) {
            debugger;
            if (response > 0) {
                document.getElementById("uploaded_document_str" + document_id).style.display = 'none';
                document.getElementById("new-alert-msg").innerHTML =
                    "File successfully deleted";
                document.getElementById("new-alert").style.display = "block";
            }
            else {
                document.getElementById("new-alert-msg").innerHTML =
                    "There was a problem while deleting a file";
                document.getElementById("new-alert").style.display = "block";
            }
        },
    });
}