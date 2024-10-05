import 'package:http/http.dart' as http; 

class HomeRepository {
  final String api = "https://rickandmortyapi.com/api/"; // URL base de la API.

  /// Método asíncrono para obtener la lista de personajes.
  Future<http.Response> getCharacters() async {
    Uri uri = Uri.parse("${api}character/"); // Construye la URI para el endpoint de personajes.
    
    // Realiza la solicitud GET a la API con el encabezado necesario.
    return await http.get(uri, headers: <String, String>{
      'Content-Type': "application/json; charset=UTF-8", // Tipo de contenido especificado.
    });
  }
}
