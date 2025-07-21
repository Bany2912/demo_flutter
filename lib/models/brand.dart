class Brand {
  final String id;
  final String name;
  final String logoUrl;
  final String? description;

  Brand({
    required this.id,
    required this.name,
    required this.logoUrl,
    this.description,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        id: json['id'],
        name: json['name'],
        logoUrl: json['logoUrl'],
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'logoUrl': logoUrl,
        'description': description,
      };
}