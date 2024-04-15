import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class MapaPage extends StatefulWidget {
  const MapaPage({super.key});

  @override
  MiembrosState createState() => MiembrosState();
}

class MiembrosState extends State<MapaPage> {
  List<dynamic> _mapa = [];

  @override
  void initState() {
    super.initState();
    obtenerMapa();
  }

  Future<void> obtenerMapa() async {
    final url = Uri.parse("https://adamix.net/defensa_civil/def/albergues.php");

    try {
      final response = await http.get(url);
      final responseData = json.decode(response.body);

      if (responseData['exito']) {
        setState(() {
          _mapa = responseData['datos'];
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
        title: const Text(
          'Mapa de Albergues',
          style: TextStyle(color: Colors.white),
          title: Text(
          'Mapa - ${_mapa[index]['']} ${_mapa[index]['']}',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body:FlutterMap(
        options: MapOptions(
                center: LatLng(_mapa[0]['lat'], _mapa[0]['lng']),
                zoom: 10.
          initialCenter: LatLng(),
          initialZoom: 15.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: _mapa.map((albergue) =>
              Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(albergue['lat'], albergue['lng']),
              markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(
                            'Información del Marcador',
                            style: TextStyle(color: Colors.blueAccent),
                          ),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Ciudad: ${albergue['ciudad']}',
                                style: const TextStyle(color: Colors.black),
                              ),
                              Text(
                                'Latitud: ${albergue['lat']}',
                                style: const TextStyle(color: Colors.black),
                              ),
                              Text(
                                'Longitud: ${albergue['lng']}',
                                'Nombre: ${} ${}',
                                style: const TextStyle(color: Colors.black),
                              ),
                              Text(
                                'Ciudad: ${}',
                                style: const TextStyle(color: Colors.black),
                              ),
                              Text(
                                'Latitud: ${}',
                                style: const TextStyle(color: Colors.black),
                              ),
                              Text(
                                'Longitud: ${}',
                                style: const TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'Cerrar',
                                style: TextStyle(color: Colors.redAccent),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Icon(
                    Icons.person_pin,
                    color: Colors.redAccent,
                    size: 40,
                  ),
                ),
              ),
            ).toList(),
            ],
          ),
        ],
      ),
    );
  }
}
