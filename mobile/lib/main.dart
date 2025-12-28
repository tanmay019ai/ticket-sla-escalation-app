import 'package:flutter/material.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SessionManager.loadSession();
  runApp(const MyApp());
}

