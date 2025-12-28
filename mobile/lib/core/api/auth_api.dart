import 'dart:convert';
import 'package:http/http.dart' as http;
import '../session/session_manager.dart';

class AuthApi {
  static const String baseUrl = 'http://10.0.2.2:5000'; // Android emulator

  static Future<String?> login(String email, String password) async {
    final res = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    final data = jsonDecode(res.body);

    if (res.statusCode == 200) {
      await SessionManager.saveSession(
        data['token'],
        data['role'],
      );
      return null;
    } else {
      return data['message'];
    }
  }

  static Future<String?> register(
      String email, String password, String role) async {
    final res = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
        'role': role,
      }),
    );

    final data = jsonDecode(res.body);

    if (res.statusCode == 201) {
      await SessionManager.saveSession(
        data['token'],
        data['role'],
      );
      return null;
    } else {
      return data['message'];
    }
  }
}
