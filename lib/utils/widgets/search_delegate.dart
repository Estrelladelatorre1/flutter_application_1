import 'package:flutter/material.dart'; 
import 'package:flutter_application_1/models/character_mode.dart'; 
import 'package:flutter_application_1/provider/api_provider.dart'; 
import 'package:go_router/go_router.dart'; 
import 'package:provider/provider.dart'; 

class SearchCharacter extends SearchDelegate { // Clase que extiende SearchDelegate para implementar la búsqueda de personajes.
  @override
  List<Widget>? buildActions(BuildContext context) { // Construye los iconos de acciones en la barra de búsqueda.
    return [
      IconButton(
        onPressed: () {
          query = ''; // Limpia el campo de búsqueda al presionar el botón.
        },
        icon: const Icon(Icons.clear, color: Color(0xFF42A5F5)), 
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) { // Construye el icono que aparece al inicio de la barra de búsqueda.
    return IconButton(
      onPressed: () {
        close(context, null); // Cierra la búsqueda y regresa a la pantalla anterior.
      },
      icon: const Icon(Icons.arrow_back, color: Color(0xFF97CE4C)), 
    );
  }

  @override
  Widget buildResults(BuildContext context) { // Construye el widget que se muestra con los resultados de la búsqueda.
    return Container(); 
  }

  @override
  Widget buildSuggestions(BuildContext context) { // Construye las sugerencias basadas en la entrada del usuario.
    final characterProvider = Provider.of<ApiProvider>(context); 

    Widget circleLoading() { // Widget que muestra un círculo de carga.
      return const Center(
        child: CircleAvatar(
          radius: 100,
          backgroundImage: AssetImage('assets/images/portal.gif'), // Imagen de carga de la serie.
        ),
      );
    }

    if (query.isEmpty) { // Si no hay texto en la búsqueda muestra el círculo de carga.
      return circleLoading();
    }

    return FutureBuilder( // Constructor que permite mostrar resultados asíncronos.
      future: characterProvider.getCharacter(query), // Llama a la función para obtener personajes basados en la búsqueda.
      builder: (context, AsyncSnapshot<List<Character>> snapshot) { // Construye el widget según el estado de los datos.
        if (!snapshot.hasData) { // Si no hay datos disponibles, muestra el círculo de carga.
          return circleLoading();
        }
        return ListView.builder( // Crea una lista de personajes que coinciden con la búsqueda.
          itemCount: snapshot.data!.length, // Número de elementos en la lista.
          itemBuilder: (context, index) { // Construye cada elemento de la lista.
            final character = snapshot.data![index]; // Obtiene el personaje en la posición actual.
            return ListTile(
              onTap: () {
                context.go('/character', extra: character); // Navega a la pantalla del personaje al tocarlo.
              },
              title: Text(
                character.name!, // Muestra el nombre del personaje.
                style: const TextStyle(
                  color: Color(0xFFFFEB3B), // Color del texto (amarillo vibrante).
                ),
              ),
              leading: Hero( // Crea una animación de héroe para la imagen del personaje.
                tag: character.id!, // Utiliza el ID del personaje como etiqueta.
                child: CircleAvatar(
                  backgroundImage: NetworkImage(character.image!), // Muestra la imagen del personaje.
                ),
              ),
            );
          },
        );
      },
    );
  }
}
