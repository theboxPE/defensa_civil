import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Albergue {
  final String ciudad;
  final String codigo;
  final String edificio;
  final String coordinador;
  final String telefono;
  final String capacidad;
  final double lat;
  final double lng;

  Albergue({
    required this.ciudad,
    required this.codigo,
    required this.edificio,
    required this.coordinador,
    required this.telefono,
    required this.capacidad,
    required this.lat,
    required this.lng,
  });

  factory Albergue.fromJson(Map<String, dynamic> json) {
    return Albergue(
      ciudad: json['ciudad'],
      codigo: json['codigo'],
      edificio: json['edificio'],
      coordinador: json['coordinador'],
      telefono: json['telefono'],
      capacidad: json['capacidad'],
      lat: double.parse(json['lat']),
      lng: double.parse(json['lng']),
    );
  }
}

class AlberguesPage extends StatefulWidget {
  const AlberguesPage({Key? key}) : super(key: key);

  @override
  _AlberguesPageState createState() => _AlberguesPageState();
}

class _AlberguesPageState extends State<AlberguesPage> {
  List<Albergue> _albergues = [];
  List<Albergue> _alberguesFiltrados = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    obtenerAlbergues();
    _searchController.addListener(() {
      filtrarAlbergues();
    });
  }

  Future<void> obtenerAlbergues() async {
    final url = Uri.parse("https://adamix.net/defensa_civil/def/albergues.php");

    try {
      final response = await http.get(url);
      final responseData = json.decode(response.body);

      if (responseData['exito']) {
        setState(() {
          _albergues = (responseData['datos'] as List)
              .map((data) => Albergue.fromJson(data))
              .toList();
          _alberguesFiltrados = List.from(_albergues);
        });
      } else {
        mostrarError(
            'Hubo un error al obtener los albergues. Por favor, inténtalo de nuevo más tarde.');
      }
    } catch (error) {
      mostrarError(
          'Hubo un error al realizar la solicitud. Por favor, inténtalo de nuevo más tarde.');
    }
  }

  void filtrarAlbergues() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _alberguesFiltrados = _albergues.where((albergue) {
        final ciudadLower = albergue.ciudad.toLowerCase();
        final edificioLower = albergue.edificio.toLowerCase();
        return ciudadLower.contains(query) || edificioLower.contains(query);
      }).toList();
    });
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
        title: const Text('Albergues'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Buscar albergues por ciudad o edificio',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _alberguesFiltrados.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(_alberguesFiltrados[index].edificio),
                    subtitle: Text(_alberguesFiltrados[index].ciudad),
                    onTap: () {
                      // Implement onTap functionality if needed
                       mostrarDetallesAlbergue(_alberguesFiltrados[index]);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void mostrarDetallesAlbergue(Albergue albergue) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(albergue.edificio),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Ciudad: ${albergue.ciudad}'),
            Text('Código: ${albergue.codigo}'),
            Text('Coordinador: ${albergue.coordinador}'),
            Text('Teléfono: ${albergue.telefono}'),
            Text('Capacidad: ${albergue.capacidad}'),
            Text('Latitud: ${albergue.lat}'),
            Text('Longitud: ${albergue.lng}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

