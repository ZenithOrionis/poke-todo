class Todo {
  final String id;
  final String title;
  bool isCompleted;
  final int? pokemonId;
  final String? pokemonName;
  final String? pokemonImageUrl;

  Todo({
    required this.id,
    required this.title,
    this.isCompleted = false,
    this.pokemonId,
    this.pokemonName,
    this.pokemonImageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
      'pokemonId': pokemonId,
      'pokemonName': pokemonName,
      'pokemonImageUrl': pokemonImageUrl,
    };
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      isCompleted: json['isCompleted'],
      pokemonId: json['pokemonId'],
      pokemonName: json['pokemonName'],
      pokemonImageUrl: json['pokemonImageUrl'],
    );
  }
}
