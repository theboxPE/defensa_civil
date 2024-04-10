// Importaciones de paquetes
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

// Modelo de datos para una noticia
class Service {
  final int id;
  final String name;
  final String description;
  final String foto;

  Service({
    required this.id,
    required this.name,
    required this.description,
    required this.foto,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
   id: json['id'],
   name: json['nombre'],
   description: json['descripcion'],
   foto: json['foto']
  );
}

// Función para obtener la lista de noticias
Future<Service> obtenerServicio() async {
  final uri = Uri.parse('https://adamix.net/defensa_civil/def/servicios.php');
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    return Service.fromJson(json.decode(response.body));
  } else {
    throw Exception('Error al obtener las noticias');
  }
}

// Función para obtener una noticia en detalle (por ID)
Future<Service> createService(String name, String description, String foto) async {
  Map<String, dynamic> request = {
    'id': '1',
    'name': name,
    'descripcion': description,
    'foto': foto,

  };

  final uri = Uri.parse('https://adamix.net/defensa_civil/def/servicios.php');
  final response = await http.post(uri, body: request);

  if (response.statusCode == 201) {
    return Service.fromJson(json.decode(response.body));
  } else {
    throw Exception('Error al obtener la noticia');
  }
}

