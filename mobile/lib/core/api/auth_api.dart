import 'dart:convert';
import 'package:http/http.dart' as http;
import '../session/session_manager.dart';

class AuthApi {
  static const String baseUrl = "http://10.0.2.2:5000";
  // Android emulator → localhost replacement

  // ================= REGISTER =================
  static Future<String?> register(
    String email,
    String password,
    String role,
  ) async {
    try {
      final res = await http.post(
        Uri.parse("$baseUrl/auth/register"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": email,
          "password": password,
          "role": role,
        }),
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        final data = jsonDecode(res.body);

        await SessionManager.login(
          data['role'] ?? role,
          data['token'] ?? '',
        );

        return null;
      }

      final data = jsonDecode(res.body);
      return data['message'] ?? "Register failed";
    } catch (e) {
      return "Server not reachable";
    }
  }

  // ================= LOGIN =================
  static Future<String?> login(
    String email,
    String password,
  ) async {
    try {
      final res = await http.post(
        Uri.parse("$baseUrl/auth/login"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);

        await SessionManager.login(
          data['role'],
          data['token'],
        );

        return null; // ✅ SUCCESS
      }

      final data = jsonDecode(res.body);
      return data['message'] ?? "Invalid credentials";
    } catch (e) {
      return "Server not reachable";
    }
  }
}
