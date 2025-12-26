import 'package:flutter/material.dart';
import '../../shared/widgets/primary_button.dart';

class CreateTicketScreen extends StatefulWidget {
  const CreateTicketScreen({super.key});

  @override
  State<CreateTicketScreen> createState() => _CreateTicketScreenState();
}

class _CreateTicketScreenState extends State<CreateTicketScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  String priority = "Medium";

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  String getSlaText() {
    switch (priority) {
      case "High":
        return "SLA: 2 Hours (Auto Escalation)";
      case "Medium":
        return "SLA: 8 Hours";
      default:
        return "SLA: 24 Hours";
    }
  }

  void submitTicket() {
    // Backend API will come here later
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text("Create Ticket"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 30,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Ticket Details",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),

              // TITLE
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "Ticket Title",
                  prefixIcon: Icon(Icons.title),
                ),
              ),
              const SizedBox(height: 16),

              // DESCRIPTION
              TextField(
                controller: descriptionController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: "Description",
                  prefixIcon: Icon(Icons.description),
                ),
              ),
              const SizedBox(height: 20),

              // PRIORITY
              const Text(
                "Priority",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),

              DropdownButtonFormField<String>(
                value: priority,
                items: const [
                  DropdownMenuItem(value: "Low", child: Text("Low")),
                  DropdownMenuItem(value: "Medium", child: Text("Medium")),
                  DropdownMenuItem(value: "High", child: Text("High")),
                ],
                onChanged: (value) {
                  setState(() {
                    priority = value!;
                  });
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.flag),
                ),
              ),
              const SizedBox(height: 16),

              // SLA INFO
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: priority == "High"
                      ? Colors.red.withOpacity(0.1)
                      : priority == "Medium"
                          ? Colors.orange.withOpacity(0.1)
                          : Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  getSlaText(),
                  style: TextStyle(
                    color: priority == "High"
                        ? Colors.red
                        : priority == "Medium"
                            ? Colors.orange
                            : Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // SUBMIT
              PrimaryButton(
                text: "SUBMIT TICKET",
                onPressed: submitTicket,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
