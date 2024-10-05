import 'package:flutter/material.dart';
import 'package:flutter_application_1/home/screens/home_screens.dart';
import 'package:flutter_application_1/home/screens/ui/models/character_screens.dart';
import 'package:flutter_application_1/models/character_mode.dart';
import 'package:flutter_application_1/provider/api_provider.dart';
import 'package:flutter_application_1/utils/widgets/search_delegate.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/utils/widgets/my-drawer.dart';

void main() => runApp(const MyApp());

final GoRouter _router = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) {
      return const MyHome(); // Usa la clase MyHome como pantalla principal
    },
    routes: [
      GoRoute(
        path: 'character',
        builder: (context, state) {
          final character = state.extra as Character;
          return CharacterScreen(
            character: character,
          );
        },
      )
    ],
  )
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ApiProvider(),
      child: MaterialApp.router(
        title: 'Rick And Morty APP',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          useMaterial3: true,
          primaryColor: const Color.fromARGB(255, 41, 204, 0), // Color azul verdoso (Cian)
          scaffoldBackgroundColor: const Color(0xFF1E1E1E), // Fondo oscuro
          appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(255, 7, 204, 0), // Fondo azul cian de la AppBar
            foregroundColor: Colors.white, // Texto blanco
          ),
          drawerTheme: const DrawerThemeData(
            backgroundColor: Color(0xFF1A1A1A), // Fondo oscuro del Drawer
          ),
          iconTheme: const IconThemeData(color: Color.fromARGB(255, 91, 206, 76)), // Verde neón para iconos
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Colors.white), // Texto blanco en general
            titleLarge: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ), // Estilo para títulos
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color.fromARGB(255, 106, 206, 76), // Botón flotante verde neón
            foregroundColor: Color.fromARGB(255, 0, 0, 0), // Texto del botón flotante
          ),
        ),
        routerConfig: _router,
      ),
    );
  }
}

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rick and Morty', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: SearchCharacter());
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      drawer: Drawer(child: MyDrawer()), // Menú lateral (Drawer)
      body: const HomeScreen(), // Pantalla principal que muestra los personajes
    );
  }
}

