function myFunction(id) {
  debugger;
  let x = document.getElementById(id);
  if (x.className.indexOf("w3-show") == -1) {
    x.className += " w3-show";
    document.getElementById("icon_holding_icon" + id).innerHTML =
      '<i class="fa fa-caret-up" aria-hidden="true"></i>';
  } else {
    x.className = x.className.replace(" w3-show", "");
    document.getElementById("icon_holding_icon" + id).innerHTML =
      '<i class="fa fa-caret-down" aria-hidden="true"></i>';
  }
}

function search_question() {
  debugger;
  let splitted_question = document.getElementById("searched_question").value.split(" ");
  let index_of_splitted_question = 0;
  let question = '';
  while(index_of_splitted_question < splitted_question.length)
  {
    question += "%"+splitted_question[index_of_splitted_question];
    index_of_splitted_question++;
  }
  question += "%";
  $.ajax({
    type: "post",
    url: "dal/dal_help.php",
    data: {
      get_searched_question: "get_searched_question",
      question: question,
    },
    success: function (response) {
      debugger;
      if (response != "") {
        document.getElementById("div_holding_questions").innerHTML = "";
        $(".help_div").append(response);
      }
    },
  });
}