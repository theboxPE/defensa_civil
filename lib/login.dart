import 'dart:convert';
import 'package:defensa_civil/components/my_button.dart';
import 'package:defensa_civil/components/textfield.dart';
import 'package:defensa_civil/post_login/navbar.dart';
import 'package:defensa_civil/token.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signUserIn() async {
    final cedula = usernameController.text;
    final clave = passwordController.text;

    if (cedula.isEmpty || clave.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Campos requeridos'),
            content: const Text('Por favor, completa todos los campos.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      final url =
          Uri.parse("https://adamix.net/defensa_civil/def/iniciar_sesion.php");

      final response =
          await http.post(url, body: {'cedula': cedula, 'clave': clave});

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['exito']) {
          // Almacena el token utilizando la clase TokenManager
          TokenManager tokenManager = TokenManager();
          final String token = jsonResponse['datos']['token'];
          tokenManager.token = token;

          // Navega a la página de noticias después de iniciar sesión
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const NavbarPost()),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Error de inicio de sesión'),
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),

              // logo
              const Icon(
                Icons.lock,
                size: 100,
              ),

              const SizedBox(height: 30),

              //welcome back, you ve been missed!
              Text(
                'Inicio de Sesion',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                  ),
              ),

              const SizedBox(height: 25),

              // username textfield
              MytextField(
                controller: usernameController,
                hintText: 'Cedula',
                obscureText: false,
              ),

              const SizedBox(height: 10),

              // password textfield
              MytextField(
                controller: passwordController,
                hintText: 'Clave',
                obscureText: true,
              ),

              const SizedBox(height: 30),

              // sign in button
              MyButton(
                onTap: signUserIn,
              ),


              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}