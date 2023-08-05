<!DOCTYPE html>
<html lang="en">

<head>
       <?php
       include 'header.php';
       ?>
       <script src="jquery/help.js"></script>
</head>

<body class="">
       <?php
       $user_name = $_SESSION['user_name'];
       include 'dal/dal_db.php';
       include 'menu.php';
       ?>
       <div class="w3-contanier w3-margin">
              <div class="w3-bar">
                     <div class="w3-bar-item w3-col l10 m10 s8">
                            <input class="w3-input" type="text" id="searched_question" placeholder="Enter your query here and just press tab key to search question..." onblur="search_question()" style="outline: none;">
                     </div>
              </div>
       </div>
       <div class="w3-contanier w3-margin help_div" id="div_holding_questions"></div>
       </div>
       <script>
              var load_flag = 0;
              load_more(load_flag);

              function load_more(start) {
                     $.ajax({
                            type: "post",
                            url: "dal/dal_help.php",
                            data: {
                                   get_more_content: "get_more_content",
                                   start: start,
                            },
                            success: function(response) {
                                   debugger;
                                   $(".help_div").append(response);
                                   load_flag += 6;
                            }
                     });
              }
              $(document).ready(function() {
                     $('#div_holding_questions').on('scroll', function() {
                            if ($(this).scrollTop() + $(this).innerHeight() >= $(this)[0].scrollHeight) {
                                   load_more(load_flag);
                            }
                     })
              });
       </script>
</body>

</html>