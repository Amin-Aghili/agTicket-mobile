class TicketModel {
  final int id;
  final int eventId;
  final String title;
  final int price;
  final int priceCurrencyId;
  final int amount;
  final DateTime? ticketDate;
  final String? ticketTime;
  final double? ticketDuration;
  final DateTime createdAt;

  const TicketModel({
    required this.id,
    required this.eventId,
    required this.title,
    required this.price,
    required this.priceCurrencyId,
    required this.amount,
    this.ticketDate,
    this.ticketTime,
    this.ticketDuration,
    required this.createdAt,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      id: json['id'] as int,
      eventId: json['event_id'] as int,
      title: json['title'] as String,
      price: json['price'] as int,
      priceCurrencyId: json['price_currency_id'] as int,
      amount: json['amount'] as int,
      ticketDate: json['ticket_date'] != null
          ? DateTime.parse(json['ticket_date'])
          : null,
      ticketTime: json['ticket_time'] as String?,
      ticketDuration: (json['ticket_duration'] as num?)?.toDouble(),
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'event_id': eventId,
      'title': title,
      'price': price,
      'price_currency_id': priceCurrencyId,
      'amount': amount,
      'ticket_date': ticketDate?.toIso8601String().split('T')[0],
      'ticket_time': ticketTime,
      'ticket_duration': ticketDuration,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
