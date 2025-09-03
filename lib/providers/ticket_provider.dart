import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/ticket_model.dart';
import '../services/ticket_service.dart';

/// State
class TicketState {
  final List<TicketModel> tickets;
  final bool isLoading;
  final String? error;

  TicketState({
    this.tickets = const [],
    this.isLoading = false,
    this.error,
  });

  TicketState copyWith({
    List<TicketModel>? tickets,
    bool? isLoading,
    String? error,
  }) {
    return TicketState(
      tickets: tickets ?? this.tickets,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// Notifier
class TicketNotifier extends StateNotifier<TicketState> {
  final TicketService service;

  TicketNotifier(this.service) : super(TicketState());

  /// گرفتن همه بلیت‌ها
  Future<void> loadTickets() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final data = await service.getAllTickets();
      state = state.copyWith(tickets: data, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  /// گرفتن بلیت خاص
  Future<TicketModel?> getTicket(int id) async {
    try {
      return await service.getTicket(id);
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return null;
    }
  }

  /// اضافه کردن
  Future<void> addTicket(TicketModel ticket) async {
    try {
      await service.insertTicket(ticket);
      await loadTickets();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// آپدیت
  Future<void> updateTicket(TicketModel ticket) async {
    try {
      await service.updateTicket(ticket);
      await loadTickets();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// حذف
  Future<void> deleteTicket(int id) async {
    try {
      await service.deleteTicket(id);
      await loadTickets();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// سابسکرایب به تغییرات بلیت‌ها
  void subscribeTickets() {
    service.subscribeToTickets().listen((data) {
      state = state.copyWith(tickets: data);
    });
  }
}

/// Provider اصلی
final ticketProvider = StateNotifierProvider<TicketNotifier, TicketState>(
  (ref) => TicketNotifier(TicketService()),
);
