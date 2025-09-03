import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../models/event_model.dart';
import '../services/event_service.dart';

class EventState {
  final List<EventModel> events;
  final String searchQuery;
  final String? filter;

  EventState({
    required this.events,
    this.searchQuery = '',
    this.filter,
  });

  List<EventModel> get filteredEvents {
    return events.where((event) {
      final matchesSearch = searchQuery.isEmpty ||
          event.eventName.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesFilter =
          filter == null || event.status.toString() == filter!.toLowerCase();
      return matchesSearch && matchesFilter;
    }).toList();
  }

  EventState copyWith({
    List<EventModel>? events,
    String? searchQuery,
    String? filter,
  }) {
    return EventState(
      events: events ?? this.events,
      searchQuery: searchQuery ?? this.searchQuery,
      filter: filter ?? this.filter,
    );
  }
}

class EventNotifier extends StateNotifier<EventState> {
  final EventService _service;
  final TextEditingController searchController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  EventNotifier(this._service) : super(EventState(events: [])) {
    loadEvents();
    searchController.addListener(() {
      setSearchQuery(searchController.text);
    });
  }

  // Load all events
  Future<void> loadEvents() async {
    final events = await _service.getAllEvents();
    state = state.copyWith(events: events);
  }

  // Add new event
  Future<void> addEvent(EventModel event) async {
    await _service.createEvent(event);
    state = state.copyWith(events: [...state.events, event]);
  }

  // Update existing event
  Future<void> updateEvent(EventModel updatedEvent) async {
    await _service.updateEvent(updatedEvent);
    final updatedEvents = state.events.map((event) {
      return event.id == updatedEvent.id ? updatedEvent : event;
    }).toList();
    state = state.copyWith(events: updatedEvents);
  }

  // Delete event
  Future<void> deleteEvent(int eventId) async {
    await _service.deleteEvent(eventId);
    final updatedEvents =
        state.events.where((event) => event.id != eventId).toList();
    state = state.copyWith(events: updatedEvents);
  }

  // Search
  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void setFilter(String? filter) {
    state = state.copyWith(filter: filter);
  }

  void clearSearch() {
    searchController.clear();
    setSearchQuery('');
  }

  // Refresh list
  Future<void> refresh() async {
    await loadEvents();
  }
}

final eventProvider = StateNotifierProvider<EventNotifier, EventState>((ref) {
  return EventNotifier(EventService());
});
