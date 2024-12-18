// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Sign up for {nameOfTheApp}`
  String signUp(String nameOfTheApp) {
    return Intl.message(
      'Sign up for $nameOfTheApp',
      name: 'signUp',
      desc: 'The title people see when they open the app for the first time.',
      args: [nameOfTheApp],
    );
  }

  /// `Create a profile, follow other accounrts, make your own {videoCount, plural, =0 {no videos} =1 {video} other {videos}}, and more.`
  String signUpDescription(num videoCount) {
    return Intl.message(
      'Create a profile, follow other accounrts, make your own ${Intl.plural(videoCount, zero: 'no videos', one: 'video', other: 'videos')}, and more.',
      name: 'signUpDescription',
      desc: '',
      args: [videoCount],
    );
  }

  /// `Use email & password`
  String get signUpWithEmail {
    return Intl.message(
      'Use email & password',
      name: 'signUpWithEmail',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Apple`
  String get signUpWithApple {
    return Intl.message(
      'Continue with Apple',
      name: 'signUpWithApple',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get alreadyHaveAnAccount {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get login {
    return Intl.message(
      'Log in',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Log in to {nameOfTheApp}`
  String loginTitle(String nameOfTheApp) {
    return Intl.message(
      'Log in to $nameOfTheApp',
      name: 'loginTitle',
      desc: 'The title people see when they open the app for the first time.',
      args: [nameOfTheApp],
    );
  }

  /// `Manage your account, check notifications, comment on videos, and more.`
  String get loginSubTitle {
    return Intl.message(
      'Manage your account, check notifications, comment on videos, and more.',
      name: 'loginSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `Use email / username`
  String get loginWithEmail {
    return Intl.message(
      'Use email / username',
      name: 'loginWithEmail',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Apple`
  String get loginWithApple {
    return Intl.message(
      'Continue with Apple',
      name: 'loginWithApple',
      desc: '',
      args: [],
    );
  }

  /// `Don\'t have an account?`
  String get dontHavaAccount {
    return Intl.message(
      'Don\\\'t have an account?',
      name: 'dontHavaAccount',
      desc: '',
      args: [],
    );
  }

  /// `{ value }`
  String likeCount(int value) {
    final NumberFormat valueNumberFormat = NumberFormat.compact(
      locale: Intl.getCurrentLocale(),
    );
    final String valueString = valueNumberFormat.format(value);

    return Intl.message(
      '$valueString',
      name: 'likeCount',
      desc: 'The number of likes a video has.',
      args: [valueString],
    );
  }

  /// `{ value }`
  String commentCount(int value) {
    final NumberFormat valueNumberFormat = NumberFormat.compact(
      locale: Intl.getCurrentLocale(),
    );
    final String valueString = valueNumberFormat.format(value);

    return Intl.message(
      '$valueString',
      name: 'commentCount',
      desc: 'The number of comments a video has.',
      args: [valueString],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ko'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
