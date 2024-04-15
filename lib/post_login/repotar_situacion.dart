import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:defensa_civil/token.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  ReportPageState createState() => ReportPageState();
}

class ReportPageState extends State<ReportPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _image;
  late double _latitude;
  late double _longitude;

  Future<void> _getLocation() async {
    LocationData locationData = await Location().getLocation();
    setState(() {
      _latitude = locationData.latitude!;
      _longitude = locationData.longitude!;
    });
  }

  Future<void> _getImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _reportEmergency() async {
    if (!_formKey.currentState!.validate()) {
      return ; // Si el formulario no es válido, no proceder.
    }
    final tokenManager = TokenManager();
    print(tokenManager);
    String? token = tokenManager.token;
    print(token);
    print("correcto en el token");
    if (token == null) {
      print("correcto token");
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('No se ha encontrado un token almacenado.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }
    String? imageBase64;
    if (_image != null) {
      final bytes = await _image!.readAsBytes();
      imageBase64 = base64Encode(bytes);
    }

    final url = Uri.parse("https://adamix.net/defensa_civil/def/nueva_situacion.php");
  print(token);
    final response = await http.post(url, body: {
        'titulo': _titleController.text,
        'descripcion': _descriptionController.text,
        'foto': imageBase64 ?? 'sgsgs', // Envía 'sgsgs' si no hay imagen
        'latitud': _latitude.toString(),
        'longitud': _longitude.toString(),
        'token': token,
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['exito']) {
        print(jsonResponse['mensaje']);
        print("correcto aqui datos");
      } else {
        _showErrorDialog(jsonResponse['mensaje']);
        print("Eror");
      }
    } else {
      _showErrorDialog('Error de conexión. Por favor, inténtalo de nuevo más tarde.');
      print("Error");
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
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
        title: Text('Reportar Situación de Emergencia'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Título'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un título';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Descripción'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa una descripción';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              /*_image == null
                  ? TextButton.icon(
                      onPressed: _getImage,
                      icon: Icon(Icons.camera),
                      label: Text('Tomar Foto'),
                    )
                  : Image.file(_image!),*/
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  await _getLocation();
                  await _reportEmergency();
                },
                child: Text('Enviar Reporte'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
