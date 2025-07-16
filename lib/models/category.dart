class Category {
  final int id;
  final String name;
  final String? iconUrl;
 

  Category({
    required this.id,
    required this.name,
    this.iconUrl

    
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json['id'],
        name: json['name'],
        iconUrl: json['iconUrl'],
       
     
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'iconUrl': iconUrl,
     };
}