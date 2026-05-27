import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static late SharedPreferences _prefs;

  /// Initialize SharedPreferences
  static Future<void> initial() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Save String
  static Future<void> setString({
    required String key,
    required String value,
  }) async {
    await _prefs.setString(key, value);
  }

  /// Get String
  static String? getString(String key) {
    return _prefs.getString(key);
  }

  /// Save Bool
  static Future<void> setBool({
    required String key,
    required bool value,
  }) async {
    await _prefs.setBool(key, value);
  }

  /// Get Bool
  static bool getBool(String key) {
    return _prefs.getBool(key) ?? false;
  }

  /// Save Int
  static Future<void> setInt({required String key, required int value}) async {
    await _prefs.setInt(key, value);
  }

  /// Get Int
  static int getInt(String key) {
    return _prefs.getInt(key) ?? 0;
  }

  /// Remove Data
  static Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  /// Clear All Data
  static Future<void> clear() async {
    await _prefs.clear();
  }

  static Future<void> saveLastFetch(DateTime time) async {
    await _prefs.setInt("lastFetch", time.millisecondsSinceEpoch);
  }

  static DateTime? getLastFetch() {
    final time = _prefs.getInt("lastFetch");
    if (time != null) {
      return DateTime.fromMillisecondsSinceEpoch(time);
    }
    return null;
  }
}
