import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acerca de'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Desarrolladores de Software:',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            SizedBox(height: 10.0),
            Text(
              'Gabriel Perez - 2022-0332\nEmil Feliz - 2021-0319\nJose Perez - 2021-0031\nEdward Frias - 2021-1447',
              style: TextStyle(fontSize: 16.0, color: Colors.black87),
            ),
            SizedBox(height: 20.0),
            Text(
              'La Defensa Civil de la República Dominicana es una organización encargada de prevenir y mitigar los efectos de desastres naturales en el país. Su objetivo principal es asegurar que los preparativos sean adecuados para enfrentar situaciones causadas por inundaciones, terremotos, tormentas, huracanes, incendios, escasez o distribución deficiente de suministros, y otros eventos similares. Además, busca mantener el orden, la salud y el bienestar económico, así como la seguridad pública y la protección de la vida y la propiedad en tales circunstancias.',
              style: TextStyle(fontSize: 16.0, color: Colors.black87),
            ),
            SizedBox(height: 20.0),
            Text(
              'A favor de la gente y para la gente.',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}