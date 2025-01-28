import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String _accessTokenKey = 'token';

  // static Future<void> saveToken(String token) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString(_accessTokenKey, token);
  //   print('Token saved: $token');
  // }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token'); // إرجاع التوكين المخزن
  }

  // static Future<void> deleteToken() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.remove(_accessTokenKey);
  //   print('Token deleted');
  // }
}
