import 'dart:convert';
import 'dart:io';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

class I18nLocalizations {
  I18nLocalizations._internal() {
    Hive.initFlutter();
  }

  static final I18nLocalizations _singleton = I18nLocalizations._internal();
  factory I18nLocalizations() => _singleton;

  static late String _locale;
  var _locales = <String, Map<String, dynamic>>{};

  final List<String> packages = <String>[];
  late Box<Map<String, dynamic>> _hiveBox;

  static Future<void> startWithPackages({
    required List<String> packages,
    required Iterable<Locale> locales,
    required Locale Function(Locale?, Iterable<Locale>)
        localeResolutionCallback,
  }) async {
    _singleton.packages.addAll(packages);
    _locale = localeResolutionCallback(platformLocale, locales).toString();
    await _singleton.load();
  }

  Future<String> loadStringByPath(String path) => rootBundle.loadString(path);

  Future<void> _loadLocalJson(String locale, [String? package]) async {
    final path = (package != "app")
        ? "packages/$package/lang/$locale.json"
        : "lang/$locale.json";

    try {
      final json = await loadStringByPath(path);
      final key = (package != null) ? package : "app";
      _locales.addAll({key: Map.from(jsonDecode(json))});
    } catch (e) {
      final error =
          "ERROR i18n LOAD $path!\n1- Verify if folder lang and json exist.\n2- Verify if lang is in pubspec.yaml assets: ... - lang/";
      _printLog(error);
      throw ErrorHint(error);
    }
  }

  Future<void> _loadLocalCache(String locale, [String? package]) async {
    Map<String, dynamic> json = _hiveBox.get("${locale}_$package") ?? {};

    final key = (package != null) ? package : "app";
    if (json.isNotEmpty) _locales[key]?.addAll(json);
  }

  Future<void> _saveLocalCache(String locale, String package) async {
    if (_locales[package] != null) {
      _hiveBox.put("${locale}_$package", _locales[package]!);
    }
  }

  Future<void> load() async {
    _hiveBox = await Hive.openBox('i18n');
    await Future.wait(packages.map((e) => _loadLocalJson(_locale, e)));

    try {
      final instance = FirebaseRemoteConfig.instance;
      try {
        await instance.fetchAndActivate();
      } catch (_) {
        _printLog(
            "ERROR i18n REMOTE CONFIG \nFetch failure, connection might be unavailable");
      }

      if (instance.lastFetchStatus == RemoteConfigFetchStatus.success) {
        _printLog("I18n - Using remote config");
        await Future.wait(packages.map((e) => startRemoteConfig(_locale, e)));
        for (var e in packages) {
          _saveLocalCache(_locale, e);
        }
      } else {
        _printLog("I18n - Using local cache");
        await Future.wait(packages.map((e) => _loadLocalCache(_locale, e)));
      }
    } catch (e) {
      const error =
          "ERROR i18n REMOTE CONFIG \n1- Add GoogleService-Info.plist for iOS and GoogleService.json for android";
      _printLog(error);
    }
    return;
  }

  Future<void> startRemoteConfig(String locale,
      [String package = "app"]) async {
    try {
      final instance = FirebaseRemoteConfig.instance;
      _printLog("${package}_$locale");

      final value = instance.getString("${package}_$locale");
      if (value.isNotEmpty) _locales[package]?.addAll(jsonDecode(value));
    } catch (e) {
      const error =
          "ERROR i18n GET VALUE REMOTE CONFIG \n1- Verify if the correct locale was created in REMOTE CONFIG";
      throw ErrorHint(error);
    }
  }

  String getValue(String key) {
    String stringLocale = "NOT FOUND [$key]";
    for (var item in packages) {
      if (_locales[item]?.containsKey(key) ?? false) {
        stringLocale = _locales[item]?[key];
        break;
      }
    }

    return stringLocale;
  }

  static Locale get platformLocale {
    var localeBreakdown = List<String?>.filled(2, null);
    localeBreakdown = Platform.localeName.split("_");
    if (localeBreakdown.length > 1) {
      return Locale(localeBreakdown[0]!, localeBreakdown[1]);
    } else {
      return Locale(localeBreakdown[0]!, localeBreakdown[0]);
    }
  }
}

void _printLog(String message) {
  if (kDebugMode) {
    debugPrint(message);
  }
}
