<?php
include 'dal_db.php';
session_start();

if (isset($_POST['get_more_content'])) {
       $div = "";
       $start = mysqli_real_escape_string($con, $_POST['start']);
       $get_content = "SELECT faq_id,faq,faq_ans FROM tbl_faq WHERE faq_ans_status = 1 limit $start,6";
       $result = mysqli_query($con, $get_content);
       if (isset($result)) {
              while ($data_row = mysqli_fetch_array($result)) {
                     $div .= '<div class="w3-bar w3-border w3-round w3-padding w3-light-gray"><div id="question' . $data_row['faq_id'] . '" class="w3-bar-item">' . $data_row['faq'] . '</div><button onclick="myFunction(' . $data_row['faq_id'] . ')" class="w3-button w3-bar-item w3-right"><a id="icon_holding_icon' . $data_row['faq_id'] . '" class="w3-xlarge"><i class="fa fa-caret-down" aria-hidden="true"></i></a></button></div><div id="' . $data_row['faq_id'] . '" class="w3-container w3-hide"><p>' . $data_row['faq_ans'] . '</p></div>&nbsp;';
              }
              echo $div;
              exit();
       }
       echo "0";
       exit();
}

if(isset($_POST['get_searched_question']))
{
       $question = $_POST['question'];
       $div = '';
       $get_question_answer = "SELECT faq_id,faq,faq_ans FROM tbl_faq WHERE faq LIKE '$question' AND faq_ans_status = 1";
       $result = mysqli_query($con, $get_question_answer);
       if(isset($result))
       {
              while($data_row = mysqli_fetch_array($result))
              {
                     $div .= '<div class="w3-bar w3-border w3-round w3-light-gray w3-padding"><div id="question' . $data_row['faq_id'] . '" class="w3-bar-item">' . $data_row['faq'] . '</div><button onclick="myFunction(' . $data_row['faq_id'] . ')" class="w3-button w3-bar-item w3-right"><a id="icon_holding_icon' . $data_row['faq_id'] . '" class="w3-xlarge"><i class="fa fa-caret-down" aria-hidden="true"></i></a></button></div><div id="' . $data_row['faq_id'] . '" class="w3-container w3-hide"><p>' . $data_row['faq_ans'] . '</p></div>&nbsp;';
              }
       }
       echo $div;
       exit();
}