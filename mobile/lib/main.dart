import 'package:flutter/material.dart';
import 'app.dart';
import 'core/session/session_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SessionManager.loadSession();
  runApp(const MyApp());
}

