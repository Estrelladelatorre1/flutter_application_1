import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/character_mode.dart';
import 'package:flutter_application_1/models/episode_model.dart'; 
import 'package:http/http.dart' as http; 

// Clase ApiProvider que gestiona la comunicación con la API.
class ApiProvider with ChangeNotifier {
  final url = 'rickandmortyapi.com'; // URL base de la API.
  List<Character> characters = []; // Lista para almacenar personajes.
  List<Episode> episodes = []; // Lista para almacenar episodios.

  // Método para obtener personajes de una página.
  Future<void> getCharacters(int page) async {
    final result = await http.get(Uri.https(url, "/api/character", { // Solicita personajes de la API.
      'page': page.toString(), // Agrega el parámetro de página.
    }));

    final response = characterResponseFromJson(result.body); // Convierte la respuesta a un objeto.
    characters.addAll(response.results!); // Agrega personajes a la lista.
    notifyListeners(); // Notifica a la UI que los datos han cambiado.
  }

  // Método para buscar un personaje por nombre.
  Future<List<Character>> getCharacter(String name) async {
    final result = await http.get(Uri.https(url, '/api/character/', {'name': name})); // Solicita un personaje por nombre.
    final response = characterResponseFromJson(result.body); // Convierte la respuesta a un objeto.
    return response.results!; // Devuelve la lista de personajes.
  }

  // Método para obtener episodios de un personaje.
  Future<List<Episode>> getEpisodes(Character character) async {
    episodes = []; // Reinicia la lista de episodios.
    for (var i = 0; i < character.episode!.length; i++) { // Itera sobre las URLs de episodios.
      final result = await http.get(Uri.parse(character.episode![i])); // Solicita cada episodio.
      final response = episodeFromJson(result.body); // Convierte la respuesta a un objeto.
      episodes.add(response); // Agrega el episodio a la lista.
      notifyListeners(); // Notifica a la UI que la lista ha cambiado.
    }
    return episodes; // Devuelve la lista de episodios.
  }
}
