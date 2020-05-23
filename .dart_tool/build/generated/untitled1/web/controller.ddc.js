define(['dart_sdk', 'packages/string_validator/src/helpers', 'packages/random_words/random_words'], function(dart_sdk, packages__string_validator__src__helpers, packages__random_words__random_words) {
  'use strict';
  const core = dart_sdk.core;
  const html = dart_sdk.html;
  const js = dart_sdk.js;
  const _interceptors = dart_sdk._interceptors;
  const _js_helper = dart_sdk._js_helper;
  const math = dart_sdk.math;
  const dart = dart_sdk.dart;
  const dartx = dart_sdk.dartx;
  const validator = packages__string_validator__src__helpers.src__validator;
  const word_noun = packages__random_words__random_words.src__word_noun;
  var main = Object.create(dart.library);
  var controller = Object.create(dart.library);
  var $onKeyUp = dartx.onKeyUp;
  var $onClick = dartx.onClick;
  var $isNotEmpty = dartx.isNotEmpty;
  var $add = dartx.add;
  var $text = dartx.text;
  var $toString = dartx.toString;
  var $join = dartx.join;
  var $innerHtml = dartx.innerHtml;
  var $trim = dartx.trim;
  var $_get = dartx._get;
  var $clear = dartx.clear;
  var $modulo = dartx['%'];
  var $take = dartx.take;
  var KeyboardEventLToNullN = () => (KeyboardEventLToNullN = dart.constFn(dart.fnType(core.Null, [html.KeyboardEvent])))();
  var MouseEventLToNullN = () => (MouseEventLToNullN = dart.constFn(dart.fnType(core.Null, [html.MouseEvent])))();
  var JSArrayOfcontrollerL = () => (JSArrayOfcontrollerL = dart.constFn(_interceptors.JSArray$(controller.controller)))();
  var IdentityMapOfintL$StringL = () => (IdentityMapOfintL$StringL = dart.constFn(_js_helper.IdentityMap$(core.int, core.String)))();
  const CT = Object.create(null);
  var L0 = "org-dartlang-app:///web/controller.dart";
  main.main = function main$() {
    main.control.randomNumber();
    main.displayCurrentStat();
    html.window[$onKeyUp].listen(dart.fn(e => {
      if (e.keyCode === 13) {
        main.game_stage();
      }
    }, KeyboardEventLToNullN()));
    html.querySelector("#guess")[$onClick].listen(dart.fn(event => {
      main.game_stage();
    }, MouseEventLToNullN()));
  };
  main.game_stage = function game_stage() {
    try {
      let user_input = html.InputElement.as(html.querySelector("#input")).value;
      if (user_input[$isNotEmpty] && dart.test(validator.isNumeric(user_input))) {
        let result = main.control.guess(core.int.parse(user_input));
        switch (result) {
          case 3:
          {
            {
              main.saveState[$add](main.control);
              main.control.progress();
              main.displayScoreboard();
              main.control.randomNumber();
              main.control.clearAttempts();
            }
            break;
          }
          case 0:
          {
            {
              js.context.callMethod("alert", ["The Target Number is " + dart.str(main.control.getHiddenNumber())]);
              main.saveState[$add](main.control);
              main.displayScoreboard();
              main.control = new controller.controller.new();
              main.control.randomNumber();
            }
            break;
          }
        }
        main.challengeUser();
        main.displayCurrentStat({result: result});
      }
    } catch (e) {
      let ex = dart.getThrown(e);
      core.print(ex);
    }
  };
  main.displayCurrentStat = function displayCurrentStat(opts) {
    let result = opts && 'result' in opts ? opts.result : null;
    html.InputElement.as(html.querySelector("#input")).value = "";
    html.InputElement.as(html.querySelector("#remarks")).value = main.control.getRemarks(result);
    html.querySelector("#question")[$text] = main.control.getQuestion();
    html.querySelector("#input").focus();
    html.InputElement.as(html.querySelector("#life")).value = dart.toString(main.control.getLife());
    html.InputElement.as(html.querySelector("#points")).value = dart.toString(main.control.getPoints());
    html.InputElement.as(html.querySelector("#multiplier")).value = dart.toString(main.control.getMultiplier());
  };
  main.displayScoreboard = function displayScoreboard() {
    let t1;
    let table = html.document.getElementById("record");
    let currentLevel = dart.notNull(main.control.getLevel()) - 1;
    let list = main.control.getAttempts()[$join](", ");
    let target = main.control.getHiddenNumber();
    let points = main.control.getPoints();
    let wordCount = main.control.getWordAttempt();
    t1 = table;
    t1[$innerHtml] = dart.notNull(t1[$innerHtml]) + ("<tr><td>" + dart.str(currentLevel) + "</td><td>" + dart.str(list) + "</td><td>" + dart.str(target) + "</td><td>" + dart.str(points) + "</td><td>" + dart.str(wordCount) + "</td></tr>");
  };
  main.challengeUser = function challengeUser() {
    let challengeWord = main.control.challenge();
    if (challengeWord != null) {
      let user_respond = dart.toString(js.context.callMethod("prompt", ["Spell \"" + dart.str(challengeWord) + "\":"]))[$trim]();
      while (true) {
        if (user_respond === challengeWord) {
          break;
        }
        user_respond = dart.toString(js.context.callMethod("prompt", ["Spell \"" + dart.str(challengeWord) + "\":"]))[$trim]();
      }
    }
  };
  dart.defineLazy(main, {
    /*main.control*/get control() {
      return new controller.controller.new();
    },
    set control(_) {},
    /*main.saveState*/get saveState() {
      return JSArrayOfcontrollerL().of([]);
    },
    set saveState(_) {}
  }, true);
  var _level = dart.privateName(controller, "_level");
  var _life = dart.privateName(controller, "_life");
  var _points = dart.privateName(controller, "_points");
  var _multiplier = dart.privateName(controller, "_multiplier");
  var _attemptCounter = dart.privateName(controller, "_attemptCounter");
  var _word_attempt = dart.privateName(controller, "_word_attempt");
  var _hiddenNum = dart.privateName(controller, "_hiddenNum");
  var _max = dart.privateName(controller, "_max");
  var _attempts = dart.privateName(controller, "_attempts");
  var _msg = dart.privateName(controller, "_msg");
  controller.model = class model extends core.Object {};
  (controller.model.new = function() {
    this[_level] = 1;
    this[_life] = 10;
    this[_points] = 0;
    this[_multiplier] = 1;
    this[_attemptCounter] = 0;
    this[_word_attempt] = 0;
    this[_hiddenNum] = null;
    this[_max] = null;
    this[_attempts] = [];
    this[_msg] = new (IdentityMapOfintL$StringL()).from([0, "Game Over!", 1, "You guess wrongly! Should be lower!", 2, "You guess wrongly! Should be higher!", 3, "You guess Correctly!"]);
    ;
  }).prototype = controller.model.prototype;
  dart.addTypeTests(controller.model);
  dart.addTypeCaches(controller.model);
  dart.setLibraryUri(controller.model, L0);
  dart.setFieldSignature(controller.model, () => ({
    __proto__: dart.getFields(controller.model.__proto__),
    [_level]: dart.fieldType(core.int),
    [_life]: dart.fieldType(core.int),
    [_points]: dart.fieldType(core.int),
    [_multiplier]: dart.fieldType(core.int),
    [_attemptCounter]: dart.fieldType(core.int),
    [_word_attempt]: dart.fieldType(core.int),
    [_hiddenNum]: dart.fieldType(core.int),
    [_max]: dart.fieldType(core.int),
    [_attempts]: dart.fieldType(core.List),
    [_msg]: dart.finalFieldType(core.Map$(core.int, core.String))
  }));
  controller.controller = class controller$ extends controller.model {
    getQuestion() {
      return "Level " + dart.str(this[_level]) + ": Guess a number between 0 and " + dart.str(this[_max]);
    }
    getLevel() {
      return this[_level];
    }
    getPoints() {
      return this[_points];
    }
    getLife() {
      return this[_life];
    }
    getMultiplier() {
      return this[_multiplier];
    }
    getWordAttempt() {
      return this[_word_attempt];
    }
    getHiddenNumber() {
      return this[_hiddenNum];
    }
    getRemarks(code) {
      return this[_msg][$_get](code);
    }
    getAttempts() {
      return this[_attempts];
    }
    clearAttempts() {
      this[_attempts][$clear]();
    }
    randomNumber() {
      this[_max] = dart.notNull(this[_level]) * 10;
      let random = math.Random.new();
      this[_hiddenNum] = random.nextInt(this[_max]);
    }
    guess(guess) {
      this[_attemptCounter] = dart.notNull(this[_attemptCounter]) + 1;
      this[_attempts][$add](guess);
      if (guess != this[_hiddenNum]) {
        this[_life] = dart.notNull(this[_life]) - 1;
        if (this[_life] === 0) {
          return 0;
        } else if (dart.notNull(guess) > dart.notNull(this[_hiddenNum])) {
          return 1;
        } else {
          return 2;
        }
      }
      return 3;
    }
    challenge() {
      let challengeWord = null;
      if (this[_attemptCounter][$modulo](dart.notNull(this[_level]) * 2) === 0 && dart.notNull(this[_level]) > 15) {
        let word = word_noun.generateNoun()[$take](1)[$join](" ")[$trim]();
        challengeWord = word;
        this[_word_attempt] = dart.notNull(this[_word_attempt]) + 1;
      }
      return core.String.as(challengeWord);
    }
    progress() {
      this[_level] = dart.notNull(this[_level]) + 1;
      this[_points] = dart.notNull(this[_points]) + dart.notNull(this[_level]) * dart.notNull(this[_life]) * dart.notNull(this[_multiplier]);
      if (this[_level][$modulo](5) === 0 && dart.notNull(this[_level]) > 0) {
        this[_multiplier] = dart.notNull(this[_multiplier]) * 2;
      }
      this[_life] = 10;
    }
  };
  (controller.controller.new = function() {
    controller.controller.__proto__.new.call(this);
    ;
  }).prototype = controller.controller.prototype;
  dart.addTypeTests(controller.controller);
  dart.addTypeCaches(controller.controller);
  dart.setMethodSignature(controller.controller, () => ({
    __proto__: dart.getMethods(controller.controller.__proto__),
    getQuestion: dart.fnType(core.String, []),
    getLevel: dart.fnType(core.int, []),
    getPoints: dart.fnType(core.int, []),
    getLife: dart.fnType(core.int, []),
    getMultiplier: dart.fnType(core.int, []),
    getWordAttempt: dart.fnType(core.int, []),
    getHiddenNumber: dart.fnType(core.int, []),
    getRemarks: dart.fnType(core.String, [core.int]),
    getAttempts: dart.fnType(core.List, []),
    clearAttempts: dart.fnType(dart.void, []),
    randomNumber: dart.fnType(dart.void, []),
    guess: dart.fnType(core.int, [core.int]),
    challenge: dart.fnType(core.String, []),
    progress: dart.fnType(dart.void, [])
  }));
  dart.setLibraryUri(controller.controller, L0);
  dart.trackLibraries("web/controller", {
    "org-dartlang-app:///web/main.dart": main,
    "org-dartlang-app:///web/controller.dart": controller
  }, {
  }, '{"version":3,"sourceRoot":"","sources":["main.dart","controller.dart"],"names":[],"mappings":"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","file":"controller.ddc.js"}');
  // Exports:
  return {
    web__main: main,
    web__controller: controller
  };
});

//# sourceMappingURL=controller.ddc.js.map
