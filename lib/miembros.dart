import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MiembrosPage extends StatefulWidget {
  const MiembrosPage({super.key});

  @override
  MiembrosState createState() => MiembrosState();
}

class MiembrosState extends State<MiembrosPage> {
  List<dynamic> _miembros = [];

  @override
  void initState() {
    super.initState();
    obtenerMiembros();
  }

  Future<void> obtenerMiembros() async {
    final url = Uri.parse("https://adamix.net/defensa_civil/def/miembros.php");

    try {
      final response = await http.get(url);
      final responseData = json.decode(response.body);

      if (responseData['exito']) {
        setState(() {
          _miembros = responseData['datos'];
        });
      } else {
        mostrarError(
            'Hubo un error al obtener los miembros. Por favor, inténtalo de nuevo más tarde.');
      }
    } catch (error) {
      mostrarError(
          'Hubo un error al realizar la solicitud. Por favor, inténtalo de nuevo más tarde.');
    }
  }

  void mostrarError(String mensaje) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(mensaje),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Miembros'),
    ),
    body: ListView.builder(
      itemCount: _miembros.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Colocar la imagen del miembro
                Container(
                  width: MediaQuery.of(context).size.width, // Ancho de la imagen
                  height: 200, // Alto de la imagen
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(_miembros[index]['foto']), // URL de la imagen
                    ),
                  ),
                ),
                SizedBox(height: 10),
                // Mostrar el nombre como título
                Text(
                  _miembros[index]['nombre'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Mostrar el cargo como subtítulo
                Text(
                  _miembros[index]['cargo'],
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

}



