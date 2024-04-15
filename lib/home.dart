import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<Map<String, dynamic>> imagesData = [
    {
      'imageUrl': 'https://z101digital.com/wp-content/uploads/2024/01/defensa-civil.jpeg',
      'text': 'Defensa Civil afirma cuida vidas de quienes asisten a Basílica de Higüey este feriado.',
    },
    {
      'imageUrl':   'https://diarioeco.com.do/wp-content/uploads/2024/03/H-1.-26032024-Mas-de-8-mil-voluntarios-de-la-Defensa-Civil-daran-asistencia-durante-la-Senana-Santa-scaled.jpg',
      'text': '8mil voluntarios darán asistencia en la Semana Santa.',
    },
    {
      'imageUrl':  'https://i0.wp.com/grupocasalima.com/wp-content/uploads/defensa-civil-en-rescate.jpg?fit=1000%2C706&ssl=1',
      'text': 'Los rescatadores de la defensa civil para busqueda de sobrevivientes bajo los escombros en Puerto Principe tras el terremoto de Haiti.',
    },
    {
      'imageUrl':  'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi2MAhDY-gMpN1_biFKMf4kqF4ladDA2YqcRTXz_Ke6hKhvWTdA3qktm0NmLcOfO2mZFTLw2cPc0wgy79-smO6mI8DrNlt2824or-KkrIW8Kz4T_J9yTfnwSwChOSO4cK9Q6IiDnaV_RsyJ/s1600/DSC04957.JPG',
      'text': 'Accion social de ayuda con prendas de vestir.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Algunas de las causas llevadas a cabo por la Defensa Civil:',
              style: TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: PageView.builder(
                itemCount: imagesData.length,
                controller: PageController(viewportFraction: 0.8),
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return _buildImageSlider(index);
                },
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              imagesData[_currentIndex]['text'],
              style: const TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSlider(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.network(
          imagesData[index]['imageUrl'],
          width: 200.0,
          height: 200.0,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}