import 'package:mysql1/mysql1.dart';
import '/models/user_model.dart';

class DatabaseHelper {
  late ConnectionSettings instance;

  // DatabaseHelper() {
  //   ConnectionSettings instance_ = ConnectionSettings(
  //     // host: 'localhost',
  //     // port: 3306,
  //     user: 'root',
  //     password: 'master',
  //     db: 'dhs',
  //   );
  //   instance = instance_;
  //   createTable();
  // }

  Future<MySqlConnection> getConnection() async {
    var settings =
        ConnectionSettings(user: "root", password: "master", db: "dhs");
    return await MySqlConnection.connect(settings);
  }

  Future<void> createTable() async {
    MySqlConnection conn = await MySqlConnection.connect(instance);
    Results results = await conn.query(
      "CREATE TABLE IF NOT EXISTS USERS(id INTEGER PRIMARY KEY AUTO_INCREMENT, username TEXT, email TEXT, password TEXT)",
    );
    print(results);
  }

  // insert user into database
  Future<bool> insertUser(User user) async {
    MySqlConnection conn = await MySqlConnection.connect(instance);
    Results results = await conn.query(
      "INSERT INTO USERS(username, email, password) VALUES (?, ?, ?)",
      [user.username, user.email, user.password],
    );
    print(results);
    // ignore: unnecessary_null_comparison
    return results != null;
  }

  // check if username or email already exists
  Future<bool> checkUser(String? username, String? email) async {
    MySqlConnection conn = await MySqlConnection.connect(instance);
    Results results = await conn.query(
      "SELECT * FROM USERS WHERE username = ? OR email = ?",
      [username, email],
    );
    print(results);
    return results.isNotEmpty;
  }

  // check if username matches password
  Future<bool> checkUserPassword(String username, String password) async {
    MySqlConnection conn = await MySqlConnection.connect(instance);
    Results results = await conn.query(
      "SELECT * FROM USERS WHERE username = ? AND password = ?",
      [username, password],
    );
    print(results);
    return results.isNotEmpty;
  }

  // change password
  Future<bool> changePassword(String username, String password) async {
    MySqlConnection conn = await MySqlConnection.connect(instance);
    Results results = await conn.query(
      "UPDATE USERS SET password = ? WHERE username = ?",
      [password, username],
    );
    print(results);
    return results.affectedRows != 0;
  }

  // Delete user
  Future<bool> deleteUser(String username) async {
    MySqlConnection conn = await MySqlConnection.connect(instance);
    Results results = await conn.query(
      "DELETE FROM USERS WHERE username = ?",
      [username],
    );
    print(results);
    return results.affectedRows != 0;
  }

  // Get email by username
  Future<String> getEmailByUsername(String username) async {
    MySqlConnection conn = await MySqlConnection.connect(instance);
    Results results = await conn.query(
      "SELECT email FROM USERS WHERE username = ?",
      [username],
    );
    print(results);
    return results.first[0].toString();
  }

  /*
  Future<List<UserModel>> getmySQLData() async {

  var db = Mysql();

  String sql = 'select * from myDB.users;';

 

  final List<UserModel> mylist = [];

  await db.getConnection().then((conn) async {

    await conn.query(sql).then((results) {

      for (var res in results) {

        //print(res);

        // mylist.add(res['user_Id'].toString());

        // mylist.add(res['username'].toString());

        // mylist.add(res['email'].toString());

        final UserModel myuser = UserModel(

            userId: res['user_Id'].toString(),

            username: res['username'].toString(),

            email: res['email'].toString());

        mylist.add(myuser);

      }

    }).onError((error, stackTrace) {

      print(error);

      return null;

    });

    conn.close();

  });

 

  return mylist;

}

class UserModel 

  UserModel({

    required this.userId,

    required this.username,

    required this.email,

  });

 

  String userId;

  String username;

  String email;

}
  */

  // import 'dart:convert';
  // DatabaseHelper copyWith({
  //   ConnectionSettings? instance,
  // }) {
  //   return DatabaseHelper(
  //     instance ?? this.instance,
  //   );
  // }

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'instance': instance.toMap(),
  //   };
  // }

  // factory DatabaseHelper.fromMap(Map<String, dynamic> map) {
  //   return DatabaseHelper(
  //     ConnectionSettings.fromMap(map['instance'] as Map<String,dynamic>),
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory DatabaseHelper.fromJson(String source) => DatabaseHelper.fromMap(json.decode(source) as Map<String, dynamic>);

  // @override
  // String toString() => 'DatabaseHelper(instance: $instance)';

  // @override
  // bool operator ==(covariant DatabaseHelper other) {
  //   if (identical(this, other)) return true;

  //   return
  //     other.instance == instance;
  // }

  // @override
  // int get hashCode => instance.hashCode;
}
