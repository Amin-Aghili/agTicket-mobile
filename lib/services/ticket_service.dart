import 'package:ag_ticket/main.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/ticket_model.dart';

class TicketService {
  // final SupabaseClient supabase = Supabase.instance.client;

  // Reading a ticket by ID
  Future<TicketModel> getTicket(int ticketId) async {
    try {
      final response =
          await supabase.from('ticket').select('*').eq('id', ticketId).single();
      return TicketModel.fromJson(response);
    } catch (e) {
      throw Exception('Failed to fetch ticket: $e');
    }
  }

  // Reading all tickets
  Future<List<TicketModel>> getAllTickets() async {
    try {
      final response = await supabase.from('ticket').select('*');
      print('Raw response: $response');
      return (response as List<dynamic>)
          .map((json) => TicketModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch tickets: $e');
    }
  }

  // Inserting a new ticket
  Future<void> insertTicket(TicketModel ticket) async {
    try {
      await supabase.from('ticket').insert(ticket.toJson());
    } catch (e) {
      throw Exception('Failed to insert ticket: $e');
    }
  }

  // Updating an existing ticket
  Future<void> updateTicket(TicketModel ticket) async {
    try {
      await supabase.from('ticket').update(ticket.toJson()).eq('id', ticket.id);
    } catch (e) {
      throw Exception('Failed to update ticket: $e');
    }
  }

  // Deleting a ticket
  Future<void> deleteTicket(int ticketId) async {
    try {
      await supabase.from('ticket').delete().eq('id', ticketId);
    } catch (e) {
      throw Exception('Failed to delete ticket: $e');
    }
  }

  // Real-time subscription for ticket changes
  Stream<List<TicketModel>> subscribeToTickets() {
    try {
      return supabase.from('ticket').stream(primaryKey: ['id']).map(
          (data) => data.map(TicketModel.fromJson).toList());
    } catch (e) {
      throw Exception('Failed to subscribe to tickets: $e');
    }
  }
}
