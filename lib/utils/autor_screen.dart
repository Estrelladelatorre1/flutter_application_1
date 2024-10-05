import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AutorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Autor',
          style: TextStyle(
            fontFamily: 'Pacifico', 
            fontSize: 24,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 110, 70, 10), 
      ),
      body: Container(
        color: Color.fromARGB(255, 231, 224, 146), 
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              leading: Icon(
                Icons.person,
                color: Color(0xFFFFEB3B), 
              ),
              title: Text(
                'Nombre',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF3E2723), 
                ),
              ),
              subtitle: Text(
                'Ivón Estrella De La Torre Rivera',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF3E2723), 
                ),
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.school,
                color: Color(0xFFFFEB3B), 
              ),
              title: Text(
                'Carrera',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF3E2723), 
                ),
              ),
              subtitle: Text(
                'Ingeniería en Sistemas Computacionales',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF3E2723), 
                ),
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.grade,
                color: Color(0xFFFFEB3B), 
              ),
              title: Text(
                'Nivel',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF3E2723),
                ),
              ),
              subtitle: Text(
                'Noveno Semestre',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF3E2723),
                ),
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.email,
                color: Color(0xFFFFEB3B),
              ),
              title: Text(
                'Correo',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF3E2723),
                ),
              ),
              subtitle: Text(
                'estrelladelatorre.123@gmail.com',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF3E2723), 
                ),
              ),
            ),
            Divider(),
            ListTile(
              leading: FaIcon(
                FontAwesomeIcons.github,
                color: Color(0xFFFFEB3B), 
              ),
              title: Text(
                'Github',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF3E2723), 
                ),
              ),
              subtitle: Text(
                'https://github.com/Estrelladelatorre1',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF3E2723), 
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
