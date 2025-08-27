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
  final String? startTime;
  final String? endTime;
  final bool? isEveryDay;
  final DateTime createdAt;

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
      startTime: json['start_time'] as String?,
      endTime: json['end_time'] as String?,
      isEveryDay: json['is_every_day'] as bool?,
      createdAt: DateTime.parse(json['created_at']),
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
      'start_time': startTime,
      'end_time': endTime,
      'is_every_day': isEveryDay,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
