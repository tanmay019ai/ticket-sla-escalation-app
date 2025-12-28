import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/session/session_manager.dart';
import 'features/auth/login_screen.dart';
import 'features/dashboard/dashboard_screen.dart';
import 'features/auth/register_screen.dart';
import 'features/auth/role_selection_screen.dart';
import 'features/tickets/create_ticket_screen.dart';
import 'features/tickets/ticket_detail_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ticket & SLA Escalation',
      theme: AppTheme.lightTheme,

      // 🔥 THIS IS THE FIX
      home: SessionManager.isLoggedIn
          ? DashboardScreen()
          : const LoginScreen(),

      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/role': (context) => const RoleSelectionScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/create-ticket': (context) => const CreateTicketScreen(),
        '/ticket-detail': (context) => const TicketDetailScreen(),
      },
    );
  }
}
