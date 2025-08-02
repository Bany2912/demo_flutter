// lib/models/favorite.dart
class Favorite {
  final String userId;
  final List<String> productIds;

  Favorite({required this.userId, required this.productIds});

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'productIds': productIds,
  };

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      userId: json['userId'],
      productIds: List<String>.from(json['productIds']),
    );
  }
}