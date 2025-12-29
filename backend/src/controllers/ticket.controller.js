const Ticket = require('../models/Ticket');

// ================= CREATE TICKET =================
exports.createTicket = async (req, res) => {
  try {
    const { title, description, priority } = req.body;

    if (!title || !description) {
      return res.status(400).json({ message: 'All fields required' });
    }

    const ticket = await Ticket.create({
      title,
      description,
      priority,
      createdBy: req.user.id,
    });

    res.status(201).json(ticket);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// ================= GET ALL TICKETS =================
exports.getTickets = async (req, res) => {
  try {
    let tickets;

    if (req.user.role === 'Admin') {
      tickets = await Ticket.find()
        .populate('createdBy', 'email role')
        .populate('assignedTo', 'email role');
    } else if (req.user.role === 'Agent') {
      tickets = await Ticket.find({ assignedTo: req.user.id })
        .populate('createdBy', 'email');
    } else {
      tickets = await Ticket.find({ createdBy: req.user.id });
    }

    res.json(tickets);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// ================= ASSIGN TICKET (ADMIN) =================
exports.assignTicket = async (req, res) => {
  try {
    const { ticketId, agentId } = req.body;

    const ticket = await Ticket.findById(ticketId);
    if (!ticket) {
      return res.status(404).json({ message: 'Ticket not found' });
    }

    ticket.assignedTo = agentId;
    ticket.escalated = false;

    await ticket.save();

    res.json({ message: 'Ticket assigned successfully' });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// ================= UPDATE STATUS (AGENT) =================
exports.updateStatus = async (req, res) => {
  try {
    const { ticketId, status } = req.body;

    const ticket = await Ticket.findById(ticketId);
    if (!ticket) {
      return res.status(404).json({ message: 'Ticket not found' });
    }

    ticket.status = status;
    await ticket.save();

    res.json({ message: 'Status updated' });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};
