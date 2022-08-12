import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putData(
    String key,
    bool value,
  ) async {
    return await sharedPreferences.setBool(key, value);
  }

  static getBoolData(
    String key,
  ) async {
    return sharedPreferences.getBool(key);
  }

  static  dynamic getStringData(
    String key,
  ) async {
    return sharedPreferences.getString(key);
  }

  static Future saveData(
    String key,
    dynamic value,
  ) async {
    if (value is String) return await sharedPreferences.setString(key, value);
    if (value is bool) return await sharedPreferences.setBool(key, value);
    if (value is int) return await sharedPreferences.setInt(key, value);
    return await sharedPreferences.setDouble(key, value);
  }
}
