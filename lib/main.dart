// import 'package:flutter/material.dart';
//
// import 'get_data.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('MySQL Flutter App'),
//         ),
//         body: FutureBuilder(
//           future: UserRepository.getUsers(),
//           builder: (context, AsyncSnapshot<List<User>> snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return CircularProgressIndicator();
//             } else if (snapshot.hasError) {
//               return Text('Error: ${snapshot.error}');
//             } else {
//               final users = snapshot.data;
//               return ListView.builder(
//                 itemCount: users?.length ?? 0,
//                 itemBuilder: (context, index) {
//                   final user = users![index];
//                   return ListTile(
//                     title: Text('Username: ${user.username}'),
//                     subtitle: Text('Email: ${user.email}'),
//                   );
//                 },
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:praktikumdosbim/nilai_page.dart';
import 'beranda.dart';
import 'jadwal_kuliah.dart';
import 'login_page.dart';
import 'profil_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: createMaterialColor(Color(0xFF181e38)), // Set the primary color to red
        scaffoldBackgroundColor: Color(0xff1F2648),
        //0xff6c60ff // Set the background color to a shade of red
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/login', // Tentukan halaman awal
      routes: {
        '/login': (context) => LoginPage(),
        '/beranda': (context) => MyHomePage(),
      },
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

MaterialColor createMaterialColor(Color color) {
  List<int> strengths = <int>[50, 100, 200, 300, 400, 500, 600, 700, 800, 900];
  Map<int, Color> swatch = <int, Color>{};
  final int primary = color.value;
  for (int i = 0; i < 10; i++) {
    final int strength = strengths[i];
    final double blend = i / 10.0;
    swatch[strength] = Color.lerp(Colors.white, color, blend)!;
  }
  return MaterialColor(primary, swatch);
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    // Halaman 1: Beranda
    BerandaPage(),
    // Halaman 2: Pencarian
    Center(
      child: NilaiMatkulPage(),
    ),
    // Halaman 3: Profil
    Center(
      child: ProfilPage()
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(width: 0.0,),
            IconButton(
              icon: Image.asset('assets/images/untag-sby.png'), // Replace with the path to your logo image
              onPressed: () {
                // Add any functionality when the logo is pressed
              },
            ),
            SizedBox(width: 8.0,),
            Text('Sistem Informasi Akademik'),
          ],
        ),
        //backgroundColor: Color(0xFFFFAA05),
        automaticallyImplyLeading: false,
        toolbarHeight: 60.0, // Sesuaikan tinggi toolbar sesuai kebutuhan
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grade),
            label: 'Nilai',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

class BerandaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Jumlah tab
      child: Scaffold(
        appBar: AppBar(
          title: null, // Hapus title
          toolbarHeight: 0.0, // Sesuaikan tinggi toolbar sesuai kebutuhan
          bottom: TabBar(
            tabs: [
              Tab(text: 'Matakuliah Semester Ini'),
              Tab(text: 'Jadwal Kuliah'),
              //Tab(text: 'Tab 3'),
            ],
            onTap: (index) {
              // Aksi yang dijalankan saat tab dipilih
              print('Tab $index dipilih');
            },
          ),
        ),

        body: TabBarView(
          children: [
            // Konten untuk Tab 1
            Center(
              child: MatkulPage(),
            ),
            // Konten untuk Tab 2
            Center(
              child: JadwalKuliahPage(),
            ),
          ],
        ),
      ),
    );
  }
}
