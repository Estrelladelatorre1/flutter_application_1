import 'package:flutter/material.dart'; 
import 'descripcion_screen.dart'; 
import 'package:flutter_application_1/utils/autor_screen.dart'; 

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key); 

  @override
  Widget build(BuildContext context) {
    return Drawer( // Crea un menú lateral (Drawer).
      child: ListView( // Lista que contiene los elementos del menú.
        children: [
          DrawerHeader( // Encabezado del menú.
            decoration: BoxDecoration(
              color: const Color(0xFF97CE4C), 
            ),
            child: const Text(
              'Menú', // Título del encabezado.
              style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255), 
                fontSize: 24, // Tamaño de fuente.
                fontWeight: FontWeight.bold, // Texto en negrita.
              ),
            ),
          ),
          ListTile( // Primer elemento del menú.
            leading: const Icon(Icons.description, color: Color(0xFF42A5F5)), 
            title: const Text(
              'Descripción', // Título del elemento del menú.
              style: TextStyle(color: Color(0xFF42A5F5)), 
            ),
            onTap: () { // Acción al hacer clic en el elemento.
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DescripcionScreen(), 
              ));
            },
          ),
          ListTile( // Segundo elemento del menú.
            leading: const Icon(Icons.person, color: Color(0xFF4CAF50)), // Icono de autor
            title: const Text(
              'Autor', // Título del elemento del menú.
              style: TextStyle(color: Color(0xFF4CAF50)), 
            ),
            onTap: () { // Acción al hacer clic en el elemento.
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AutorScreen(), // Navega a la pantalla de autor.
              ));
            },
          ),
        ],
      ),
    );
  }
}
