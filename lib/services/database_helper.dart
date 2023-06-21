import '/models/user_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {

  Future<Database> database() async {
    return openDatabase(
      'users.db',
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE IF NOT EXISTS USERS(id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT, email TEXT, password TEXT)",
        );
      },
    );
  }

  // insert user into database
  Future<int> insertUser(User user) async {
    final Database db = await database();
    return await db.insert(
      "USERS",
      user.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // check if username or email already exists
  Future<bool> checkUser(String username, String email) async {
    final Database db = await database();
    List<Map<String, dynamic>> users = await db.query(
      "USERS",
      where: "username = ? OR email = ?",
      whereArgs: [username, email],
    );
    return users.isNotEmpty;
  }

  // check if username matches password
  Future<bool> checkUserPassword(String username, String password) async {
    final Database db = await database();
    List<Map<String, dynamic>> users = await db.query(
      "USERS",
      where: "username = ? AND password = ?",
      whereArgs: [username, password],
    );
    return users.isNotEmpty;
  }

}
