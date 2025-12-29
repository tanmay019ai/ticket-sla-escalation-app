const express = require('express');
const router = express.Router();
const ticketController = require('../controllers/ticket.controller');
const authMiddleware = require('../middleware/auth.middleware');

router.post('/', authMiddleware, ticketController.createTicket);
router.get('/', authMiddleware, ticketController.getTickets);
router.put('/assign', authMiddleware, ticketController.assignTicket);
router.put('/status', authMiddleware, ticketController.updateStatus);

module.exports = router;
