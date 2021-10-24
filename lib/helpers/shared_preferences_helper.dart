import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  Future<String> getStorageItem({
    required String key,
    String type = 'string',
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = type == 'string' ? prefs.getString(key) : prefs.getInt(key);

    return result.toString();
  }

  Future<String> setStorageItem({
    required String key,
    required value,
    String type = 'string',
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = type == 'string'
        ? prefs.setString(key, value)
        : prefs.setInt(key, value);

    return result.toString();
  }
}
