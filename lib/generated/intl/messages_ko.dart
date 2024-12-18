// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ko locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ko';

  static String m0(value) => "${value}";

  static String m1(value) => "${value}";

  static String m2(nameOfTheApp) => "${nameOfTheApp}에 로그인하기";

  static String m3(nameOfTheApp) => "${nameOfTheApp}에 가입하기";

  static String m4(videoCount) => "나만의 프로필, 다른 계정들을 팔로우, 자신의 비디오 만들기 등...";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "alreadyHaveAnAccount":
            MessageLookupByLibrary.simpleMessage("이미 계정이 있다면?"),
        "commentCount": m0,
        "dontHavaAccount": MessageLookupByLibrary.simpleMessage("계정이 없으신가요?"),
        "likeCount": m1,
        "login": MessageLookupByLibrary.simpleMessage("로그인"),
        "loginSubTitle": MessageLookupByLibrary.simpleMessage(
            "계정 관리, 알림 확인, 동영상 댓글 달기 등을 할 수 있습니다."),
        "loginTitle": m2,
        "loginWithApple": MessageLookupByLibrary.simpleMessage("Apple로 계속하기"),
        "loginWithEmail":
            MessageLookupByLibrary.simpleMessage("이메일 / 사용자 이름으로 로그인"),
        "signUp": m3,
        "signUpDescription": m4,
        "signUpWithApple":
            MessageLookupByLibrary.simpleMessage("Apple 계정으로 계속하기"),
        "signUpWithEmail":
            MessageLookupByLibrary.simpleMessage("이메일 & 비밀번호로 로그인")
      };
}
