import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import '../models/pokemon.dart';

class PokeApiService {
  static const String _baseUrl = 'https://pokeapi.co/api/v2';

  Future<Pokemon?> fetchPokemonById(int id) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/pokemon/$id'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Pokemon.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching pokemon: $e');
      return null;
    }
  }

  Future<Pokemon?> fetchRandomPokemon() async {
    // There are currently 1000+ pokemon, let's limit to first 151 (Gen 1) for nostalgia or 1010 for full
    final randomId = Random().nextInt(1010) + 1; 
    return fetchPokemonById(randomId);
  }
}
