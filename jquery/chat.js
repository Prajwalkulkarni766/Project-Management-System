let chatroom_creation = '<div id="chatroom_creatation" class="w3-third w3-display-middle w3-padding w3-round-large"><div class="w3-container"><div class="container"><input id="chatroom_name" type="text" class="w3-input" placeholder="Enter a unique chat room name and press tab key" style="outline: none;" onblur="create_chat_room()"></div></div></div>';

let chat_str = '<div id="chat_str" class="w3-border bc"><div id="msg_div" class="w3-padding"></div><div class=" w3-bottom w3-margin-bottom w3-padding w3-row"><input class="chat-input-box" type="text" id="msg_holding_input" placeholder="Enter your message here and press tab key to send" style="border-radius: 27px;height: 7vh;outline-color: transparent;"><button class="w3-white chat-send-btn" style="border-radius: 90px" onclick="send_msg()"><i class="fa fa-paper-plane" aria-hidden="true"></i></button></div></div>';

function sended_msg(msg_txt) {
    return '<div class="w3-bar"><div class="w3-border w3-round w3-right w3-padding w3-light-gray" style="width:45vw;">' + msg_txt + '</div></div>';
}

function received_msg(msg_txt) {
    return '<div class="w3-bar"><div class="w3-border w3-round w3-padding w3-light-gray" style="width:45vw;">' + msg_txt + '</div></div>';
}

function create_chat_room() {
    debugger;
    document.getElementById("chatroom_name").disabled = true;
    let chatroom_name = document.getElementById("chatroom_name").value;
    $.ajax({
        type: "post",
        url: "dal/dal_chat.php",
        data: {
            create_chat_room: "create_chat_room",
            chatroom_name: chatroom_name,
        },
        success: function (response) {
            debugger;
            if (response == "-1") {
                document.getElementById("new-alert-msg").innerHTML =
                    "Please enter unique chat room name";
                document.getElementById("new-alert").style.display = "block";
                document.getElementById("chatroom_name").disabled = false;
            }
            else if (response == "1") {
                document.getElementById("new-alert-msg").innerHTML =
                    "Chat room created successfully";
                document.getElementById("new-alert").style.display = "block";
                document.getElementById("root").innerHTML = chat_str;
            }
            else if (response == "0") {
                document.getElementById("new-alert-msg").innerHTML =
                    "There is some problem. Please try again later";
                document.getElementById("new-alert").style.display = "block";
            }
        },
    });
}

function send_msg() {
    // debugger;
    let msg = document.getElementById("msg_holding_input").value;
    if (msg != "" && msg != " ") {
        document.getElementById("msg_holding_input").disabled = true;
        $.ajax({
            type: "post",
            url: "dal/dal_chat.php",
            data: {
                send_msg: "send_msg",
                msg: msg,
            },
            success: function (response) {
                // debugger;
                if (response > "0") {
                    previous_chat_count = response;
                    document.getElementById("msg_holding_input").disabled = false;
                    document.getElementById("msg_div").innerHTML += sended_msg(msg);
                    document.getElementById("msg_holding_input").value = "";

                }
            },
        });
    }
}

function to_check_chatroom_exists_or_not() {
    // debugger;
    // $("#loading_gif").remove()
    let chatroom_id = document.getElementById("chatroom_id").innerHTML;
    if (chatroom_id > 0) {
        document.getElementById("root").innerHTML = chat_str;
    }
    else {
        document.getElementById("root").innerHTML = chatroom_creation
    }
}