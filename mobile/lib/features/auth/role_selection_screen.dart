import 'package:flutter/material.dart';
import '../../core/session/session_manager.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text("Select Role"),
        elevation: 0,
        automaticallyImplyLeading: false, // 🔒 block back
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),

            _roleCard(
              context,
              title: "User",
              description: "Raise tickets & track SLA",
              icon: Icons.person,
              color: Colors.blue,
            ),

            _roleCard(
              context,
              title: "Agent",
              description: "Resolve tickets within SLA",
              icon: Icons.support_agent,
              color: Colors.orange,
            ),

            _roleCard(
              context,
              title: "Admin",
              description: "Manage SLA & escalation rules",
              icon: Icons.admin_panel_settings,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  // ================= ROLE CARD =================

  Widget _roleCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.15),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),

        onTap: () async {
          // ✅ SAVE SESSION (MATCHES SESSION MANAGER)
          await SessionManager.login(
            title,                 // role
            "local-dev-token",     // token (fake for now)
          );

          // ✅ CLEAR STACK & GO DASHBOARD
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/dashboard',
            (route) => false,
          );
        },
      ),
    );
  }
}
