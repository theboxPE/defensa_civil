// Importaciones de paquetes
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

// Modelo de datos para una noticia
class Noticia {
  final int id;
  final String fecha;
  final String titulo;
  final String contenido;
  final String foto;

  Noticia({
    required this.id,
    required this.titulo,
    required this.fecha,
    required this.contenido,
    required this.foto,
  });

  factory Noticia.fromJson(Map<String, dynamic> json) => Noticia(
    id: json['id'],
    fecha: json['fecha'],
    titulo: json['titulo'],
    contenido: json['contenido'],
    foto: json['foto'],
  );
}

// Función para obtener la lista de noticias
Future<Noticia> obtenerNoticias() async {
  final uri = Uri.parse('https://adamix.net/defensa_civil/def/noticias.php');
  final response = await http.get(uri);


  if (response.statusCode == 200) {
    return Noticia.fromJson(json.decode(response.body));
  } else {
    throw Exception('Error al obtener las noticias');
  }
}

// Función para obtener una noticia en detalle (por ID)
Future<Noticia> createNoticia(String fecha, String titulo, String contenido, String foto) async {
  Map<String, dynamic> request = {
    'id': '1',
    'fecha': fecha,
    'titulo': titulo,
    'contenido': contenido,
    'foto': foto,
  };
  final uri = Uri.parse('https://adamix.net/defensa_civil/def/noticias.php?');
  final response = await http.post(uri, body: request);

  if (response.statusCode == 201) {
    return Noticia.fromJson(json.decode(response.body));
  } else {
    throw Exception('Error al obtener la noticia');
  }
}
