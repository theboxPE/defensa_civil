import 'package:defensa_civil/main.dart';
import 'package:defensa_civil/noticias.dart';
import 'package:defensa_civil/servicios.dart';
import 'package:flutter/material.dart' show AssetImage, BuildContext, CircleAvatar, Colors, Column, Divider, Drawer, EdgeInsets, FontWeight, Icon, Icons, ListTile, MaterialPageRoute, Navigator, Padding, SizedBox, StatelessWidget, Text, TextStyle, Widget;


class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/fp.jpg') //foto para un usuario o lo que sea mas bonito
            ),
            const Text(
              'nombre usuario', //nombre de usuario si asi lo prefieren
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              'mensaje cualquiera', //se puede poner un mensaje cualquiera para este campo
              style: TextStyle(fontSize: 16, color: Colors.lightBlue),
            ),
            const SizedBox(height: 30.0),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MyApp(), 
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.description),
              title: const Text('Historia'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MyApp(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Servicios'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MyApp(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.newspaper),
              title: const Text('Noticias'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MyApp(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.video_library),
              title: const Text('Videos'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MyApp(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.holiday_village),
              title: const Text('Albergues'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MyApp(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.map),
              title: const Text('Mapa Albergues'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MyApp(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.warning),
              title: const Text('Medidas Preventivas'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MyApp(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.group),
              title: const Text('Miembros'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MyApp(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Quiero ser Voluntario'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MyApp(),
                ));
              },
            ),
            const Divider(color: Colors.black54),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Acerca De'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MyApp(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('Iniciar Sesión'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MyApp(),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}