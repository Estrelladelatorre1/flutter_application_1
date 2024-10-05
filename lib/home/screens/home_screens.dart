import 'package:flutter/material.dart';
import 'package:flutter_application_1/home/screens/ui/models/character_screens.dart';
import 'package:flutter_application_1/models/character_mode.dart';
import 'package:flutter_application_1/provider/api_provider.dart';
import 'package:flutter_application_1/utils/widgets/search_delegate.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/utils/widgets/my-drawer.dart';

// Función principal que inicia la aplicación
void main() => runApp(const MyApp());

// Configuración del enrutador con las rutas de la aplicación
final GoRouter _router = GoRouter(routes: [
  GoRoute(
    path: '/',  // Ruta principal
    builder: (context, state) {
      return const MyHome();  // Pantalla inicial con la barra de búsqueda y la lista de personajes
    },
    routes: [
      GoRoute(
        path: 'character',  // Ruta para la pantalla de un personaje
        builder: (context, state) {
          final character = state.extra as Character;  // Obtiene el personaje pasado a la ruta
          return CharacterScreen(
            character: character,  // Pasa el personaje a la pantalla de detalles
          );
        },
      )
    ],
  ),
]);

// Widget principal de la aplicación
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ApiProvider(),  // Proveedor de estado para manejar la API
      child: MaterialApp.router(
        title: 'Rick And Morty APP',  // Título de la aplicación
        debugShowCheckedModeBanner: false,  // Oculta la etiqueta de depuración
        theme: ThemeData(
          brightness: Brightness.light,  // Tema oscuro
          useMaterial3: true,
          primaryColor: const Color(0xFF00B5CC),
          scaffoldBackgroundColor: const Color.fromARGB(255, 40, 82, 26), 
          appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(255, 168, 215, 102), 
            foregroundColor: Color.fromARGB(255, 0, 0, 0), 
          ),
          iconTheme: const IconThemeData(color: Color(0xFFF4D03F)), 
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color(0xFF00B5CC), 
            foregroundColor: Colors.white, 
          ),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Colors.white), 
            titleLarge: TextStyle(
              color: Colors.white,  // Títulos 
              fontWeight: FontWeight.bold,  // Títulos en negrita
            ),
          ),
        ),
        routerConfig: _router,  // Configura el enrutador de la aplicación
      ),
    );
  }
}

// Pantalla principal de la aplicación
class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rick and Morty', style: TextStyle(fontWeight: FontWeight.bold)), // Título de la barra
        centerTitle: true,  // Centra el título en la barra de la aplicación
        actions: [
          IconButton(
            onPressed: () {  // Acción del botón de búsqueda
              showSearch(context: context, delegate: SearchCharacter()); // Muestra la barra de búsqueda
            },
            icon: const Icon(Icons.search),  // Icono de búsqueda
          ),
        ],
      ),
      drawer: Drawer(child: MyDrawer()), // Menú lateral (Drawer)
      body: const HomeScreen(), // Pantalla que muestra la lista de personajes
    );
  }
}

// Widget para mostrar la lista de personajes
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState(); // Estado del HomeScreen
}

class _HomeScreenState extends State<HomeScreen> {
  final scrollController = ScrollController(); // Controlador para el scroll
  bool isLoading = false; // Estado de carga
  int page = 1; // Página actual para la paginación

  @override
  void initState() {
    super.initState();
    final apiProvider = Provider.of<ApiProvider>(context, listen: false); // Accede al proveedor de la API
    apiProvider.getCharacters(page); // Obtiene los personajes de la primera página
    scrollController.addListener(() async { // Escucha el desplazamiento para cargar más personajes
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) { // Al llegar al final
        setState(() {
          isLoading = true; // Cambia el estado a cargando
        });
        page++; // Aumenta el número de página
        await apiProvider.getCharacters(page); // Obtiene los personajes de la nueva página
        setState(() {
          isLoading = false; // Cambia el estado de carga a falso
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<ApiProvider>(context); // Accede al proveedor de la API
    return SizedBox(
      height: double.infinity,  // Ocupa toda la altura disponible
      width: double.infinity,   // Ocupa todo el ancho disponible
      child: apiProvider.characters.isNotEmpty  // Comprueba si hay personajes
          ? CharacterList(  // Muestra la lista de personajes
              apiProvider: apiProvider,  // Proveedor de la API
              isLoading: isLoading,  // Estado de carga
              scrollController: scrollController, // Controlador de desplazamiento
            )
          : const Center(
              child: CircularProgressIndicator(), // Muestra un indicador de carga si no hay personajes
            ),
    );
  }
}

// Widget para mostrar la lista de personajes en un GridView
class CharacterList extends StatelessWidget {
  const CharacterList(
      {super.key, required this.apiProvider, required this.scrollController, required this.isLoading});

  final ApiProvider apiProvider; // Proveedor de la API
  final ScrollController scrollController; // Controlador de desplazamiento
  final bool isLoading; // Estado de carga

  @override
  Widget build(BuildContext context) {
    return GridView.builder(  // Crea un GridView para mostrar los personajes
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,  // Dos columnas en la cuadrícula
        childAspectRatio: 1.0,  // Relación de aspecto para cada celda
        mainAxisSpacing: 10,  // Espacio entre filas
        crossAxisSpacing: 12,  // Espacio entre columnas
      ),
      itemCount: isLoading ? apiProvider.characters.length + 2 : apiProvider.characters.length, // Incrementa el conteo si se está cargando
      controller: scrollController, // Controlador de desplazamiento
      itemBuilder: (context, index) {
        if (index < apiProvider.characters.length) {  // Comprueba si el índice es válido
          final character = apiProvider.characters[index]; // Obtiene el personaje de la lista
          return GestureDetector(  // Detecta toques en el personaje
            onTap: () {  // Al tocar el personaje
              context.go('/character', extra: character); // Navega a la pantalla del personaje
            },
            child: Card(  // Crea una tarjeta para el personaje
              child: Column(  // Organiza el contenido de la tarjeta en columna
                children: [
                  Hero(  // Widget para animar la transición entre pantallas
                    tag: character.id!,  // Identificador único para la animación
                    child: FadeInImage(  // Muestra una imagen con efecto de desvanecimiento
                      placeholder: const AssetImage('assets/images/portal.gif'), // Imagen de carga
                      image: NetworkImage(character.image!),  // Imagen del personaje
                    ),
                  ),
                  Text(  // Muestra el nombre del personaje
                    character.name!,
                    style: const TextStyle(
                      fontSize: 16,  // Tamaño de fuente
                      overflow: TextOverflow.ellipsis, // Muestra '...' si el texto es demasiado largo
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(), // Muestra un indicador de carga al final
          );
        }
      },
    );
  }
}

