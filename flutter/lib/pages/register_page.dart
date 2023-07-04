import 'package:dhs/models/user_model.dart';
import 'package:dhs/pages/login_page.dart';
import 'package:dhs/services/database_helper.dart';
import 'package:dhs/services/db_mysql.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // final DatabaseHelper _databaseHelper = DatabaseHelper();
  final Mysql _databaseHelper = Mysql();
  bool? obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up Page"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Username",
                  hintText: "Enter Username",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Email",
                  hintText: "Enter Email",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                obscureText: obscureText!,
                controller: _passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Password",
                  hintText: "Enter Password",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _confirmPasswordController,
                obscureText: obscureText!,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Confirm Password",
                  hintText: "Enter Confirm Password",
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Checkbox(
                      value: !(obscureText!),
                      onChanged: (val) {
                        setState(() {
                          obscureText = !(obscureText!);
                        });
                      }),
                  const Text("Show Password")
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                // bool alreadyPresent = await _databaseHelper.checkUser(
                //     _usernameController.text, _emailController.text);
                bool alreadyPresent = false;
                String sql =
                    "SELECT * FROM users WHERE username = ? OR email = ?";
                await _databaseHelper.getConnection().then((conn) async {
                  await conn.query(sql, [
                    _usernameController.text,
                    _emailController.text
                  ]).then((results) {
                    for (var row in results) {
                      if (row[1] == _usernameController.text ||
                          row[2] == _emailController.text) {
                        alreadyPresent = true;
                        break;
                      }
                    }
                  }).onError((error, stackTrace) {
                    print(error);
                  });
                  conn.close();
                });

                if (alreadyPresent) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("User already exists"),
                    ),
                  );
                } else if (_passwordController.text !=
                    _confirmPasswordController.text) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Passwords do not match"),
                    ),
                  );
                } else {
                  await _databaseHelper.getConnection().then((conn) async {
                    await conn.query(
                        'INSERT INTO users (username, email, password) VALUES (?, ?, ?)',
                        [
                          _usernameController.text,
                          _emailController.text,
                          _passwordController.text
                        ]);
                    conn.close();
                  });
                  // await _databaseHelper.insertUser(
                  //   User(
                  //     username: _usernameController.text,
                  //     email: _emailController.text,
                  //     password: _passwordController.text,
                  //   ),
                  // );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("User registered successfully"),
                    ),
                  );
                  await Future.delayed(const Duration(seconds: 2));
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (context) {
                    return const LoginPage();
                  }));
                }
              },
              child: const Text("Sign Up"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (context) {
                      return const LoginPage();
                    }));
                  },
                  child: const Text("Log In"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  // showFutureDBData() {
  // return FutureBuilder<List<UserModel>>(
  //   future: getmySQLData(),
  //   builder: (BuildContext context, snapshot) {
  //     if (snapshot.connectionState == ConnectionState.waiting) {
  //       return const CircularProgressIndicator();

  //     } else if (snapshot.hasError) {

  //       return Text(snapshot.error.toString());

  //     }

  //     return ListView.builder(

  //       itemCount: snapshot.data!.length,

  //       itemBuilder: (context, index) {

  //         final user = snapshot.data![index];

  //         return ListTile(

  //           leading: Text(user.userId),

  //           title: Text(user.username),

  //           subtitle: Text(user.email),

  //         );

  //       },

  //     );

  //   },

  // );
  // }
}
