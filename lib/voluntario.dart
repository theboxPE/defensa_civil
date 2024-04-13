import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  RegistroFormState createState() => RegistroFormState();
}

class RegistroFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController cedulaController = TextEditingController();
  TextEditingController nombreController = TextEditingController();
  TextEditingController apellidoController = TextEditingController();
  TextEditingController claveController = TextEditingController();
  TextEditingController correoController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();

  void _registrar() async {
    if (_formKey.currentState!.validate()) {
      final url =
          Uri.parse("https://adamix.net/defensa_civil/def/registro.php");
      final response = await http.post(url, body: {
        'cedula': cedulaController.text,
        'nombre': nombreController.text,
        'apellido': apellidoController.text,
        'clave': claveController.text,
        'correo': correoController.text,
        'telefono': telefonoController.text,
      });

      final responseData = json.decode(response.body);
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de voluntarios'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextFormField(cedulaController, 'Cédula'),
              const SizedBox(height: 20),
              _buildTextFormField(nombreController, 'Nombre'),
              const SizedBox(height: 20),
              _buildTextFormField(apellidoController, 'Apellido'),
              const SizedBox(height: 20),
              _buildTextFormField(claveController, 'Clave', obscureText: true),
              const SizedBox(height: 20),
              _buildTextFormField(correoController, 'Correo'),
              const SizedBox(height: 20),
              _buildTextFormField(telefonoController, 'Teléfono'),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _registrar,
                child: const Text('Registrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(
    TextEditingController controller,
    String labelText, {
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Este campo es requerido';
        }
        return null;
      },
    );
  }
}
