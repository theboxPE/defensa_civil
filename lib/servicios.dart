import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Modelo de datos para representar un post
class Post {
  final String nombre;
  final String descripcion;
  final String foto;

  Post({required this.nombre, required this.descripcion, required this.foto});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      foto: json['foto'],
    );
  }
}

// Función para obtener un post de la API
Future<Post> fetchPost() async {
  final uri = Uri.parse('https://adamix.net/defensa_civil/def/servicios.php');
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    return Post.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load post');
  }
}

// Función para crear un nuevo post en la API
Future<Post> createPost(String title, String body) async {
  Map<String, dynamic> request = {
    'nombre': title,
    'descripcion': body,
    'foto': '',
  };
  final uri = Uri.parse('https://adamix.net/defensa_civil/def/servicios.php');
  final response = await http.post(uri, body: request);

  if (response.statusCode == 201) {
    return Post.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to create post');
  }
}

// Ejemplo de vista de Flutter
class Servicios extends StatefulWidget {
  const Servicios({super.key});

  @override
  ServiciosState createState() => ServiciosState();
}

class ServiciosState extends State<Servicios> {
  late Future<Post> _futurePost;

  @override
  void initState() {
    super.initState();
    _futurePost = fetchPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Servicios'),
      ),
      body: FutureBuilder<Post>(
        future: _futurePost,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            final post = snapshot.data!;
            return ListTile(
              title: Text(post.nombre),
              subtitle: Text(post.descripcion),
              leading: post.foto.isNotEmpty
                  ? Image.network(post.foto)
                  : const Icon(Icons.image_not_supported),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return const Center(child: Text('No se encontraron datos'));
          }
        },
      ),
    );
  }
}


