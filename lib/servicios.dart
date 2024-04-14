import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Servicio {
  final String id;
  final String nombre;
  final String descripcion;
  final String foto;

  Servicio({required this.id, required this.nombre, required this.descripcion, required this.foto});

  factory Servicio.fromJson(Map<String, dynamic> json) {
    return Servicio(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      foto: json['foto'],
    );
  }
}

class ServiciosPage extends StatefulWidget {
  const ServiciosPage({super.key});

  @override
  ServiciosPageState createState() => ServiciosPageState();
}

class ServiciosPageState extends State<ServiciosPage> {
  List<Servicio> _servicios = [];

  @override
  void initState() {
    super.initState();
    obtenerServicios();
  }

  Future<void> obtenerServicios() async {
    final url = Uri.parse("https://adamix.net/defensa_civil/def/servicios.php");

    try {
      final response = await http.get(url);
      final responseData = json.decode(response.body);

      if (responseData['exito']) {
        setState(() {
          _servicios = (responseData['datos'] as List)
              .map((servicio) => Servicio.fromJson(servicio))
              .toList();
        });
      } else {
        mostrarError(
            'Hubo un error al obtener los servicios. Por favor, inténtalo de nuevo más tarde.');
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
        title: const Text('Servicios'),
      ),
      body: ListView.builder(
        itemCount: _servicios.length,
        itemBuilder: (context, index) {
          final servicio = _servicios[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(servicio.foto),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      servicio.nombre,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(servicio.descripcion),
                  ],
                ),
              ),
              Divider(),
            ],
          );
        },
      ),
    );
  }
}
