

import  '../web/controller.dart' as con;
import 'package:test/test.dart';

void main(){
  var testObj =  con.controller();
  testObj.randomNumber();
  var ran = testObj.getHiddenNumber();

  group('Unit Test for Remember Me', ()
  {
    test('Expect Larger Number', () {
      expect(1, testObj.guess(ran + 1));
    });

    test('Expect Smaller Number', () {
      expect(2, testObj.guess(ran - 1));
    });

    test('Correct Answer', () {
      expect(3, testObj.guess(ran));
    });

  });
}