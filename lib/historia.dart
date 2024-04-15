import 'package:flutter/material.dart';

class Historia extends StatelessWidget {
  const Historia({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historia'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/defensa.png', 
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            const Text(
              'Antes del año 1966, cuando llegaba la temporada de huracanes, un grupo de radioaficionados se reunía en la Cruz Roja para estar atentos por si surgía algún tipo de emergencia, inmediatamente ponerse a disposición y ayudar en todo lo posible, inclusive, usando sus propios equipos de comunicación para así tener contacto con el exterior en caso de que las redes telefónicas resultaran afectadas.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Al surgir el triunvirato fue designado el Dr. Rafael Cantizano Arias, como presidente de la Cruz Roja y al mismo tiempo nombraron al Ing. Carlos D´ Franco como director de la Defensa Civil, quien con un grupo compuesto por seis personas, se instaló en la calle Francia esquina Galván, siendo esa la primera oficina de la Defensa Civil.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Al surgir el Gobierno Provisional, presidido por el Dr. Héctor García Godoy, a los diecisiete días del mes de junio de 1966, fue promulgada la Ley 257, mediante la cual fue creada la Defensa Civil, institución dependiente de la Secretaría Administrativa de la Presidencia (ahora Ministerio de la Presidencia) y quien en la actualidad preside la Comisión Nacional de Emergencias.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Más adelante, el local fue trasladado a la calle Dr. Delgado No. 164 y luego en la gestión del Contralmirante Radhamés Lora Salcedo se reubicó a la Plaza de la Salud, donde aún permanece.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Lista de ex-directores de la Defensa Civil',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Director', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Inicio de gestión', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Fin de gestión', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                  ],
                  rows: const [
                    DataRow(cells: [
                      DataCell(Text('Ing. Carlos D´ Franco')),
                      DataCell(Text('17-07-1966')),
                      DataCell(Text('11-06-1971')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Dr. Mariano Ariza Hernández')),
                      DataCell(Text('11-06-1971')),
                      DataCell(Text('26-08-1974')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Dr. Pedro Justiniano Polanco')),
                      DataCell(Text('26-08-1974')),
                      DataCell(Text('15-01-1982')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Dr. Domingo Porfirio Rojas')),
                      DataCell(Text('15-01-1982')),
                      DataCell(Text('16-01-1985')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Lic. Alfonso Julia Mera')),
                      DataCell(Text('16-01-1985')),
                      DataCell(Text('28-08-1986')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Dr. Eugenio Cabral Martínez')),
                      DataCell(Text('28-08-1986')),
                      DataCell(Text('01-09-1998')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Lic. Manuel Elpidio Báez')),
                      DataCell(Text('01-09-1998')),
                      DataCell(Text('27-02-1999')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('José Antonio De los Santos')),
                      DataCell(Text('27-02-1999')),
                      DataCell(Text('17-08-2000')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Radhames Lora Salcedo')),
                      DataCell(Text('17-08-2000')),
                      DataCell(Text('01-09-2004')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Lic. Luis Antonio Luna Paulino')),
                      DataCell(Text('01-09-2004')),
                      DataCell(Text('10-10-2014')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Rafael Emilio De Luna Pichirilo')),
                      DataCell(Text('10-10-2014')),
                      DataCell(Text('01-02-2017')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Rafael Antonio Carrasco Paulino')),
                      DataCell(Text('01-02-2017')),
                      DataCell(Text('05-05-2021')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Lic. Juan Cesario Salas Rosario', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataCell(Text('05-05-2021', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataCell(Text('Director actual', style: TextStyle(fontWeight: FontWeight.bold))),
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}