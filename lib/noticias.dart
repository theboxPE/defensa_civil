import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoticiaPage extends StatefulWidget {
  const NoticiaPage({super.key});

  @override
  NoticiaPageState createState() => NoticiaPageState();
}

class NoticiaPageState extends State<NoticiaPage> {
  List<dynamic> noticias = [];
  String nombreUsuario = '';

  @override
  void initState() {
    super.initState();
    cargarUsuario();
    cargarNoticias();
  }

  Future<void> cargarUsuario() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? usuarioGuardado = prefs.getString('defensaUser');
    if (usuarioGuardado != null) {
      setState(() {
        nombreUsuario = json.decode(usuarioGuardado)['nombre'];
      });
    }
  }

  Future<void> cargarNoticias() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? usuarioGuardado = prefs.getString('defensaUser');
    if (usuarioGuardado == null) {
      // Si no hay un usuario registrado, redirigir a la página de inicio de sesión
      Navigator.pushReplacementNamed(context, '/login');
      return;
    }

    String token = json.decode(usuarioGuardado)['token'];

    final url = Uri.parse("https://adamix.net/defensa_civil/def/noticias_especificas.php");
    final response = await http.post(url, body: {'token': token});

    final responseData = json.decode(response.body);
    if (responseData['exito']) {
      setState(() {
        noticias = responseData['datos'];
      });
    } else {
      Fluttertoast.showToast(
        msg: 'Error al cargar las noticias: ${responseData['mensaje']}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Noticias'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Bienvenido $nombreUsuario a la Defensa Civil',
              style: const TextStyle(fontSize: 24.0),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: noticias.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  margin: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(noticias[index]['foto']),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              noticias[index]['titulo'],
                              style: const TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10.0),
                            Text(noticias[index]['contenido']),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
