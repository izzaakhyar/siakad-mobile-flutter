import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:csv/csv.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        automaticallyImplyLeading: false,
      ),
      body: const SingleChildScrollView(
        child: LoginScreen(),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  List<List<dynamic>> data = [];

  Future<void> loadCSV() async {
    final String rawCSV =
    await rootBundle.loadString('assets/data/users.csv');
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

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 60.0,),
          const Image(
            image: AssetImage('assets/images/untag-sby.png'),
            width: 180,
            height: 180,
          ),
          const SizedBox(height: 20.0),
          const Text(
            'Sistem Informasi Akademik Universitas 17 Agustus 1945 Surabaya',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50.0),
          TextField(
            controller: _usernameController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white.withOpacity(0.6),
              labelText: 'Username',
              labelStyle: const TextStyle(color: Colors.white),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: _passwordController,
            obscureText: true,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white.withOpacity(0.6),
              labelText: 'Password',
              labelStyle: const TextStyle(color: Colors.white),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 24.0),
          ElevatedButton(
            onPressed: () {
              // Authentication logic
              String username = _usernameController.text;
              String password = _passwordController.text;

              // Simple authentication logic
              if (data.isNotEmpty &&
                  username == '${data[0][0]}' &&
                  password == '${data[0][1]}') {
                Navigator.pushReplacementNamed(context, '/beranda');
              } else {
                // Display an error message if login fails
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Login Gagal. Coba lagi.'),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              minimumSize: const Size(600, 50),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                'Login',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
