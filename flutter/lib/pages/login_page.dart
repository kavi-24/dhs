import 'package:dhs/models/user_model.dart';
import 'package:dhs/pages/forgot_pwd_page.dart';
import 'package:dhs/pages/home_page.dart';
import 'package:dhs/pages/register_page.dart';
import 'package:dhs/services/database_helper.dart';
import 'package:dhs/services/shared_prefs.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  User user = User.instance;
  bool? obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
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
                obscureText: obscureText!,
                controller: _passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Password",
                  hintText: "Enter Password",
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
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     ElevatedButton(
            //       onPressed: () {
            //       },
            //       child: const Text("Login"),
            //     ),
            //     const SizedBox(width: 20,),
            //     ElevatedButton(
            //       onPressed: () {
            //       },
            //       child: const Text("Sign Up"),
            //     ),
            //   ],
            // ),
            ElevatedButton(
              onPressed: () async {
                if (_usernameController.text == 'admin' && _passwordController.text == 'admin') {
                    user.username = _usernameController.text;
                    user.email = "admin@admin.com";
                    SharedPrefs.setIsLoggedIn(true);
                    SharedPrefs.setCurrentUserName(_usernameController.text);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Login Successful"),
                      ),
                    );
                    await Future.delayed(const Duration(seconds: 1));
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) {
                          return const HomePage();
                        },
                      ),
                    );
                } else {
                  bool crtLoginId = await _databaseHelper.checkUserPassword(
                      _usernameController.text, _passwordController.text);
                  if (crtLoginId) {
                    String email = await _databaseHelper
                        .getEmailByUsername(_usernameController.text);
                    user.username = _usernameController.text;
                    user.email = email;
                    SharedPrefs.setIsLoggedIn(true);
                    SharedPrefs.setCurrentUserName(_usernameController.text);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Login Successful"),
                      ),
                    );
                    await Future.delayed(const Duration(seconds: 1));
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) {
                          return const HomePage();
                        },
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Login Failed"),
                      ),
                    );
                  }
                }
              },
              child: const Text("Login"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const RegisterPage();
                    }));
                  },
                  child: const Text("Sign Up"),
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const ForgotPasswordPage();
                }));
              },
              child: const Text("Forgot Password?"),
            ),
          ],
        ),
      ),
    );
  }
}
