import 'package:mysql1/mysql1.dart';

class Mysql {
  Mysql() {
    createTable();
  }

  // static String host = 'localhost';
  // static String host = '127.0.0.2';
  // static String host = '172.20.112.77';
  static String host = '0.0.0.0';
  static String user = 'root';
  static String password = 'master';
  static String db = 'dhs';
  static int port = 3306;

  Future<MySqlConnection> getConnection() async {
    var settings = ConnectionSettings(
      host: host, port: port, user: user, password: password, db: db,

    );
    return await MySqlConnection.connect(settings);
  }

  // create table
  Future<void> createTable() async {
    var conn = await getConnection();
    await conn.query(
      'CREATE TABLE IF NOT EXISTS users (id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, name VARCHAR(255), email VARCHAR(255), password VARCHAR(255);'
    );
    await conn.close();
  }

}