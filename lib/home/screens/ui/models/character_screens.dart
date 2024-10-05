import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/character_mode.dart';
import 'package:flutter_application_1/provider/api_provider.dart';
import 'package:provider/provider.dart';

/// Pantalla que muestra los detalles de un personaje.
class CharacterScreen extends StatelessWidget {
  final Character character; // Objeto que representa al personaje.
  
  const CharacterScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // Obtiene el tamaño de la pantalla.
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF97CE4C), 
        title: Text(character.name!), // Título de la AppBar con el nombre del personaje.
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            // Imagen del personaje con efecto
            SizedBox(
              height: size.height * 0.35,
              width: double.infinity,
              child: Hero(
                tag: character.id!,
                child: Image.network(
                  character.image!,
                  fit: BoxFit.cover, // Ajusta la imagen para cubrir el espacio.
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              height: size.height * 0.14,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Muestra el estado, especie y origen del personaje.
                  cardData("Estado:", character.status!),
                  cardData("Especie:", character.species!),
                  cardData("Origen:", character.origin!.name!),
                ],
              ),
            ),
            const Text(
              'Episodios',
              style: TextStyle(
                fontSize: 17,
                color: Color(0xFFF4D03F), // Color amarillo vibrante para el título.
                fontWeight: FontWeight.bold,
              ),
            ),
            EpisodeList(size: size, character: character), // Lista de episodios del personaje.
          ],
        ),
      ),
    );
  }

  /// Método que devuelve un widget de tarjeta con datos del personaje.
  Widget cardData(String text1, String text2) {
    return Expanded(
      child: Card(
        color: const Color(0xFF00B5CC), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              text1,
              style: const TextStyle(
                color: Colors.black, 
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              text2,
              style: const TextStyle(
                color: Colors.white, // Texto blanco para el valor.
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Lista de episodios en los que aparece el personaje.
class EpisodeList extends StatefulWidget {
  const EpisodeList({super.key, required this.size, required this.character});

  final Size size; // Tamaño de la pantalla.
  final Character character; // Personaje para el que se mostrarán los episodios.

  @override
  State<EpisodeList> createState() => _EpisodeListState();
}

class _EpisodeListState extends State<EpisodeList> {
  @override
  void initState() {
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);
    apiProvider.getEpisodes(widget.character); // Obtiene los episodios del personaje.
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<ApiProvider>(context); // Accede al ApiProvider.
    return SizedBox(
      height: widget.size.height * 0.35, // Altura de la lista de episodios.
      child: ListView.builder(
        itemCount: apiProvider.episodes.length, // Número de episodios.
        itemBuilder: (context, index) {
          final episode = apiProvider.episodes[index]; // Obtiene el episodio actual.
          return ListTile(
            leading: Text(
              episode.episode!, // Muestra el número de episodio.
              style: const TextStyle(
                color: Color(0xFF00B5CC), // Color azul cian para el número.
                fontWeight: FontWeight.bold,
              ),
            ),
            title: Text(
              episode.name!, // Muestra el nombre del episodio.
              style: const TextStyle(
                color: Colors.white, // Texto blanco para el nombre.
              ),
            ),
            trailing: Text(
              episode.airDate!, // Muestra la fecha de emisión del episodio.
              style: const TextStyle(
                color: Color(0xFFF4D03F), // Color amarillo para la fecha.
              ),
            ),
          );
        },
      ),
    );
  }
}

