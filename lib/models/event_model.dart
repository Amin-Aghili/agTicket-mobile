import 'package:ag_ticket/utils/format.dart';
import 'package:flutter/material.dart';

class EventModel {
  final int id;
  final int companyId;
  final int creatorUserId;
  final String eventName;
  final int? eventTypeId;
  final String? location;
  final int? capacity;
  final int? price;
  final int priceCurrencyId;
  final int? minAge;
  final DateTime? startDate;
  final DateTime? endDate;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final bool? isEveryDay;
  final DateTime createdAt;
  final int? status;

  const EventModel({
    required this.id,
    required this.companyId,
    required this.creatorUserId,
    required this.eventName,
    this.eventTypeId,
    this.location,
    this.capacity,
    this.price,
    required this.priceCurrencyId,
    this.minAge,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.isEveryDay,
    required this.createdAt,
    this.status,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'] as int,
      companyId: json['company_id'] as int,
      creatorUserId: json['creator_user_id'] as int,
      eventName: json['event_name'] as String,
      eventTypeId: json['event_type_id'] as int?,
      location: json['location'] as String?,
      capacity: json['capacity'] as int?,
      price: json['price'] as int?,
      priceCurrencyId: json['price_currency_id'] as int,
      minAge: json['min_age'] as int?,
      startDate: json['start_date'] != null
          ? DateTime.parse(json['start_date'])
          : null,
      endDate:
          json['end_date'] != null ? DateTime.parse(json['end_date']) : null,
      startTime: timeFromString(json['start_time'] as String?),
      endTime: timeFromString(json['end_time'] as String?),
      isEveryDay: json['is_every_day'] as bool?,
      createdAt: DateTime.parse(json['created_at']),
      status: json['status'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company_id': companyId,
      'creator_user_id': creatorUserId,
      'event_name': eventName,
      'event_type_id': eventTypeId,
      'location': location,
      'capacity': capacity,
      'price': price,
      'price_currency_id': priceCurrencyId,
      'min_age': minAge,
      'start_date': startDate?.toIso8601String().split('T')[0],
      'end_date': endDate?.toIso8601String().split('T')[0],
      'start_time': timeToString(startTime),
      'end_time': timeToString(endTime),
      'is_every_day': isEveryDay,
      'created_at': createdAt.toIso8601String(),
      'status': status,
    };
  }

  EventModel copyWith({
    int? id,
    int? companyId,
    int? creatorUserId,
    String? eventName,
    int? eventTypeId,
    String? location,
    int? capacity,
    int? price,
    int? priceCurrencyId,
    int? minAge,
    DateTime? startDate,
    DateTime? endDate,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    bool? isEveryDay,
    DateTime? createdAt,
    int? status,
  }) {
    return EventModel(
      id: id ?? this.id,
      companyId: companyId ?? this.companyId,
      creatorUserId: creatorUserId ?? this.creatorUserId,
      eventName: eventName ?? this.eventName,
      eventTypeId: eventTypeId ?? this.eventTypeId,
      location: location ?? this.location,
      capacity: capacity ?? this.capacity,
      price: price ?? this.price,
      priceCurrencyId: priceCurrencyId ?? this.priceCurrencyId,
      minAge: minAge ?? this.minAge,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isEveryDay: isEveryDay ?? this.isEveryDay,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
    );
  }
}
