class Planet {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final bool isDestroyed;

  Planet({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.isDestroyed,
  });

  factory Planet.fromJson(Map<String, dynamic> json) {
    return Planet(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['image'],
      isDestroyed: json['isDestroyed'],
    );
  }
}
