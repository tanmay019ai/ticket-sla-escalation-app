import 'package:flutter/material.dart';
import '../ticket_store.dart';

class TicketDetailScreen extends StatefulWidget {
  const TicketDetailScreen({super.key});

  @override
  State<TicketDetailScreen> createState() => _TicketDetailScreenState();
}

class _TicketDetailScreenState extends State<TicketDetailScreen> {
  late Ticket ticket;
  late String role;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    ticket = args['ticket'];
    role = args['role'];
  }

  Duration _getSlaDuration(String priority) {
    switch (priority) {
      case "High":
        return const Duration(minutes: 2);
      case "Medium":
        return const Duration(minutes: 5);
      default:
        return const Duration(minutes: 10);
    }
  }

  String _getRemainingTime() {
    final endTime = ticket.createdAt.add(_getSlaDuration(ticket.priority));
    final diff = endTime.difference(DateTime.now());

    if (diff.isNegative) return "SLA Breached";

    final m = diff.inMinutes;
    final s = diff.inSeconds % 60;
    return "${m}m ${s}s left";
  }

  @override
  Widget build(BuildContext context) {
    final isBreached = _getRemainingTime() == "SLA Breached";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ticket Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _sectionTitle("Title"),
            _infoCard(ticket.title),

            _sectionTitle("Description"),
            _infoCard(ticket.description),

            _sectionTitle("Priority"),
            _infoCard(ticket.priority),

            _sectionTitle("Status"),
            _infoCard(ticket.status),

            _sectionTitle("Assigned To"),
            _infoCard(ticket.assignedTo ?? "Not Assigned"),

            _sectionTitle("SLA"),
            _infoCard(
              _getRemainingTime(),
              color: isBreached ? Colors.red : Colors.green,
            ),

            if (ticket.escalated)
              const Padding(
                padding: EdgeInsets.only(top: 12),
                child: Text(
                  "AUTO ESCALATED",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            const SizedBox(height: 24),

            // ================= ADMIN ACTION =================
            if (role == "Admin")
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Assign Agent",
                ),
                value: ticket.assignedTo == "Admin"
                    ? null
                    : ticket.assignedTo,
                items: const [
                  DropdownMenuItem(value: "Agent1", child: Text("Agent1")),
                  DropdownMenuItem(value: "Agent2", child: Text("Agent2")),
                ],
                onChanged: (value) {
                  setState(() {
                    ticket.assignedTo = value!;
                    ticket.escalated = false;
                  });
                },
              ),

            // ================= AGENT ACTION =================
            if (role == "Agent" && ticket.assignedTo == "Agent1")
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Update Status",
                ),
                value: ticket.status,
                items: const [
                  DropdownMenuItem(value: "Open", child: Text("Open")),
                  DropdownMenuItem(
                      value: "In Progress", child: Text("In Progress")),
                  DropdownMenuItem(
                      value: "Resolved", child: Text("Resolved")),
                ],
                onChanged: (value) {
                  setState(() {
                    ticket.status = value!;
                  });
                },
              ),
          ],
        ),
      ),
    );
  }

  // ================= UI HELPERS =================

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _infoCard(String text, {Color? color}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color?.withOpacity(0.1) ?? Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color ?? Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
