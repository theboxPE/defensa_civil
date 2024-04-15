import 'package:defensa_civil/albergues.dart';
import 'package:defensa_civil/login/login.dart';
import 'package:defensa_civil/mapa_albergues.dart';
import 'package:defensa_civil/miembros.dart';
import 'package:defensa_civil/medidas_preventivas.dart';
import 'package:defensa_civil/noticias.dart';
import 'package:defensa_civil/servicios.dart';
import 'package:defensa_civil/acerca_de.dart';
import 'package:defensa_civil/videos.dart';
import 'package:defensa_civil/historia.dart';
import 'package:defensa_civil/voluntario.dart';
import 'package:flutter/material.dart' show BuildContext, Colors, Column, Divider, Drawer, EdgeInsets, Icon, Icons, ListTile, MaterialPageRoute, Navigator, Padding, StatelessWidget, Text, Widget;


class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.description),
              title: const Text('Historia'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const Historia(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Servicios'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ServiciosPage(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.newspaper),
              title: const Text('Noticias'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const NoticiasPage(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.video_library),
              title: const Text('Videos'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const VideosPage(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.holiday_village),
              title: const Text('Albergues'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AlberguesPage(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.map),
              title: const Text('Mapa Albergues'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MapaPage(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.warning),
              title: const Text('Medidas Preventivas'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MedidasPreventivasPage(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.group),
              title: const Text('Miembros'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MiembrosPage(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Registrarse'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const RegisterForm(),
                ));
              },
            ),
            const Divider(color: Colors.black54),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Acerca De'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AboutPage(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('Iniciar Sesión'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}