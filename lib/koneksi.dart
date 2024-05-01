import 'package:mysql1/mysql1.dart';

class MySqlConnectionManager {
  static Future<MySqlConnection> getConnection() async {
    final settings = ConnectionSettings(
      host: '127.0.0.1',
      port: 3306,
      db: 'flutter_test',
      user: 'root',
      password: '',
    );

    final MySqlConnection connection = await MySqlConnection.connect(settings);

    return connection;
  }
}
