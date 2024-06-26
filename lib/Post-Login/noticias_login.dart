import 'package:flutter/material.dart';
import 'package:defensa_civil/token.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NoticiaPage extends StatefulWidget {
  const NoticiaPage({super.key});

  @override
  NoticiasPageState createState() => NoticiasPageState();
}

class NoticiasPageState extends State<NoticiaPage> {
  List<dynamic> _noticias = []; // Lista para almacenar las noticias

  @override
  void initState() {
    super.initState();
    _loadNoticias();
  }

  Future<void> _loadNoticias() async {
    // Obtener el token almacenado utilizando la instancia de TokenManager
    final tokenManager = TokenManager();
    String? token = tokenManager.token;

    if (token != null) {
      final url = Uri.parse(
          "https://adamix.net/defensa_civil/def/noticias_especificas.php");

      final response = await http.post(url, body: {'token': token});
  

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['exito']) {
          setState(() {
            print(jsonResponse);
            _noticias = jsonResponse['datos'];
            print(_noticias);
          });
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Error al cargar las noticias'),
                content: Text(jsonResponse['mensaje']),
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
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text(
                  'Error de conexión. Por favor, inténtalo de nuevo más tarde.'),
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
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('No se ha encontrado un token almacenado.'),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Noticias'),
      ),
      body: ListView.builder(
        itemCount: _noticias.length,
        itemBuilder: (context, index) {
          final noticia = _noticias[index];
          return ListTile(
            title: Text(noticia['titulo']),
            subtitle: Text(noticia['contenido']),
            // Agrega más detalles de la noticia si es necesario
          );
        },
      ),
    );
  }
}