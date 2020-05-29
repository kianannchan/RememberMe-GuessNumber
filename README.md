# RememberMe-GuessNumber
*RememberMe-GuessNumber is a remake of the [GuessMe](https://github.com/kianannchan/GuessNumber) 
that is developed using HTML5, Bootstrap 4.5 and [Dart](https://dart.dev/) Programming Language.*
>Dart is a client-optimized programming language for apps on multiple platforms. 
>It is developed by Google and is used to build mobile, desktop, server, and web applications. 
>Dart is an object-oriented, class-based, garbage-collected language with C-style syntax. 
>Dart can compile to either native code or JavaScript.

*Life upgrade and review ongoing level trend is removed from this version of Remember-GuessNumber to enhanced
the game experience.*

#
### Features
- [x] Guess input
- [x] [Enter] or button click trigger
- [x] Current statistic tracking
- [x] Historical results tracking
- [x] After level 15, there will be spelling of words at random attempts 

#
### Game Logic
Max guess boundary:
```
_level * 10
```
Challenge word attempt condition:
```
(_attemptCounter % (_level * 2) == 0 && _level > 15)
```
Points credit:
```
_points += _level * _life * _multiplier;
```
Multiplier level up condition:
```
_level % 5 == 0 && _level > 0;
```
Multiplier credit:
```
_multiplier*= 2;
```

#
### Software Model
```
Main (View) -> Controller -> Model 
```

*model:*
```
- int _level
- int _life
- int _points
- int _multiplier
- int _attemptCounter
- int _word_attempt
- int _hiddenNum
- int _max
- List _attempts
+ final Map <int, String> _msg
+ Map <String, dynamic> toJson()
+ controller fromJson(Map)
```

*controller:*
```
+ controller()
+ String getQuestion()
+ int getLevel()
+ int getPoints()
+ int getLife()
+ int getMultiplier()
+ int getWordAttempt()
+ int getHiddenNumber()
+ String getRemarks(int)
+ List getAttempts()
+ void clearAttempts()
+ void randomNumber()
+ int guess(int)
+ String challenge()
+ void updatePoints()
+ void progress()
```

*main (View):*
```
+ void getExport()
+ void game_stage()
+ void displayCurrentStat({int})
+ void displayScoreboard()
+ void challengeUser()
```

#
### Screenshot
![Image of Yaktocat](https://i.ibb.co/2N874nZ/minimal.png)

*Minimal display of the game; Level, Question, prompt, remarks and a button. This allows 
minimum or no distraction while playing the game.*

![Image of Yaktocat](https://i.ibb.co/C1gWQZ4/currentstat.png)

*Statics Display - baseline of minimal display; Life, points and multiplier display on the screen.*


![Image of Yaktocat](https://i.ibb.co/Ch8d1ct/Capture.png)

*Historical Display - baseline of minimal; Show records of trends and gross 
points achieve across levels. Exportation of records is also made possible.*

#
### Development
- [ ] Graph trend of historical results
- [ ] Predictive Modelling
- [ ] Export analysis result