import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CustomEnv {
  static Map<String, dynamic> map = {};
  static get(String key) => map[key];

  static FutureOr<void> load(String fileName) async {
    if (loadDartDefines() == false) {
      await loadEnv(fileName);
    }
    return;
  }

  static Future<void> loadEnv(String fileName) async {
    try {
      final response = await rootBundle.loadString(fileName);
      final parse = const Parser().parse(response.split("\n"));

      map["ENV"] = parse["ENV"] ?? parse['env'];
      map["THEME"] = parse["THEME"] ?? parse['theme'];
    } catch (e) {
      rethrow;
    }
  }

  static bool loadDartDefines() {
    try {
      const env = String.fromEnvironment("env");
      const _env = String.fromEnvironment("ENV");

      const theme = String.fromEnvironment("theme");
      const _theme = String.fromEnvironment("THEME");

      if ((env.isEmpty && _env.isEmpty) || (theme.isEmpty && _theme.isEmpty)) {
        return false;
      }

      map['ENV'] = env.isEmpty ? _env : env;
      map['THEME'] = theme.isEmpty ? _theme : theme;

      return true;
    } catch (e) {
      return false;
    }
  }
}
