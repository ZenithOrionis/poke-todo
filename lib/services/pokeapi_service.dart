import 'package:pokeapi/pokeapi.dart'; // Add in pubspec.yaml

class PokeApiService {
  Future<List<Pokemon>> getPokemonList({int limit = 100}) async {
    final response = await PokeAPI.getObjectList<Pokemon>(0, limit);
    return response.map((p) =>
        Pokemon(
          name: p.name,
          spriteUrl: p.sprites.frontDefault ?? '',
        )).toList();
  }
  
  Future<Pokemon?> getPokemonDetail(String name) async {
    final result = await PokeAPI.getObject<Pokemon>(name);
    if (result != null) {
      return Pokemon(
        name: result.name,
        spriteUrl: result.sprites.frontDefault ?? '',
      );
    }
    return null;
  }
}
