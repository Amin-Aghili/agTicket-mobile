import 'package:ag_ticket/main.dart';
import '../models/event_model.dart';

class EventService {
  // final SupabaseClient supabase = Supabase.instance.client;

  Future<EventModel> getEvent(int eventId) async {
    try {
      final response =
          await supabase.from('event').select('*').eq('id', eventId).single();
      return EventModel.fromJson(response);
    } catch (e) {
      throw Exception('Failed to fetch event: $e');
    }
  }

  Future<List<EventModel>> getAllEvents() async {
    try {
      final response = await supabase.from('event').select('*');
      return (response as List<dynamic>)
          .map((json) => EventModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch events: $e');
    }
  }

  Future<void> createEvent(EventModel event) async {
    try {
      await supabase.from('event').insert(event.toJson());
    } catch (e) {
      throw Exception('Failed to insert event: $e');
    }
  }

  Future<void> updateEvent(EventModel event) async {
    try {
      await supabase.from('event').update(event.toJson()).eq('id', event.id);
    } catch (e) {
      throw Exception('Failed to update event: $e');
    }
  }

  Future<void> deleteEvent(int eventId) async {
    try {
      await supabase.from('event').delete().eq('id', eventId);
    } catch (e) {
      throw Exception('Failed to delete event: $e');
    }
  }

  Stream<List<EventModel>> subscribeToEvents() {
    try {
      return supabase.from('event').stream(primaryKey: ['id']).map(
          (data) => data.map(EventModel.fromJson).toList());
    } catch (e) {
      throw Exception('Failed to subscribe to events: $e');
    }
  }

  Stream<List<EventModel>> subscribeToCompanyEvents(int companyId) {
    try {
      return supabase
          .from('event')
          .stream(primaryKey: ['id'])
          .eq('company_id', companyId)
          .map((data) => data.map(EventModel.fromJson).toList());
    } catch (e) {
      throw Exception('Failed to subscribe to company events: $e');
    }
  }
}
