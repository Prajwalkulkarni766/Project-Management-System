// this function check device means device is mobile or pad or desktop or laptop and make tr according to it
function check_device_make_tr(data) {
    // debugger;
    if (/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {
        // table for mobile and tablet
        let table_str = '<table role="table">';
        table_str += '<thead role="rowgroup">';
        table_str += '<tr role="row">';
        table_str += '<th role="columnheader">Name</th>';
        table_str += '<th role="columnheader">View Dashboard</th>';
        table_str += '<th role="columnheader">Move Content</th>';
        table_str += '<th role="columnheader">View Project</th>';
        table_str += '<th role="columnheader">Add Project</th>';
        table_str += '<th role="columnheader">Edit Project</th>';
        table_str += '<th role="columnheader">View Report</th>';
        table_str += '<th role="columnheader">Change Privileges</th>';
        table_str += '<th role="columnheader">Create User</th>';
        table_str += '<th role="columnheader">Edit Other User</th>';
        table_str += '<th role="columnheader">Upload Images</th>';
        table_str += '<th role="columnheader">Delete Images</th>';
        table_str += '<th role="columnheader">Upload Documents</th>';
        table_str += '<th role="columnheader">Delete Documents</th>';
        table_str += '<th role="columnheader">Options</th>';
        table_str += '</tr>';
        table_str += '</thead>';
        table_str += '<tbody role="rowgroup"></tbody>';
        let index_of_response = 0;
        while (index_of_response < data.length) {
            let tbody = '<tr role="row">';
            tbody += '<td role="cell">' + data[index_of_response]['user_name'] + '</td>';
            tbody += '<td role="cell"><input id="privilege_for_view_dashboard' + data[index_of_response]['user_id'] + '" class="w3-check" type="checkbox" ';
            data[index_of_response]['privilege_for_view_dashboard'] == 1 ? tbody += 'checked="checked" ' : tbody += ' ';
            tbody += '></td><td role="cell"><input id="privilege_for_move_dashboard_content' + data[index_of_response]['user_id'] + '" class="w3-check" type="checkbox" ';
            data[index_of_response]['privilege_for_move_dashboard_content'] == 1 ? tbody += 'checked="checked" ' : tbody += ' ';
            tbody += '></td><td role="cell"><input id="privilege_for_view_project' + data[index_of_response]['user_id'] + '" class="w3-check" type="checkbox" ';
            data[index_of_response]['privilege_for_view_project'] == 1 ? tbody += 'checked="checked" ' : tbody += ' ';
            tbody += '></td><td role="cell"><input id="privilege_for_add_new_project' + data[index_of_response]['user_id'] + '" class="w3-check" type="checkbox" ';
            data[index_of_response]['privilege_for_add_new_project'] == 1 ? tbody += 'checked="checked" ' : tbody += ' ';
            tbody += '></td><td role="cell"><input id="privilege_for_edit_project' + data[index_of_response]['user_id'] + '" class="w3-check" type="checkbox" ';
            data[index_of_response]['privilege_for_edit_project'] == 1 ? tbody += 'checked="checked" ' : tbody += ' ';
            tbody += '></td><td role="cell"><input id="privilege_for_view_reports' + data[index_of_response]['user_id'] + '" class="w3-check" type="checkbox" ';
            data[index_of_response]['privilege_for_view_reports'] == 1 ? tbody += 'checked="checked" ' : tbody += ' ';
            tbody += '></td><td role="cell"><input id="privilege_to_change_privilege' + data[index_of_response]['user_id'] + '" class="w3-check" type="checkbox" ';
            data[index_of_response]['privilege_to_change_privilege'] == 1 ? tbody += 'checked="checked" ' : tbody += ' ';
            tbody += '></td><td role="cell"><input id="privilege_for_create_user' + data[index_of_response]['user_id'] + '" class="w3-check" type="checkbox" ';
            data[index_of_response]['privilege_for_create_user'] == 1 ? tbody += 'checked="checked" ' : tbody += ' ';
            tbody += '></td><td role="cell"><input id="privilege_for_view_and_edit_created_user' + data[index_of_response]['user_id'] + '" class="w3-check" type="checkbox" ';
            data[index_of_response]['privilege_for_view_and_edit_created_user'] == 1 ? tbody += 'checked="checked" ' : tbody += ' ';
            tbody += '></td><td role="cell"><input id="privilege_for_upload_images' + data[index_of_response]['user_id'] + '" class="w3-check" type="checkbox" ';
            data[index_of_response]['privilege_for_upload_images'] == 1 ? tbody += 'checked="checked" ' : tbody += ' ';
            tbody += '></td><td role="cell"><input id="privilege_for_delete_uploaded_images' + data[index_of_response]['user_id'] + '" class="w3-check" type="checkbox" ';
            data[index_of_response]['privilege_for_delete_uploaded_images'] == 1 ? tbody += 'checked="checked" ' : tbody += ' ';
            tbody += '></td><td role="cell"><input id="privilege_for_upload_documents' + data[index_of_response]['user_id'] + '" class="w3-check" type="checkbox" ';
            data[index_of_response]['privilege_for_upload_documents'] == 1 ? tbody += 'checked="checked" ' : tbody += ' ';
            tbody += '></td><td role="cell"><input id="privilege_for_delete_uploaded_documents' + data[index_of_response]['user_id'] + '" class="w3-check" type="checkbox" ';
            data[index_of_response]['privilege_for_delete_uploaded_documents'] == 1 ? tbody += 'checked="checked" ' : tbody += '';
            tbody += '></td><td role="cell"><button onclick="save_changed_privilege_record(' + data[index_of_response]['user_id'] + ')" title="Save" class="w3-btn"><i class="fa fa-floppy-o" aria-hidden="true"></i></button></td>';
            tbody += '</tr>';
            table_str += tbody;
            index_of_response++;
        }
        document.getElementById("privilege_tbl_holding_div").innerHTML = table_str + '</tbody></table>';
    }
    else {
        // table for desktop and laptop
        let table_str = '<table id="tbl" class="w3-table-all w3-hoverable w3-small"><thead><tr class="w3-light-grey">';
        table_str += '<th class="w3-center">Name</th>';
        table_str += '<th class="w3-center" title="View Dashboard">VD</th>';
        table_str += '<th class="w3-center" title="Move Content">MC</th>';
        table_str += '<th class="w3-center" title="View Project">VP</th>';
        table_str += '<th class="w3-center" title="Add Project">AP</th>';
        table_str += '<th class="w3-center" title="Edit Project">EP</th>';
        table_str += '<th class="w3-center" title="View Report">VR</th>';
        table_str += '<th class="w3-center" title="Change Privilege">CP</th>';
        table_str += '<th class="w3-center" title="Create User">CU</th>';
        table_str += '<th class="w3-center" title="Edit Other User">EU</th>';
        table_str += '<th class="w3-center" title="Upload Images">UI</th>';
        table_str += '<th class="w3-center" title="Delete Images">DI</th>';
        table_str += '<th class="w3-center" title="Upload Documents">UD</th>';
        table_str += '<th class="w3-center" title="Delete Documents">DD</th>';
        table_str += '<th class="w3-center">Options</th>';
        table_str += '</tr></thead><tbody>';
        let index_of_response = 0;
        while (index_of_response < data.length) {
            let tbody = '<tr>';
            tbody += '<td class="w3-center">' + data[index_of_response]['user_name'] + '</td>';
            tbody += '<td class="w3-center"><input id="privilege_for_view_dashboard' + data[index_of_response]['user_id'] + '" class="w3-check" type="checkbox" ';
            data[index_of_response]['privilege_for_view_dashboard'] == 1 ? tbody += 'checked="checked" ' : tbody += ' ';
            tbody += '></td><td class="w3-center"><input id="privilege_for_move_dashboard_content' + data[index_of_response]['user_id'] + '" class="w3-check" type="checkbox" ';
            data[index_of_response]['privilege_for_move_dashboard_content'] == 1 ? tbody += 'checked="checked" ' : tbody += ' ';
            tbody += '></td><td class="w3-center"><input id="privilege_for_view_project' + data[index_of_response]['user_id'] + '" class="w3-check" type="checkbox" ';
            data[index_of_response]['privilege_for_view_project'] == 1 ? tbody += 'checked="checked" ' : tbody += ' ';
            tbody += '></td><td class="w3-center"><input id="privilege_for_add_new_project' + data[index_of_response]['user_id'] + '" class="w3-check" type="checkbox" ';
            data[index_of_response]['privilege_for_add_new_project'] == 1 ? tbody += 'checked="checked" ' : tbody += ' ';
            tbody += '></td><td class="w3-center"><input id="privilege_for_edit_project' + data[index_of_response]['user_id'] + '" class="w3-check" type="checkbox" ';
            data[index_of_response]['privilege_for_edit_project'] == 1 ? tbody += 'checked="checked" ' : tbody += ' ';
            tbody += '></td><td class="w3-center"><input id="privilege_for_view_reports' + data[index_of_response]['user_id'] + '" class="w3-check" type="checkbox" ';
            data[index_of_response]['privilege_for_view_reports'] == 1 ? tbody += 'checked="checked" ' : tbody += ' ';
            tbody += '></td><td class="w3-center"><input id="privilege_to_change_privilege' + data[index_of_response]['user_id'] + '" class="w3-check" type="checkbox" ';
            data[index_of_response]['privilege_to_change_privilege'] == 1 ? tbody += 'checked="checked" ' : tbody += ' ';
            tbody += '></td><td class="w3-center"><input id="privilege_for_create_user' + data[index_of_response]['user_id'] + '" class="w3-check" type="checkbox" ';
            data[index_of_response]['privilege_for_create_user'] == 1 ? tbody += 'checked="checked" ' : tbody += ' ';
            tbody += '></td><td class="w3-center"><input id="privilege_for_view_and_edit_created_user' + data[index_of_response]['user_id'] + '" class="w3-check" type="checkbox" ';
            data[index_of_response]['privilege_for_view_and_edit_created_user'] == 1 ? tbody += 'checked="checked" ' : tbody += ' ';
            tbody += '></td><td class="w3-center"><input id="privilege_for_upload_images' + data[index_of_response]['user_id'] + '" class="w3-check" type="checkbox" ';
            data[index_of_response]['privilege_for_upload_images'] == 1 ? tbody += 'checked="checked" ' : tbody += ' ';
            tbody += '></td><td class="w3-center"><input id="privilege_for_delete_uploaded_images' + data[index_of_response]['user_id'] + '" class="w3-check" type="checkbox" ';
            data[index_of_response]['privilege_for_delete_uploaded_images'] == 1 ? tbody += 'checked="checked" ' : tbody += ' ';
            tbody += '></td><td class="w3-center"><input id="privilege_for_upload_documents' + data[index_of_response]['user_id'] + '" class="w3-check" type="checkbox" ';
            data[index_of_response]['privilege_for_upload_documents'] == 1 ? tbody += 'checked="checked" ' : tbody += ' ';
            tbody += '></td><td class="w3-center"><input id="privilege_for_delete_uploaded_documents' + data[index_of_response]['user_id'] + '" class="w3-check" type="checkbox" ';
            data[index_of_response]['privilege_for_delete_uploaded_documents'] == 1 ? tbody += 'checked="checked" ' : tbody += '';
            tbody += '></td><td class="w3-center"><button onclick="save_changed_privilege_record(' + data[index_of_response]['user_id'] + ')" title="Save" class="w3-btn"><i class="fa fa-floppy-o" aria-hidden="true"></i></button></td>';
            tbody += '</tr>';
            table_str += tbody;
            index_of_response++;
        }
        document.getElementById("privilege_tbl_holding_div").innerHTML = table_str + '</tbody></table>';
    }
}

// this function used to get privilege data from backend
function get_privilege_data() {
    // debugger;
    $.ajax({
        type: "post",
        url: "dal/dal_privileges.php",
        data: {
            get_privilege_data: "get_privilege_data",
        },
        success: function (response) {
            // debugger;
            parsed_response = JSON.parse(response);
            if (!parsed_response.message) {
                document.getElementById("privilege_tbl_holding_div").innerHTML = " ";
                check_device_make_tr(parsed_response);
            }
            else {
                document.getElementById("new-alert-msg").innerHTML =
                    "Data not found";
                document.getElementById("new-alert").style.display = "block";
            }
        },
    });
}

// function to save after edit
function save_changed_privilege_record(id) {
    // debugger;
    let privilege_for_view_dashboard = document.getElementById("privilege_for_view_dashboard" + id).checked;
    privilege_for_view_dashboard == true ? privilege_for_view_dashboard = 1 : privilege_for_view_dashboard = 0;
    let privilege_for_move_dashboard_content = document.getElementById("privilege_for_move_dashboard_content" + id).checked;
    privilege_for_move_dashboard_content == true ? privilege_for_move_dashboard_content = 1 : privilege_for_move_dashboard_content = 0;
    let privilege_for_view_project = document.getElementById("privilege_for_view_project" + id).checked;
    privilege_for_view_project == true ? privilege_for_view_project = 1 : privilege_for_view_project = 0;
    let privilege_for_add_new_project = document.getElementById("privilege_for_add_new_project" + id).checked;
    privilege_for_add_new_project == true ? privilege_for_add_new_project = 1 : privilege_for_add_new_project = 0;
    let privilege_for_edit_project = document.getElementById("privilege_for_edit_project" + id).checked;
    privilege_for_edit_project == true ? privilege_for_edit_project = 1 : privilege_for_edit_project = 0;
    let privilege_for_view_reports = document.getElementById("privilege_for_view_reports" + id).checked;
    privilege_for_view_reports == true ? privilege_for_view_reports = 1 : privilege_for_view_reports = 0;
    let privilege_to_change_privilege = document.getElementById("privilege_to_change_privilege" + id).checked;
    privilege_to_change_privilege == true ? privilege_to_change_privilege = 1 : privilege_to_change_privilege = 0;
    let privilege_for_create_user = document.getElementById("privilege_for_create_user" + id).checked;
    privilege_for_create_user == true ? privilege_for_create_user = 1 : privilege_for_create_user = 0;
    let privilege_for_view_and_edit_created_user = document.getElementById("privilege_for_view_and_edit_created_user" + id).checked;
    privilege_for_view_and_edit_created_user == true ? privilege_for_view_and_edit_created_user = 1 : privilege_for_view_and_edit_created_user = 0;
    let privilege_for_upload_images = document.getElementById("privilege_for_upload_images" + id).checked;
    privilege_for_upload_images == true ? privilege_for_upload_images = 1 : privilege_for_upload_images = 0;
    let privilege_for_delete_uploaded_images = document.getElementById("privilege_for_delete_uploaded_images" + id).checked;
    privilege_for_delete_uploaded_images == true ? privilege_for_delete_uploaded_images = 1 : privilege_for_delete_uploaded_images = 0;
    let privilege_for_upload_documents = document.getElementById("privilege_for_upload_documents" + id).checked;
    privilege_for_upload_documents == true ? privilege_for_upload_documents = 1 : privilege_for_upload_documents = 0;
    let privilege_for_delete_uploaded_documents = document.getElementById("privilege_for_delete_uploaded_documents" + id).checked;
    privilege_for_delete_uploaded_documents == true ? privilege_for_delete_uploaded_documents = 1 : privilege_for_delete_uploaded_documents = 0;
    $.ajax({
        type: "post",
        url: "dal/dal_privileges.php",
        data: {
            save_changed_privilege: "save_changed_privilege",
            id: id,
            privilege_for_view_dashboard: privilege_for_view_dashboard,
            privilege_for_move_dashboard_content: privilege_for_move_dashboard_content,
            privilege_for_view_project: privilege_for_view_project,
            privilege_for_add_new_project: privilege_for_add_new_project,
            privilege_for_edit_project: privilege_for_edit_project,
            privilege_for_view_reports: privilege_for_view_reports,
            privilege_to_change_privilege: privilege_to_change_privilege,
            privilege_for_create_user: privilege_for_create_user,
            privilege_for_view_and_edit_created_user: privilege_for_view_and_edit_created_user,
            privilege_for_upload_images: privilege_for_upload_images,
            privilege_for_delete_uploaded_images: privilege_for_delete_uploaded_images,
            privilege_for_upload_documents: privilege_for_upload_documents,
            privilege_for_delete_uploaded_documents: privilege_for_delete_uploaded_documents,
        },
        success: function (response) {
            // debugger;
            if (response > 0) {
                document.getElementById("new-alert-msg").innerHTML =
                    "Changes Saved";
                document.getElementById("new-alert").style.display = "block";
            }
            else {
                document.getElementById("new-alert-msg").innerHTML =
                    "Problem While Saving Changes";
                document.getElementById("new-alert").style.display = "block";
            }
        },
    });
}