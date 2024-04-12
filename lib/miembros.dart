import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MiembrosPage extends StatefulWidget {
  @override
  _MiembrosPageState createState() => _MiembrosPageState();
}

class _MiembrosPageState extends State<MiembrosPage> {
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
        title: Text('Error'),
        content: Text(mensaje),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Miembros'),
      ),
      body: ListView.builder(
        itemCount: _miembros.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(_miembros[index]['foto']),
              ),
              title: Text(_miembros[index]['nombre']),
              subtitle: Text(_miembros[index]['cargo']),
            ),
          );
        },
      ),
    );
  }
}
