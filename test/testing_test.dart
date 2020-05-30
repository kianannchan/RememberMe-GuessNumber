import  '../web/controller.dart' as con;
import 'package:test/test.dart';

void main() {

  var testObj = con.controller();
  testObj.randomNumber();
  var ran = testObj.getHiddenNumber();

  group('Guess Number', () {
    test('Expect Larger Number', () {
      expect(testObj.guess(ran + 1),1);
    });

    test('Expect Smaller Number', () {
      expect(testObj.guess(ran - 1),2);
    });

    test('Correct Answer', () {
      expect( testObj.guess(ran),3);
    });
  });

  // Condition (_attemptCounter % (_level * 2) == 0 && _level > 15)
  group('Word Challenge Generation', () {

    test('modulus not 0 and level more than 15', () {
      testObj.setAttemptCounter(50);
      testObj.setLevel(20);
      testObj.challenge();
      expect(testObj.challenge(),isNull);
    });

    test('modulus 0 and level less than 15', () {
      testObj.setAttemptCounter(20);
      testObj.setLevel(10);
      testObj.challenge();
      expect(testObj.challenge(),isNull);
    });

    test('modulus not 0 and level less than 15', () {
      testObj.setAttemptCounter(51);
      testObj.setLevel(10);
      expect(testObj.challenge(), isNull);
    });

    test('modulus 0 and level more than 15', () {
      testObj.setAttemptCounter(80);
      testObj.setLevel(20);
      expect(testObj.challenge(), isNotNull);
    });
  });

  //_level % 5 == 0 && _level > 0;
  group('Multiplier conditions', () {

    test('modulus not 0 and level more than 0', () {
      testObj.setLevel(3);
      expect(testObj.updatePoints(),false);
    });

    test('modulus 0 and level at 0', () {
      testObj.setLevel(0);
      expect(testObj.updatePoints(),false);
    });

    test('modulus 0 and level more than 0', () {
      testObj.setLevel(5);
      expect(testObj.updatePoints(),true);
    });
  });
}
