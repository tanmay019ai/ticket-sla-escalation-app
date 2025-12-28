import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static String? token;
  static String? role;
  static bool isLoggedIn = false;

  static Future<void> saveSession(
      String newToken, String newRole) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', newToken);
    await prefs.setString('role', newRole);

    token = newToken;
    role = newRole;
    isLoggedIn = true;
  }

  static Future<void> loadSession() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    role = prefs.getString('role');
    isLoggedIn = token != null;
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    token = null;
    role = null;
    isLoggedIn = false;
  }
}
