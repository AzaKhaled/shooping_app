import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static late SharedPreferences _instance;

  static Future<void> init() async {
    _instance = await SharedPreferences.getInstance();
  }

  static Future<void> setBool(String key, bool value) async {
    await _instance.setBool(key, value);
  }

  static bool getBool(String key, {bool defaultValue = false}) {
    return _instance.getBool(key) ?? defaultValue;
  }

  static Future<void> setString(String key, String value) async {
    await _instance.setString(key, value);
  }

  static String getString(String key, {String defaultValue = ""}) {
    return _instance.getString(key) ?? defaultValue;
  }

  static Future<void> setInt(String key, int value) async {
    await _instance.setInt(key, value);
  }

  static int getInt(String key, {int defaultValue = 0}) {
    return _instance.getInt(key) ?? defaultValue;
  }

  static Future<void> setDouble(String key, double value) async {
    await _instance.setDouble(key, value);
  }

  static double getDouble(String key, {double defaultValue = 0.0}) {
    return _instance.getDouble(key) ?? defaultValue;
  }

  static Future<void> setStringList(String key, List<String> value) async {
    await _instance.setStringList(key, value);
  }

  static List<String> getStringList(String key) {
    return _instance.getStringList(key) ?? [];
  }

  static Future<void> remove(String key) async {
    await _instance.remove(key);
  }

  static Future<void> clear() async {
    await _instance.clear();
  }

  static bool containsKey(String key) {
    return _instance.containsKey(key);
  }
}
