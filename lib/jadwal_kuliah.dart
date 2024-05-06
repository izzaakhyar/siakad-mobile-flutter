import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:csv/csv.dart';

void main() {
  runApp(const JadwalKuliah());
}

class JadwalKuliah extends StatelessWidget {
  const JadwalKuliah({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: JadwalKuliahPage(),
    );
  }
}

class JadwalKuliahPage extends StatefulWidget {
  const JadwalKuliahPage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<JadwalKuliahPage> {
  List<List<dynamic>> data = [];

  Future<void> loadCSV() async {
    final String rawCSV = await rootBundle.loadString('assets/data/jadwal.csv');
    List<List<dynamic>> csvTable = const CsvToListConverter().convert(rawCSV);
    setState(() {
      data = csvTable;
    });
  }

  @override
  void initState() {
    super.initState();
    loadCSV();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: data.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                List<dynamic> row = data[index];

                return Container(
                  height: 100.0,
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.symmetric(vertical: 4.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: const Color(0xFF0F2A44)
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Image(
                              image: AssetImage('assets/images/${row[3]}')
                          )
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          '${ row[0] }', // Matakuliah
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          '${ row[1] }',
                          style: const TextStyle(color: Colors.white),
                        ), // Ruang
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          '${ row[2] }',
                          style: const TextStyle(color: Colors.white),
                        ), // Ruan // Jadwal
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
