<div class="w3-col l3 m3 s12 w3-margin-top" id="project_list"></div>
<script>
    function get_project() {
        debugger;
        let index_for_splited_response = 0;
        let table = document.getElementById("tbl_id");
        $.ajax({
            type: "post",
            url: "dal/dal_project.php",
            data: {
                get_project: "get_project",
            },
            success: function(response) {
                debugger;
                if (response != "") {
                    let splited_response = response.split("*");
                    project_list = "";
                    while (index_for_splited_response < splited_response.length - 1) {
                        let sub_splited_response =
                            splited_response[index_for_splited_response].split("#");

                        if (document.URL.includes("reports.php")) {
                            project_list += '<a href="javascript:void(0)" onclick="open_project_reprot(' + sub_splited_response[0] + ')" class="w3-bar"><img src="img/microsoft-project-480.png" class="w3-bar-item w3-circle" style="width:85px">';
                        } else if (document.URL.includes("project.php")) {
                            project_list += '<a href="javascript:void(0)" onclick="show_info(' + sub_splited_response[0] + ')" class="w3-bar"><img src="img/microsoft-project-480.png" class="w3-bar-item w3-circle" style="width:85px">';
                        } else if (document.URL.includes("document_upload.php")) {
                            project_list += '<a href="javascript:void(0)" onclick="create_folder_of_project(' + sub_splited_response[0] + ')" class="w3-bar"><img src="img/microsoft-project-480.png" class="w3-bar-item w3-circle" style="width:85px">';
                        } else if (document.URL.includes("gallery.php")) {
                            project_list += '<a href="javascript:void(0)" onclick="create_folder_of_project_image(' + sub_splited_response[0] + ')" class="w3-bar"><img src="img/microsoft-project-480.png" class="w3-bar-item w3-circle" style="width:85px">';
                        } else if (document.URL.includes("chat.php")) {
                            project_list += '<a href="javascript:void(0)" class="w3-bar"><img src="img/microsoft-project-480.png" class="w3-bar-item w3-circle" style="width:85px">';
                        }
                        project_list += '<div class="w3-large"><h4 id="project_name' + sub_splited_response[0] + '" class="">' + sub_splited_response[1] + '</h4><br>';
                        project_list += '<span id="project_id' + sub_splited_response[0] + '" class="w3-hide">' + sub_splited_response[0] + '</span>';
                        project_list += '<span id="project_description' + sub_splited_response[0] + '" class="w3-hide">' + sub_splited_response[2] + '</span>';
                        project_list += '<span id="project_added_date' + sub_splited_response[0] + '" class="w3-hide">' + sub_splited_response[3] + '</span>';
                        project_list += '</div></a>';
                        index_for_splited_response++;
                    }
                    document.getElementById("project_list").innerHTML = project_list;
                }
            },
        });
    }
</script>