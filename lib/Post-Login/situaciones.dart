import 'package:flutter/material.dart';
import 'package:defensa_civil/token.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SituacionesPage extends StatefulWidget {
  const SituacionesPage({super.key});

  @override
  SituacionesPageState createState() => SituacionesPageState();
}

class SituacionesPageState extends State<SituacionesPage> {
  List<dynamic> _situaciones = [];

  @override
  void initState() {
    super.initState();
    _loadSituaciones();
  }

  Future<void> _loadSituaciones() async {
    final tokenManager = TokenManager();
    String? token = tokenManager.token;

    if (token != null) {
      final url = Uri.parse("https://adamix.net/defensa_civil/def/situaciones.php");
      final response = await http.post(url, body: {'token': token});

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['exito']) {
          setState(() {
            _situaciones = jsonResponse['datos'];
          });
        } else {
          _showErrorDialog(jsonResponse['mensaje']);
        }
      } else {
        _showErrorDialog('Error de conexión. Por favor, inténtalo de nuevo más tarde.');
      }
    } else {
      _showErrorDialog('No se ha encontrado un token almacenado.');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Situaciones de Emergencia'),
      ),
      body: ListView.builder(
        itemCount: _situaciones.length,
        itemBuilder: (context, index) {
          var situacion = _situaciones[index];
          return Card(
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetalleSituacionPage(situacion: situacion),
                  ),
                );
              },
              leading: situacion['foto'] != null
                ? Image.network(situacion['foto'], width: 50, height: 50, fit: BoxFit.cover)
                : const Icon(Icons.image_not_supported),
              title: Text(situacion['titulo'] ?? 'Sin título'),
              subtitle: Text('Reportado el ${situacion['fecha']}'),
              trailing: Text(situacion['estado']),
            ),
          );
        },
      ),
    );
  }
}

class DetalleSituacionPage extends StatelessWidget {
  final Map<dynamic, dynamic> situacion;

  const DetalleSituacionPage({Key? key, required this.situacion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(situacion['titulo']),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Código de Reporte: ${situacion['codigo']}'),
            Text('Fecha: ${situacion['fecha']}'),
            Text('Descripción: ${situacion['descripcion']}'),
            situacion['foto'] != null
              ? Image.network(situacion['foto'])
              : const Text('No hay imagen disponible'),
            Text('Estado: ${situacion['estado']}'),
            Text('Comentarios: ${situacion['comentarios'] ?? "No hay comentarios"}'),
          ],
        ),
      ),
    );
  }
}