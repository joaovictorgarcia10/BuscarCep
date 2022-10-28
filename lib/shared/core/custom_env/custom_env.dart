import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CustomEnv {
  static Map<String, dynamic> map = {};
  static get(String key) => map[key];

  static FutureOr<void> load(String fileName) async {
    await loadEnv(fileName);
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
}
