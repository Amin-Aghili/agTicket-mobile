class EventTypeModel {
  final int id;
  final String description;

  const EventTypeModel({
    required this.id,
    required this.description,
  });

  factory EventTypeModel.fromJson(Map<String, dynamic> json) {
    return EventTypeModel(
      id: json['id'] as int,
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
    };
  }
}
