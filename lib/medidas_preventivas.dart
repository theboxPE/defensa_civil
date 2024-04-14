import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MedidasPreventivasPage extends StatefulWidget {
  const MedidasPreventivasPage({super.key});

  @override
  MedidasPreventivasPageState createState() => MedidasPreventivasPageState();
}

class MedidasPreventivasPageState extends State<MedidasPreventivasPage> {
  List<dynamic> _medidasP = [];

  @override
  void initState() {
    super.initState();
    obtenerMedidasP();
  }

  Future<void> obtenerMedidasP() async {
    final url = Uri.parse("https://adamix.net/defensa_civil/def/medidas_preventivas.php");

    try {
      final response = await http.get(url);
      final responseData = json.decode(response.body);

      if (responseData['exito']) {
        setState(() {
          _medidasP = responseData['datos'];
        });
      } else {
        mostrarError(
            context,
            'Hubo un error al obtener las medidas preventivas. Por favor, inténtalo de nuevo más tarde.',
          );
      }
    } catch (error) {
      mostrarError(
          context,
          'Hubo un error al realizar la solicitud. Por favor, inténtalo de nuevo más tarde.',
        );
    }
  }

  void mostrarError(BuildContext context, String mensaje) {
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
        title: const Text('Medidas Preventivas'),
      ),
      body: ListView.builder(
        itemCount: _medidasP.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(_medidasP[index]['titulo']),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: [
                        const TextSpan(
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: _medidasP[index]['descripcion']),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8), 
                  SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/placeholder_image.jpg', 
                        image: _medidasP[index]['foto'], 
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
