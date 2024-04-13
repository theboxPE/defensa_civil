import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class VideosPage extends StatefulWidget {
  const VideosPage({super.key});

  @override
  VideosState createState() => VideosState();
}

class VideosState extends State<VideosPage> {
  List<dynamic> _videos = [];

  @override
  void initState() {
    super.initState();
    obtenerVideos();
  }

  Future<void> obtenerVideos() async {
    final url = Uri.parse("https://adamix.net/defensa_civil/def/videos.php");

    try {
      final response = await http.get(url);
      final responseData = json.decode(response.body);

      if (responseData['exito']) {
        setState(() {
          _videos = responseData['datos'];
        });
      } else {
        mostrarError(
            'Hubo un error al obtener los videos. Por favor, inténtalo de nuevo más tarde.');
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
        title: const Text('Videos'),
      ),
      body: _videos.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _videos.length,
              itemBuilder: (context, index) {
                final video = _videos[index];
                return Card(
                  child: ListTile(
                    title: Text(video['titulo']),
                    subtitle: Text(video['descripcion']),
                    trailing: Text(video['fecha']),
                    onTap: () {
                      launchURL(video['link']);
                    },
                  ),
                );
              },
            ),
    );
  }

  launchURL(String link) async {
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      mostrarError('No se puede abrir el enlace');
    }
  }
}
