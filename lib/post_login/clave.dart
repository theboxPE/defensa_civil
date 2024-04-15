import 'package:defensa_civil/token.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class CambiarClaveForm extends StatefulWidget {
  const CambiarClaveForm({super.key});

  @override
  CambiarClaveFormState createState() => CambiarClaveFormState();
}

class CambiarClaveFormState extends State<CambiarClaveForm> {
  TextEditingController claveAnteriorController = TextEditingController();
  TextEditingController claveNuevaController = TextEditingController();
  TextEditingController confirmarClaveController = TextEditingController();
  
  void _cambiarClave() async {
    String claveAnterior = claveAnteriorController.text;
    String claveNueva = claveNuevaController.text;
    String confirmarClave = confirmarClaveController.text;

    if (claveNueva != confirmarClave) {
      Fluttertoast.showToast(
        msg: 'Las nuevas claves no coinciden',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    } 

    // Obtener el token almacenado utilizando la instancia de TokenManager
    final tokenManager = TokenManager();
    String? token = tokenManager.token;

    if (token == null) {
      print('Token no encontrado en el almacenamiento local');
      return;
    }

    final url =
        Uri.parse("https://adamix.net/defensa_civil/def/cambiar_clave.php");
    final response = await http.post(url, body: {
      'token': token,
      'clave_anterior': claveAnterior,
      'clave_nueva': claveNueva,
    });

    final responseData = json.decode(response.body);
    print(responseData); // Imprimir la respuesta en la consola

    if (responseData['exito']) {
      Fluttertoast.showToast(
        msg: responseData['mensaje'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    } else {
      Fluttertoast.showToast(
        msg: responseData['mensaje'],
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
        title: const Text('Cambiar Clave'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: claveAnteriorController,
              decoration: const InputDecoration(labelText: 'Clave Anterior'),
              obscureText: true,
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: claveNuevaController,
              decoration: const InputDecoration(labelText: 'Nueva Clave'),
              obscureText: true,
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: confirmarClaveController,
              decoration: const InputDecoration(labelText: 'Confirmar Nueva Clave'),
              obscureText: true,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _cambiarClave,
              child: const Text('Cambiar Clave'),
            ),
          ],
        ),
      ),
    );
  }
}
