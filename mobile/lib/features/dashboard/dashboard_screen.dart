import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text("Dashboard"),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================= HEADER =================
            const Text(
              "Welcome 👋",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              "Here’s the current ticket & SLA overview",
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 24),

            // ================= SLA STATUS =================
            const Text(
              "SLA Status",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),

            GridView.count(
              crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: const [
                _StatusCard(
                  title: "Within SLA",
                  value: "12",
                  color: Colors.green,
                  icon: Icons.check_circle,
                ),
                _StatusCard(
                  title: "At Risk",
                  value: "5",
                  color: Colors.orange,
                  icon: Icons.warning,
                ),
                _StatusCard(
                  title: "Breached",
                  value: "2",
                  color: Colors.red,
                  icon: Icons.error,
                ),
              ],
            ),

            const SizedBox(height: 32),

            // ================= TICKETS =================
            const Text(
              "Recent Tickets",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),

            _ticketTile(
              title: "High Priority Issue",
              subtitle: "SLA expires in 1h 30m",
              color: Colors.red,
            ),
            _ticketTile(
              title: "Medium Priority Request",
              subtitle: "Assigned to Agent",
              color: Colors.orange,
            ),
            _ticketTile(
              title: "Low Priority Ticket",
              subtitle: "Waiting for response",
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  // ================= TICKET TILE =================
  static Widget _ticketTile({
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.15),
          child: Icon(Icons.confirmation_number, color: color),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}

// ================= SLA STATUS CARD =================

class _StatusCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData icon;

  const _StatusCard({
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
        border: Border(
          left: BorderSide(color: color, width: 4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: const TextStyle(color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
