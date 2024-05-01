import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:csv/csv.dart';

void main() {
  runApp(NilaiMatkul());
}

class NilaiMatkul extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NilaiMatkulPage(),
    );
  }
}

class NilaiMatkulPage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<NilaiMatkulPage> {
  List<List<dynamic>> data = [];

  Future<void> loadCSV() async {
    final String rawCSV = await rootBundle.loadString('assets/data/nilai.csv');
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
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          List<dynamic> row = data[index];

          return Container(
            height: 100.0, // Sesuaikan tinggi container sesuai kebutuhan
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.symmetric(vertical: 4.0),
            decoration: BoxDecoration(
              //border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
                color: Color(0xFF122E4C)
              //0xFF122E4C
            ),
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Image(image: AssetImage('assets/images/${row[4]}'))
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    '${row[0]}', // Matakuliah
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                  ),
                ),
                SizedBox(width: 15.0,),
                Expanded(
                  flex: 1,
                  child: Text(
                    '${row[1]}',
                    style: TextStyle(color: Colors.white),
                  ), // Ruang
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Nilai huruf: ${row[2]} Nilai angka: ${row[3]}',
                    style: TextStyle(color: Colors.white),
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
