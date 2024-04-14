import 'package:defensa_civil/post_login/clave.dart';
import 'package:defensa_civil/post_login/noticias_login.dart';
import 'package:defensa_civil/post_login/repotar_situacion.dart';
import 'package:flutter/material.dart' show AssetImage, BuildContext, CircleAvatar, Colors, Column, Drawer, EdgeInsets, FontWeight, Icon, Icons, ListTile, MaterialPageRoute, Navigator, Padding, SizedBox, StatelessWidget, Text, TextStyle, Widget;


class NavbarPost extends StatelessWidget {
  const NavbarPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/')
            ),
            const Text(
              'nombre usuario',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              'lo que sea',
              style: TextStyle(fontSize: 16, color: Colors.lightBlue),
            ),
            const SizedBox(height: 30.0),
            ListTile(
              leading: const Icon(Icons.newspaper),
              title: const Text('Noticias especificas'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const NoticiaPage(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.report),
              title: const Text('Reportar situacion'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ReportPage(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('Mis situaciones'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const NoticiaPage(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.map),
              title: const Text('Mapa situaciones'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const NoticiaPage(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.password),
              title: const Text('Cambiar contraseña'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const CambiarClaveForm(),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}