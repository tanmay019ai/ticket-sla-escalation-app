import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String role =
        ModalRoute.of(context)?.settings.arguments as String? ?? "User";

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: Text("$role Dashboard"),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _buildDashboardByRole(context, role), // ✅ pass context
      ),
    );
  }

  // ================= ROLE SWITCH =================

  Widget _buildDashboardByRole(BuildContext context, String role) {
    switch (role) {
      case "Agent":
        return _agentDashboard();
      case "Admin":
        return _adminDashboard(context);
      default:
        return _userDashboard(context);
    }
  }

  // ================= USER DASHBOARD =================

  Widget _userDashboard(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _header("Your Tickets"),
        _ticketTile(
          "Login issue",
          "SLA expires in 3h",
          Colors.orange,
        ),
        _ticketTile(
          "Payment failed",
          "Within SLA",
          Colors.green,
        ),
        const SizedBox(height: 24), // ✅ safe spacing
        _actionButton(
          context,
          "Create New Ticket",
          Icons.add,
        ),
      ],
    );
  }

  // ================= AGENT DASHBOARD =================

  Widget _agentDashboard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _header("Assigned Tickets"),
        _ticketTile(
          "Server down",
          "SLA expires in 45m",
          Colors.red,
        ),
        _ticketTile(
          "UI bug",
          "At risk",
          Colors.orange,
        ),
        const SizedBox(height: 20),
        _statusChip("⚠ SLA At Risk"),
      ],
    );
  }

  // ================= ADMIN DASHBOARD =================

  Widget _adminDashboard(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _header("SLA Overview"),
        _slaCard("High Priority SLA", "2 Hours"),
        _slaCard("Medium Priority SLA", "8 Hours"),
        _slaCard("Low Priority SLA", "24 Hours"),
        const SizedBox(height: 24),
        _actionButton(
          context,
          "Manage Escalation Rules",
          Icons.settings,
        ),
      ],
    );
  }

  // ================= REUSABLE UI =================

  Widget _header(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _ticketTile(String title, String subtitle, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.15),
          child: Icon(Icons.confirmation_number, color: color),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }

  Widget _actionButton(
    BuildContext context,
    String text,
    IconData icon,
  ) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.pushNamed(context, '/create-ticket');
        },
        icon: Icon(icon),
        label: Text(text),
      ),
    );
  }

  Widget _statusChip(String text) {
    return Chip(
      backgroundColor: Colors.orange.withOpacity(0.15),
      label: Text(
        text,
        style: const TextStyle(color: Colors.orange),
      ),
    );
  }

  Widget _slaCard(String title, String time) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const Icon(Icons.timer),
        title: Text(title),
        trailing: Text(
          time,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
