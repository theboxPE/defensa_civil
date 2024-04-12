import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MedidasPreventivasPage extends StatefulWidget {
  @override
  _MedidasPreventivasPageState createState() => _MedidasPreventivasPageState();
}

class _MedidasPreventivasPageState extends State<MedidasPreventivasPage> {
    List<dynamic> _medidasP = [];

  @override
  void initState() {
    super.initState();
    obtenerMedidasP();
  }

 Future<void> obtenerMedidasP() async {
    final url = Uri.parse("https://adamix.net/defensa_civil/def/medidas_preventivas.php");

    try {
      final response = await http.get(url);
      final responseData = json.decode(response.body);

      if (responseData['exito']) {
        setState(() {
          _medidasP = responseData['datos'];
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
      title: const Text('Medidas Preventivas'),
    ),
    body: ListView.builder(
      itemCount: _medidasP.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(_medidasP[index]['titulo']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_medidasP[index]['descripcion']),
                SizedBox(height: 8), // Espacio entre el texto y la imagen
                Container(
                  width: double.infinity, // Ancho de la imagen igual al ancho del ListTile
                  height: 200, // Alto deseado para la imagen
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      _medidasP[index]['foto'],
                      fit: BoxFit.cover,
                    ),
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