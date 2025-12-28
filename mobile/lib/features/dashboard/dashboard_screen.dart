import 'dart:async';
import 'package:flutter/material.dart';
import '../ticket_store.dart';
import '../../core/session/session_manager.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // 🔁 SLA live refresh
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(_checkAutoEscalation);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // ================= SLA CONFIG =================

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

  String _getRemainingTime(Ticket ticket) {
    final endTime =
        ticket.createdAt.add(_getSlaDuration(ticket.priority));
    final diff = endTime.difference(DateTime.now());

    if (diff.isNegative) return "SLA Breached";

    return "${diff.inMinutes}m ${diff.inSeconds % 60}s left";
  }

  // ================= AUTO ESCALATION =================

  void _checkAutoEscalation() {
    for (final ticket in TicketStore.tickets) {
      final endTime =
          ticket.createdAt.add(_getSlaDuration(ticket.priority));

      if (DateTime.now().isAfter(endTime) &&
          ticket.status != "Resolved" &&
          !ticket.escalated) {
        ticket.escalated = true;
        ticket.assignedTo = "Admin";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final role = SessionManager.role ?? "User";


    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: Text("$role Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
         onPressed: () {
  SessionManager.logout();
  Navigator.pushNamedAndRemoveUntil(
    context,
    '/login',
    (route) => false,
  );
},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "All Tickets",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // ================= TICKET LIST =================
            Expanded(
              child: TicketStore.tickets.isEmpty
                  ? const Center(
                      child: Text(
                        "No tickets created",
                        style: TextStyle(color: Colors.black54),
                      ),
                    )
                  : ListView.builder(
                      itemCount: TicketStore.tickets.length,
                      itemBuilder: (context, index) =>
                          _ticketCard(TicketStore.tickets[index], role),
                    ),
            ),

            // ================= USER ACTION =================
            if (role == "User")
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    await Navigator.pushNamed(context, '/create-ticket');
                    setState(() {});
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Create Ticket"),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ================= TICKET CARD =================

 Widget _ticketCard(Ticket ticket, String role) {
  final remaining = _getRemainingTime(ticket);
  final isBreached = remaining == "SLA Breached";

  return InkWell(
    borderRadius: BorderRadius.circular(12),
    onTap: () {
      Navigator.pushNamed(
        context,
        '/ticket-detail',
        arguments: {
          'ticket': ticket,
          'role': role,
        },
      );
    },
    child: Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: ticket.escalated ? Colors.red.shade50 : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ticket.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _slaChip(remaining, isBreached),
              ],
            ),
            const SizedBox(height: 8),

            Text("Priority: ${ticket.priority}"),
            Text("Status: ${ticket.status}"),
            Text("Assigned: ${ticket.assignedTo ?? "Not Assigned"}"),

            if (ticket.escalated)
              const Padding(
                padding: EdgeInsets.only(top: 6),
                child: Text(
                  "AUTO ESCALATED",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            const SizedBox(height: 12),

            // ACTIONS (prevent tap conflict)
            Align(
              alignment: Alignment.centerRight,
              child: IgnorePointer(
                ignoring: false,
                child: _actionWidget(ticket, role),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

  // ================= ACTIONS =================

  Widget _actionWidget(Ticket ticket, String role) {
    if (role == "Admin") {
      return DropdownButton<String>(
        hint: const Text("Assign"),
        value: ticket.assignedTo == "Admin" ? null : ticket.assignedTo,
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
      );
    }

    if (role == "Agent" && ticket.assignedTo == "Agent1") {
      return DropdownButton<String>(
        value: ticket.status,
        items: const [
          DropdownMenuItem(value: "Open", child: Text("Open")),
          DropdownMenuItem(value: "In Progress", child: Text("In Progress")),
          DropdownMenuItem(value: "Resolved", child: Text("Resolved")),
        ],
        onChanged: (value) {
          setState(() {
            ticket.status = value!;
          });
        },
      );
    }

    return const SizedBox.shrink();
  }

  // ================= SLA CHIP =================

  Widget _slaChip(String text, bool breached) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: breached ? Colors.red : Colors.green,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
