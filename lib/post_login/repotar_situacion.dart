import 'dart:convert';
import 'dart:io';
import 'package:defensa_civil/token.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';



class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _image;
  late double _latitude;
  late double _longitude;
  TokenManager tokenManager = TokenManager();

  Future<void> _getLocation() async {
    LocationData locationData = await Location().getLocation();
    setState(() {
      _latitude = locationData.latitude!;
      _longitude = locationData.longitude!;
    });
  }

  Future<void> _getImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _reportEmergency() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    // Envía los datos a la API
    final url = 'https://adamix.net/defensa_civil/def/nueva_situacion.php';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'titulo': _titleController.text,
        'descripcion': _descriptionController.text,
        'foto': base64Encode(_image!.readAsBytesSync()),
        'latitud': _latitude,
        'longitud': _longitude,
        'token': // Asegúrate de reemplazar 'TU_TOKEN' con el token real
      }),
    );
    print(response.body);
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
              _image == null
                  ? TextButton.icon(
                      onPressed: _getImage,
                      icon: Icon(Icons.camera),
                      label: Text('Tomar Foto'),
                    )
                  : Image.file(_image!),
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
