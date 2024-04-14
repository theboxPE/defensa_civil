import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acerca de'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              _DeveloperInfo(
                name: 'Nombre del desarrollador 1',
                email: 'correo1@example.com',
                imageAsset: 'assets/gabriel.jpg',
              ),
              SizedBox(height: 20),
              _DeveloperInfo(
                name: 'Nombre del desarrollador 2',
                email: 'correo2@example.com',
                imageAsset: 'assets/emil.jpg',
              ),
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  SizedBox(height: 20), // Espacio para mover el tercer DeveloperInfo hacia abajo
                  _DeveloperInfo(
                    name: 'Nombre del desarrollador 3',
                    email: 'correo3@example.com',
                    imageAsset: 'assets/gabriel.jpg',
                  ),
                  Spacer(),
                ],
              ),
              SizedBox(height: 20),
              _DeveloperInfo(
                name: 'Nombre del desarrollador 4',
                email: 'correo4@example.com',
                imageAsset: 'assets/edward.jpg',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DeveloperInfo extends StatelessWidget {
  final String name;
  final String email;
  final String imageAsset;

  const _DeveloperInfo({
    required this.name,
    required this.email,
    required this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          imageAsset,
          width: 100,
          height: 100,
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'Correo electrónico: $email',
              style: const TextStyle(fontSize: 16 ),
            ),
          ],
        ),
      ],
    );
  }
}


