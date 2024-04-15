import 'package:defensa_civil/home.dart';
import 'package:flutter/material.dart';
import 'package:defensa_civil/navbar.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: const Navbar(),
        appBar: AppBar(
          title: const Text('Defensa Civil'),
        ),
        body: HomePage(), // Reemplazar el widget Center por la página HomePage
      ),
    );
  }
}
