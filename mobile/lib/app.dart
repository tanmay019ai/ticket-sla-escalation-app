import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/login_screen.dart';
import 'features/dashboard/dashboard_screen.dart';
import 'features/auth/register_screen.dart';
import 'features/auth/role_selection_screen.dart';
import 'features/tickets/create_ticket_screen.dart';
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ticket & SLA Escalation',
      theme: AppTheme.lightTheme, // 🔥 APPLY THEME
      initialRoute: '/',
      routes: {
  '/': (context) => const LoginScreen(),
  '/create-ticket': (context) => const CreateTicketScreen(),
  '/role': (context) => const RoleSelectionScreen(),
  '/register': (context) => const RegisterScreen(),
  '/dashboard': (context) => const DashboardScreen(),
},

    );
  }
}
