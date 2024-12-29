class Pokemon {
  final int id;
  final String name;
  final String imageFrontDefault;
  final String imageBackDefault;
  final String imageFrontShiny;
  final String imageBackShiny;
  final List<Type> types;
  final List<String> moves;

  Pokemon({
    required this.id,
    required this.name,
    required this.imageFrontDefault,
    required this.imageBackDefault,
    required this.imageFrontShiny,
    required this.imageBackShiny,
    required this.types,
    required this.moves,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      name: json['name'],
      imageFrontDefault: json['sprites']['front_default'] ?? '',
      imageBackDefault: json['sprites']['back_default'] ?? '',
      imageFrontShiny: json['sprites']['front_shiny'] ?? '',
      imageBackShiny: json['sprites']['back_shiny'] ?? '',
      types: (json['types'] as List)
          .map((type) => Type.fromJson(type['type']))
          .toList(),
      moves: (json['moves'] as List)
          .map((move) => move['move']['name'].toString())
          .toList(),
    );
  }
}

class Type {
  final String name;

  Type({required this.name});

  factory Type.fromJson(Map<String, dynamic> json) {
    return Type(
      name: json['name'],
    );
  }
}
