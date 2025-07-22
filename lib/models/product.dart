

class ShoeProduct {
  final String id;
  final String name;
  final String brandId; 
  final int categoryId; 
  final double price; // <-- Phải là double
  final String description;
  final String mainImage; // <-- KHÔNG CÓ DẤU '?' ở đây, và nó là 'required'
  final List<ShoeVariant> variants;

  ShoeProduct({
    required this.id,
    required this.name,
    required this.brandId,
    required this.categoryId,
    required this.price,
    required this.variants,
    required this.description,
    required this.mainImage, // <-- Thêm 'required' vào constructor
  });

  factory ShoeProduct.fromJson(Map<String, dynamic> json) => ShoeProduct(
        id: json['id'],
        name: json['name'],
        brandId: json['brandId'],
        categoryId: json['categoryId'],
        price: (json['price'] as num).toDouble(), // <-- Ép kiểu an toàn (từ int hoặc double sang double)
        description: json['description'],
        mainImage: json['mainImage'] as String, // <-- Ép kiểu rõ ràng thành String
        variants: List<ShoeVariant>.from(
            json['variants'].map((x) => ShoeVariant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'brandId': brandId,
        'categoryId': categoryId,
        'price': price,
        'description': description,
        'mainImage': mainImage, 
        'variants': variants.map((x) => x.toJson()).toList(),
      };

  bool get hasStock =>
      variants.any((variant) => variant.sizes.any((size) => size.stock > 0));
}
class ShoeVariant {
  final String id;
  final String colorName;
  final String colorCode;
  final String imageUrl;
  final List<String> additionalImages;
  final List<ShoeSize> sizes;

  ShoeVariant({
    required this.id,
    required this.colorName,
    required this.colorCode,
    required this.imageUrl,
    required this.sizes,
    this.additionalImages = const [],
  });

  factory ShoeVariant.fromJson(Map<String, dynamic> json) => ShoeVariant(
        id: json['id'],
        colorName: json['colorName'],
        colorCode: json['colorCode'],
        imageUrl: json['imageUrl'],
        additionalImages: List<String>.from(json['additionalImages'] ?? []),
        sizes: List<ShoeSize>.from(
            json['sizes'].map((x) => ShoeSize.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'colorName': colorName,
        'colorCode': colorCode,
        'imageUrl': imageUrl,
        'additionalImages': additionalImages,
        'sizes': sizes.map((x) => x.toJson()).toList(),
      };
}
class ShoeSize {
  final String id;
  final String size;
  final int stock;

  ShoeSize({
    required this.id,
    required this.size,
    required this.stock,
  });

  factory ShoeSize.fromJson(Map<String, dynamic> json) => ShoeSize(
        id: json['id'],
        size: json['size'],
        stock: json['stock'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'size': size,
        'stock': stock,
      };
}
