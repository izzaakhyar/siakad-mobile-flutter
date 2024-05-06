import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:csv/csv.dart';

void main() {
  runApp(const Matkul());
}

class Matkul extends StatelessWidget {
  const Matkul({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MatkulPage(),
    );
  }
}

class MatkulPage extends StatefulWidget {
  const MatkulPage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MatkulPage> {
  List<List<dynamic>> data = [];

  Future<void> loadCSV() async {
    final String rawCSV =
        await rootBundle.loadString('assets/data/beranda.csv');
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
          ? const CircularProgressIndicator()
          : DataTable(
              columns: const <DataColumn>[
                DataColumn(
                  label: Text(
                    'Kode',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Nama Matakuliah',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
              rows: data
                  .map(
                    (row) => DataRow(
                      cells: row
                          .map(
                            (cell) => DataCell(
                              Text('$cell',
                                  style: const TextStyle(color: Colors.white)),
                            ),
                          )
                          .toList(),
                    ),
                  )
                  .toList(),
            ),
    );
  }
}
