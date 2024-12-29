import 'package:dio/dio.dart';
import '../models/pokemon.dart';

class ApiPokedexService {
  // Configuración para PokéAPI
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://pokeapi.co/api/v2',
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 3000),
    ),
  );

  // **PokéAPI: Fetch Pokémon**
  Future<List<Pokemon>> fetchPokemons({int page = 1, int limit = 20}) async {
    try {
      final offset = (page - 1) * limit;
      final response = await dio.get('/pokemon', queryParameters: {
        'offset': offset,
        'limit': limit,
      });

      final results = response.data['results'] as List;

      // Obtiene los detalles de cada Pokémon
      final pokemons = await Future.wait(results.map((pokemonJson) async {
        final detailResponse = await dio.get(pokemonJson['url']);
        return Pokemon.fromJson(detailResponse.data);
      }).toList());

      return pokemons; // Devuelve la lista de Pokémon
    } catch (e) {
      throw Exception('Failed to load Pokémon: $e');
    }
  }
}
