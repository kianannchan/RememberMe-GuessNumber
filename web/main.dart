import 'dart:core';
import 'dart:html';
import 'dart:js';
import 'package:string_validator/string_validator.dart';
import 'controller.dart';

// ini global controller class
var control = controller();
List <controller> saveState = [];

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
}

void game_stage(){
  try {
    var user_input = (querySelector('#input') as InputElement).value;
    if (user_input.isNotEmpty && isNumeric(user_input)) {
      var result = control.guess(int.parse(user_input));
      switch (result) {
        case 3:
          { // win step
            saveState.add(control);
            control.progress();
            displayScoreboard();
            control.randomNumber();
            control.clearAttempts();
          }
          break;
        case 0:
          { // lose step
            context.callMethod(
                'alert', ['The Target Number is ${control.getHiddenNumber()}']);
            saveState.add(control);
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
  var currentLevel = control.getLevel() - 1;
  var list = control.getAttempts().join(', ');
  var target = control.getHiddenNumber();
  var points = control.getPoints();
  var wordCount = control.getWordAttempt();
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