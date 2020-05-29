import 'dart:core';
import 'dart:html';
import 'dart:js';
import 'package:string_validator/string_validator.dart';
import 'controller.dart';


// ini global controller class
var control = controller();
List <Map> state = [];

void main() {
  control.randomNumber(); // Get the first upon page load
  displayCurrentStat();

  // Listen for keyboard
  window.onKeyUp.listen((KeyboardEvent e)  {
    if (e.keyCode == KeyCode.ENTER) {game_stage(); }
  });

  // Listen for click button
  querySelector('#guess').onClick.listen((event) {
    game_stage();
  });

  // Listen for click button
  querySelector('#export').onClick.listen((event) {
    getExport();
  });

}

void getExport() {

    if (state.isEmpty) {
      context.callMethod(
        'alert', ['No Historical Data Found!']);
      return;
    }

    var html_content = '';
    var window_opener =
    context.callMethod('open',['','export','width=810,height=1000,top=10,left=100']);
    var Dobj = window_opener['document'];
    html_content = '<table border-collapse="collapse" id="records" width="100%" border="1px solid black" cellpadding="5px" class="table"> <thead class="thead-dark"> '
        '<tr> '
        '<th scope="col">Level</th> '
        '<th scope="col">Attempts</th> '
        '<th scope="col">Target Number</th> '
        '<th scope="col">Points</th> '
        '<th scope="col">Word Attempts Count</th>'
        '</tr>'
        '</thead>'
        '<tbody>';

    for (var json in state){
      var obj = controller();
      obj = obj.fromJson(json);
      var currentLevel = obj.getLevel();
      var list = obj.getAttempts().join(', ');
      var target = obj.getHiddenNumber();
      var points = obj.getPoints();
      var wordCount = obj.getWordAttempt();
      html_content+= '<tr border="1px solid black" cellpadding="5px"><td>${currentLevel}</td>'
          '<td>${list}</td><td>${target}</td>'
          '<td>${points}</td><td>${wordCount}</td>'
          '</tr>';
    }
    html_content+= '</tbody></table>';
    Dobj['body']['innerHTML'] += html_content;
    window_opener.callMethod('print',[]);
    window_opener.callMethod('close',[]);
}

void game_stage(){
  try {
    var user_input = (querySelector('#input') as InputElement).value;
    if (user_input.isNotEmpty && isNumeric(user_input)) {
      var result = control.guess(int.parse(user_input));
      switch (result) {
        case 3:
          { // win step
            control.updatePoints();
            displayScoreboard();
            control.progress();
            control.randomNumber();
            control.clearAttempts();
          }
          break;
        case 0:
          { // lose step
            context.callMethod(
                'alert', ['The Target Number is ${control.getHiddenNumber()}']);
            displayScoreboard();
            control = controller(); // reset class variable
            control.randomNumber();
          }
          break;
      }
      // regardless of the result
      challengeUser();
      displayCurrentStat(result: result);
    }
  }catch(ex){
    print (ex);
  }
}

void displayCurrentStat({int result}){
  (querySelector('#input') as InputElement).value = ''; // clear the previous input
  (querySelector('#remarks') as InputElement).value = control.getRemarks(result);
  querySelector('#question').text = control.getQuestion(); // Display
  querySelector('#input').focus(); // Focus on the input
  (querySelector('#life') as InputElement).value = control.getLife().toString();
  (querySelector('#points') as InputElement).value = control.getPoints().toString();
  (querySelector('#multiplier') as InputElement).value = control.getMultiplier().toString();
}

void displayScoreboard(){
  var table = document.getElementById('record');
  var currentLevel = control.getLevel();
  var list = control.getAttempts().join(', ');
  var target = control.getHiddenNumber();
  var points = control.getPoints();
  var wordCount = control.getWordAttempt();
  state.add(control.toJson());
  table.innerHtml += '<tr><td>${currentLevel}</td><td>${list}</td><td>${target}</td><td>${points}</td><td>${wordCount}</td></tr>';
}

void challengeUser(){
  var challengeWord = control.challenge();
  if (challengeWord != null){
    var user_respond = context.callMethod('prompt', ['Spell "${challengeWord}":']).toString().trim();
    while (true) {
      if (user_respond == challengeWord) {
        break;
      }
      user_respond = context.callMethod('prompt', ['Spell "${challengeWord}":']).toString().trim();
    }
  }
}