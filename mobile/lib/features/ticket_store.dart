class Ticket {
  final String title;
  final String description;
  final String priority;
  final String createdBy;

  String status;
  String? assignedTo;
  DateTime createdAt;
  bool escalated;

  Ticket({
    required this.title,
    required this.description,
    required this.priority,
    required this.createdBy,
    this.status = "Open",
    this.assignedTo,
    DateTime? createdAt,
    this.escalated = false,
  }) : createdAt = createdAt ?? DateTime.now();
}

class TicketStore {
  static final List<Ticket> tickets = [];

  static void addTicket(Ticket ticket) {
    tickets.add(ticket);
  }
}
