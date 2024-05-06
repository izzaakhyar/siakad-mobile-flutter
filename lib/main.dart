import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:praktikumdosbim/nilai_page.dart';
import 'beranda.dart';
import 'jadwal_kuliah.dart';
import 'login_page.dart';
import 'profil_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: createMaterialColor(const Color(0xFF181e38)),
        scaffoldBackgroundColor: const Color(0xff1F2648),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/beranda': (context) => const MyHomePage(),
      },
      home: const MyHomePage(),
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
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    // Halaman 1: Beranda
    const BerandaPage(),
    // Halaman 2: Nilai Mata Kuliah
    const Center(
      child: NilaiMatkulPage(),
    ),
    // Halaman 3: Profil
    const Center(
      child: ProfilPage()
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const SizedBox(width: 0.0,),
            IconButton(
              icon: Image.asset('assets/images/untag-sby.png'),
              onPressed: () {

              },
            ),
            const SizedBox(width: 8.0,),
            const Text('Sistem Informasi Akademik'),
          ],
        ),
        automaticallyImplyLeading: false,
        toolbarHeight: 60.0,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
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
  const BerandaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Jumlah tab
      child: Scaffold(
        appBar: AppBar(
          title: null,
          toolbarHeight: 0.0,
          bottom: TabBar(
            tabs: const [
              Tab(text: 'Matakuliah Semester Ini'),
              Tab(text: 'Jadwal Kuliah'),
            ],
            onTap: (index) {
              // Aksi yang dijalankan saat tab dipilih
              if (kDebugMode) {
                print('Tab $index dipilih');
              }
            },
          ),
        ),

        body: const TabBarView(
          children: [
            // Konten untuk Tab Mata Kuliah yang diambil
            Center(
              child: MatkulPage(),
            ),
            // Konten untuk Tab Jadwal Kuliah
            Center(
              child: JadwalKuliahPage(),
            ),
          ],
        ),
      ),
    );
  }
}
