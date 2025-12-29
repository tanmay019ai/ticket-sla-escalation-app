import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static bool isLoggedIn = false;
  static String? role;
  static String? token;

  static Future<void> loadSession() async {
    final prefs = await SharedPreferences.getInstance();
    isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    role = prefs.getString('role');
    token = prefs.getString('token');
  }

  static Future<void> login(String userRole, String authToken) async {
    final prefs = await SharedPreferences.getInstance();
    isLoggedIn = true;
    role = userRole;
    token = authToken;

    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('role', userRole);
    await prefs.setString('token', authToken);
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    isLoggedIn = false;
    role = null;
    token = null;
  }
}
