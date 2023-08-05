<!DOCTYPE html>
<html lang="en">

<head>
    <?php
    include 'header.php';
    ?>
    <script src="jquery/chat.js"></script>
    <style>
        .bc {
            background-color: rgb(225, 225, 225);
        }
    </style>
</head>

<body>
    <?php
    include 'dal/dal_db.php';
    include 'menu.php';
    if (isset($_SESSION['privilege_for_chat']) && $_SESSION['privilege_for_chat'] > 0) {
    ?>
        <span id="chatroom_id" class="w3-hide"><?php echo $_SESSION['chatroom_id']; ?></span>
        <div id="root"></div>
        <!-- <button onclick="get_msg()">get</button> -->
        <script>
            var previous_chat_count = 0;
            to_check_chatroom_exists_or_not();
            $(document).ready(function() {
                setInterval(
                    function() {
                        get_msg();
                    }, 1000);
            });

            function get_msg() {
                // debugger;
                $.ajax({
                    type: "post",
                    url: "dal/dal_chat.php",
                    data: {
                        get_msg: "get_msg",
                        previous_chat_count: previous_chat_count,
                    },
                    success: function(response) {
                        // debugger;
                        if (response != "") {
                            let json_response = JSON.parse(response);
                            let index_of_json_response = 0;
                            while (index_of_json_response < json_response.length) {
                                document.getElementById("msg_div").innerHTML += received_msg(json_response[index_of_json_response]['chat_msg']);
                                previous_chat_count = json_response[index_of_json_response]['chat_id']
                                var elem = document.getElementById('msg_div');
                                elem.scrollTop = elem.scrollHeight;
                                index_of_json_response++;
                            }
                            console.log(previous_chat_count);
                        }
                    },
                });
            }
        </script>
    <?php
    } else {
    ?>
        <div class="w3-center w3-margin-top">You don't have privilege to chat</div>
    <?php
    }
    ?>
</body>

</html>