import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NoticiasPage extends StatefulWidget {
  const NoticiasPage({super.key});

  @override
  NoticiasPageState createState() => NoticiasPageState();
}

class NoticiasPageState extends State<NoticiasPage> {
  List<dynamic> _noticias = [];

  @override
  void initState() {
    super.initState();
    obtenerNoticias();
  }

  Future<void> obtenerNoticias() async {
    final url = Uri.parse("https://adamix.net/defensa_civil/def/noticias.php");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData != null && responseData['exito']) {
          setState(() {
            _noticias = responseData['datos'];
          });
        } else {
          mostrarError(
            'No se recibieron datos válidos de la API. Por favor, inténtalo de nuevo más tarde.');
        }
      } else {
        mostrarError(
          'Error en la solicitud. Código de estado: ${response.statusCode}');
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
        title: const Text('Noticias'),
      ),
      body: _noticias.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _noticias.length,
              itemBuilder: (context, index) {
                final noticia = _noticias[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10),
                      title: Text(
                        noticia['titulo'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            noticia['contenido'],
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Fecha: ${noticia['fecha']}',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          noticia['foto'],
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
