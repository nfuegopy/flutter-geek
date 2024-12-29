import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart'; // Necesario para manejar SSL
import '../models/character.dart';
import '../models/planet.dart';

class ApiDragonBallService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://dragonball-api.com/api',
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 3000),
    ),
  );

  ApiDragonBallService() {
    // Configurar Dio para ignorar certificados SSL no válidos
    (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true; // Ignorar SSL
      return client;
    };
  }

  Future<Map<String, dynamic>> fetchCharacters({
    int page = 1,
    int limit = 10,
    String? race,
  }) async {
    try {
      final response = await dio.get('/characters', queryParameters: {
        'page': page,
        'limit': limit,
        if (race != null) 'race': race,
      });

      final data = response.data;
      final characters = (data['items'] as List)
          .map((characterJson) => Character.fromJson(characterJson))
          .toList();

      return {
        'characters': characters,
        'pagination': data['meta'],
        'links': data['links'],
      };
    } catch (e) {
      print('Error fetching Dragon Ball characters: $e');
      throw Exception('Failed to load Dragon Ball characters.');
    }
  }

  Future<Map<String, dynamic>> fetchPlanets({
    int page = 1,
    int limit = 10,
    String? isDestroyed,
  }) async {
    try {
      final response = await dio.get('/planets', queryParameters: {
        'page': page,
        'limit': limit,
        if (isDestroyed != null) 'isDestroyed': isDestroyed,
      });

      final data = response.data;
      final planets = (data['items'] as List)
          .map((planetJson) => Planet.fromJson(planetJson))
          .toList();

      return {
        'planets': planets,
        'pagination': data['meta'],
        'links': data['links'],
      };
    } catch (e) {
      print('Error fetching Dragon Ball planets: $e');
      throw Exception('Failed to load Dragon Ball planets.');
    }
  }
}
