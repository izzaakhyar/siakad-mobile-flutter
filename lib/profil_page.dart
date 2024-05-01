import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'package:url_launcher/url_launcher.dart';
import 'package:csv/csv.dart';

void main() {
  runApp(ProfilPage());
}

class ProfilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Color(0xff1F2648)),
      home: Scaffold(
        body: SingleChildScrollView(child: ProfilePage(),),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilScreen createState() => _ProfilScreen();
}

class Profile {
  final String label;
  final String value;

  Profile({required this.label, required this.value});
}

class _ProfilScreen extends State<ProfilePage> {
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

  final List<Profile> profiles = [
    Profile(label: 'NBI', value: '1462100151'),
    Profile(label: 'Nama', value: 'Moh. Izza Akhyar Rafiussani'),
    Profile(label: 'Tempat, Tanggal Lahir', value: 'Surabaya, 15 Desember 2002'),
    Profile(label: 'IPK', value: '3.59'),
    Profile(label: 'Sosial Media', value: 'assets/images/multimedia.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 280.0,
          child: Stack(
            children: [
              // Background with blur effect
              Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.transparent,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
              ),
              // Centered CircleAvatar
              const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 84.0,
                      backgroundImage: AssetImage('assets/images/profile-img.png'),
                    ),
                    SizedBox(height: 15.0), // Adjust the spacing between avatar and text
                    Text(
                      'Moh. Izza Akhyar Rafiussani',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Program Studi Teknik Informatika',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5.0),

        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: profiles.length,
          itemBuilder: (context, index) {
            return buildProfile(context, profiles[index]);
          },
        ),

        SizedBox(height: 70.0,),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () => _launchInstagram(),
                  child: Image.asset('assets/images/instagram.png', width: 35, height: 35,)
              ),
              SizedBox(width: 15,),
              InkWell(
                  onTap: () => _launchGithub(),
                  child: Image.asset('assets/images/github.png', width: 35, height: 35)
              ),
              SizedBox(width: 15,),
              InkWell(
                  onTap: () => _launchLinkedin(),
                  child: Image.asset('assets/images/linkedin.png', width: 35, height: 35)
              ),
            ]
        ),
      ],
    );
  }

  Widget buildProfile(BuildContext context, Profile profile) {
    // Fixed values for styling
    const double fixedWidth = 50.0;
    const double fixedFontSize = 20.0;

    if (profile.label != 'Sosial Media') {
      return Row(
        children: [
          SizedBox(width: fixedWidth),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15.0),
              Text(
                profile.label,
                style: TextStyle(
                  fontSize: fixedFontSize,
                  fontFamily: 'Poppins',
                  color: Color(0xff858CB6),
                ),
              ),
              Text(
                profile.value,
                style: TextStyle(
                  fontSize: fixedFontSize,
                  fontFamily: 'Poppins',
                  color: Color(0xfff1eeee),
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      return SizedBox(
        width: 0.0,
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,

        ),
      );
    }
  }

  // Function to launch Instagram when the text is tapped
  Future<void> _launchInstagram() async {
    const url = 'https://www.instagram.com/izzaarr_/';
    if (await canLaunchUrl(url as Uri)) {
      await launchUrl(url as Uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _launchGithub() async {
    const url = 'https://github.com/izzaakhyar';
    if (await canLaunchUrl(url as Uri)) {
      await launchUrl(url as Uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _launchLinkedin() async {
    const url = 'https://www.linkedin.com/in/moh-izza-akhyar-rafiussani-45a1782a2/';
    if (await canLaunchUrl(url as Uri)) {
      await launchUrl(url as Uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}
