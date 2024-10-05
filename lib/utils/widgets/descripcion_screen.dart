import 'package:flutter/material.dart';

class DescripcionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Descripción', // Título de la pantalla
          style: TextStyle(
            fontFamily: 'Pacifico', // Fuente personalizada
            fontSize: 24, // Tamaño de fuente
            fontWeight: FontWeight.bold, // Texto en negrita
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 71, 192, 199), 
      ),
      body: Container(
        color: const Color.fromARGB(255, 166, 158, 97), 
        padding: const EdgeInsets.all(16.0), // Espacio interno del contenedor
        child: SingleChildScrollView( // Permite desplazamiento si el contenido es largo
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Alinea el contenido a la izquierda
            children: [
              Text(
                '¿Por qué Rick & Morty es una de las mejores series del momento?', 
                style: TextStyle(
                  fontSize: 20, // Tamaño de fuente
                  fontWeight: FontWeight.bold, // Texto en negrita
                  color: Colors.green[800], // Color verde oscuro
                ),
              ),
              const SizedBox(height: 10), 
              Text(
                'Por: Univision\nPublicado 3 Oct 2017 – 05:00 PM EDT | Actualizado 24 Abr 2018 – 03:48 PM EDT', 
                style: TextStyle(
                  fontSize: 16, // Tamaño de fuente
                  color: const Color.fromARGB(255, 2, 14, 24), 
                ),
              ),
              const SizedBox(height: 15), // Espacio vertical entre los elementos
              Text(
                '''Las aventuras a lo largo y ancho de la galaxia de un abuelo con una moral cuestionable y su nieto inseguro hasta rayar en lo crónico han conquistado a millones. Así, la serie se convirtió en una de las consentidas por el público.\n
La trama no solo tiene situaciones inverosímiles, sino que también es un deleite para los amantes de la ciencia ficción y, por si fuera poco, también conjuga lecciones de gran madurez que nos hacen pensar que es una de las mejores series del momento.\n
Una de las características geniales de la ciencia ficción es que nos permite soñar con mundos lejanos, seres extraños e inventos que desearíamos tener a nuestro alcance. Para mejor, las posibilidades son casi infinitas. Si a esto le agregamos el ingenio de Justin Roiland y Dan Harmon, creadores de la serie, el resultado es sorprendente: una producción cargada de humor negro no apta para sensibles, además de ser una de las joyas de la corona de Adult Swim.\n
Las aventuras del alcohólico pero brillante científico Rick Sánchez y su nervioso nieto adolescente, Morty Smith, son una locura de principio a fin y no nos dan respiro, por lo que prometen ser un viaje de emociones de todo tipo.\n
El hilo conductor de la serie, aparte de la relación de Rick y Morty, son las aventuras que tienen en toda la anchura del universo. Se cruzan con seres de todas las formas e inteligencias, además de ir a realidades paralelas que antes nadie ha explorado. En medio de todo, destaca la habilidad de Rick de crear inventos prácticamente de la nada, a la par que Morty parece estar a punto de sufrir un ataque cardíaco… Por supuesto, a este punto ya estamos muriendo de la risa.''', // Descripción detallada sobre la serie
                style: TextStyle(
                  fontSize: 16, // Tamaño de fuente
                  color: const Color.fromARGB(255, 4, 34, 69), // Color azul oscuro para el texto
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


