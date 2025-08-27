class CompanyModel {
  final int id;
  final String name;
  final DateTime createdAt;

  const CompanyModel({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      id: json['id'] as int,
      name: json['name'] as String,
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'name': name,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
