import 'dart:convert';
import 'package:defensa_civil/components/my_button.dart';
import 'package:defensa_civil/components/textfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatelessWidget {
  LoginPage({super.key});


  //text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method
  void signUserIn() async {
    String cedula = usernameController.text;
    String clave = passwordController.text;

    if(cedula.isEmpty || clave.isEmpty) {
        Fluttertoast.showToast(
        msg: 'Todos los campos son requeridos',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white
      );

    } else {
      final uri = Uri.parse('https://adamix.net/defensa_civil/def/iniciar_sesion.php');
      final response = await http.post(uri, body: {
        'cedula': cedula,
        'clave': clave,
      });

      final responseData = json.decode(response.body);

      if(responseData['exito']) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        await pref.setString('defensaUser', json.encode(responseData['usuario']));

        Navigator.pushReplacementNamed(context, '/noticias');

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

              const SizedBox(height: 50),

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
                obscureText: true,
              ),

              const SizedBox(height: 10),

              // password textfield
              MytextField(
                controller: passwordController,
                hintText: 'Clave',
                obscureText: false,
              ),

              const SizedBox(height: 10),


              // forgot password?
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // sign in button
              MyButton(
                onTap: signUserIn,
              ),


              const SizedBox(height: 50),


              // or continue with 
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),


              const SizedBox(height: 50),

              //not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No esta Registrado?',
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Registrar ahora',
                    style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

          
            ],
          ),
        ),
      ),
    );
  }
}