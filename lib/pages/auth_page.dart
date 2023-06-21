import 'package:dhs/pages/home_page.dart';
import 'package:dhs/pages/login_page.dart';
import 'package:flutter/material.dart';
import '/services/shared_prefs.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  bool isLoggedIn = true;

  getIsLoggedIn() async {
    isLoggedIn = await SharedPrefs.getIsLoggedIn();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    getIsLoggedIn();
    if (isLoggedIn) {
      return const HomePage();
    }
    else {
      return const LoginPage();
    }
  }
}