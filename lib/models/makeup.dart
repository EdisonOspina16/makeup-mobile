class Makeup {
  final int id;
  final String name;
  final String category;
  final bool available;
  final num price;
  final String description;
  final String imagePath;

  const Makeup({
    required this.id,
    required this.name,
    required this.category,
    required this.available,
    required this.price,
    required this.description,
    required this.imagePath,
  });

  factory Makeup.fromJson(Map<String, dynamic> json) {
    return Makeup(
      id: json['id'] as int,
      name: json['name'] as String,
      category: json['category'] as String,
      available: json['available'] as bool,
      price: json['price'] as num,
      description: json['description'] as String,
      imagePath: json['imagePath'] as String,
    );
  }
}
