import 'dart:math';
import 'package:random_words/random_words.dart';

class model{
  int _level = 1;
  int _life = 10;
  int _points = 0;
  int _multiplier = 1;
  int _attemptCounter = 0;
  int _word_attempt = 0;
  int _hiddenNum;
  int _max;
  List _attempts = [] ;

  final Map <int, String> _msg = {
    0:'Game Over!',
    1:'You guess wrongly! Should be lower!',
    2: 'You guess wrongly! Should be higher!',
    3: 'You guess Correctly!'
  };

  // setter class to json data
  Map <String, dynamic> toJson() =>
      {
        'level': _level,
        'life' : _life,
        'points': _points,
        'multiplier': _multiplier,
        'attempt_counter':_attemptCounter,
        'word_attempt': _word_attempt,
        'hidden_num': _hiddenNum,
        'max': _max,
        'attempts': _attempts.join(',')
      };

  // getter json to class data
  controller fromJson(Map json){
    _level = json['level'];
    _life = json['life'];
    _points = json['points'];
    _multiplier = json['multiplier'];
    _attemptCounter = json['attempt_counter'];
    _word_attempt = json['word_attempt'];
    _hiddenNum = json['hidden_num'];
    _max = json['max'];
    _attempts = json['attempts'].toString().split(',');
    return this;
  }
}

class controller extends model{

  controller();

  String getQuestion(){ return 'Level ${_level}: Guess a number between 0 and ${_max}'; }

  int getLevel(){ return _level; }

  int getPoints(){ return _points; }

  int getLife(){ return _life; }

  int getMultiplier(){ return _multiplier; }

  int getWordAttempt(){ return _word_attempt; }

  int getHiddenNumber(){ return _hiddenNum; }

  String getRemarks(int code){ return _msg[code]; }

  List getAttempts(){ return _attempts; }

  void clearAttempts(){ _attempts.clear(); }

  void randomNumber(){
    _max = _level * 10;
    var random = Random();
    _hiddenNum = random.nextInt(_max);
  }

  // 1 => Higher number req
  // 2 => Lower number req
  // 3 => correct Guess
  int guess(int guess){
    _attemptCounter++;
    _attempts.add(guess);
    if (guess != _hiddenNum){
      _life--;
      if (_life == 0){
        return 0;
      }else if (guess > _hiddenNum){
        return 1;
      }else{
        return 2;
      }
    }
    return 3;
  }

  String challenge(){
    var challengeWord;
    if (_attemptCounter % (_level * 2) == 0 && _level > 15) {
      var word = generateNoun().take(1).join(' ').trim();
      challengeWord = word;
      _word_attempt++;
    }
    return challengeWord;
  }

  void updatePoints(){
    _points += _level * _life * _multiplier;
    if (_level % 5 == 0 && _level > 0){
      _multiplier*= 2;
    }
  }

  void progress(){
    _level++;
    _life = 10;
  }

}