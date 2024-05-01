import 'package:mysql1/mysql1.dart';

import 'koneksi.dart';

class UserRepository {
  static Future<List<User>> getUsers() async {
    final MySqlConnection connection =
        await MySqlConnectionManager.getConnection();

    try {
      final Results results = await connection.query('SELECT * FROM users');

      List<User> users = [];
      for (final row in results) {
        final user = User(
          id: row['id'],
          username: row['username'],
          email: row['email'],
        );
        users.add(user);
      }

      return users;
    } finally {
      await connection.close();
    }
  }
}

class User {
  int id;
  String username;
  String email;

  User({required this.id, required this.username, required this.email});
}
