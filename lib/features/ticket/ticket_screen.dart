import 'package:ag_ticket/models/ticket_model.dart';
import 'package:ag_ticket/services/ticket_service.dart';
import 'package:flutter/material.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({super.key});

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  final ticketService = TicketService();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _amountController = TextEditingController();
  final _eventIdController = TextEditingController();
  final _priceCurrencyIdController = TextEditingController();
  int? _editingTicketId;

  void _showTicketDialog({TicketModel? ticket}) {
    if (ticket != null) {
      _titleController.text = ticket.title;
      _priceController.text = ticket.price.toString();
      _amountController.text = ticket.amount.toString();
      _eventIdController.text = ticket.eventId.toString();
      _priceCurrencyIdController.text = ticket.priceCurrencyId.toString();
      _editingTicketId = ticket.id;
    } else {
      _titleController.clear();
      _priceController.clear();
      _amountController.clear();
      _eventIdController.clear();
      _priceCurrencyIdController.clear();
      _editingTicketId = null;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(ticket == null ? 'Add Ticket' : 'Edit Ticket'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Ticket Title'),
            ),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _eventIdController,
              decoration: const InputDecoration(labelText: 'Event ID'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _priceCurrencyIdController,
              decoration: const InputDecoration(labelText: 'Price Currency ID'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              if (_titleController.text.isEmpty ||
                  _priceController.text.isEmpty ||
                  _amountController.text.isEmpty ||
                  _eventIdController.text.isEmpty ||
                  _priceCurrencyIdController.text.isEmpty) {
                return;
              }
              try {
                final ticket = TicketModel(
                  id: _editingTicketId ?? 0,
                  eventId: int.parse(_eventIdController.text),
                  title: _titleController.text,
                  price: int.parse(_priceController.text),
                  priceCurrencyId: int.parse(_priceCurrencyIdController.text),
                  amount: int.parse(_amountController.text),
                  ticketDate: null,
                  ticketTime: null,
                  ticketDuration: null,
                  createdAt: DateTime.now(),
                );
                if (_editingTicketId == null) {
                  await ticketService.insertTicket(ticket);
                } else {
                  await ticketService.updateTicket(ticket);
                }
                if (context.mounted) {
                  Navigator.pop(context);
                }
                setState(() {});
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $e')),
                  );
                }
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _amountController.dispose();
    _eventIdController.dispose();
    _priceCurrencyIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tickets'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showTicketDialog(),
          ),
        ],
      ),
      body: StreamBuilder<List<TicketModel>>(
        stream: ticketService.subscribeToTickets(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final tickets = snapshot.data ?? [];
          if (tickets.isEmpty) {
            return const Center(child: Text('No tickets found'));
          }
          return ListView.builder(
            itemCount: tickets.length,
            itemBuilder: (context, index) {
              final ticket = tickets[index];
              return ListTile(
                title: Text(ticket.title),
                subtitle: Text(
                  'ID: ${ticket.id} | Event ID: ${ticket.eventId} | Price: ${ticket.price} | Amount: ${ticket.amount}',
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _showTicketDialog(ticket: ticket),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        try {
                          await ticketService.deleteTicket(ticket.id);
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: $e')),
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
