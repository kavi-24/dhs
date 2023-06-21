import 'package:dhs/pages/login_page.dart';
import 'package:dhs/services/shared_prefs.dart';
import 'package:dhs/widgets/website_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home Page"),
          actions: [
            IconButton(
                onPressed: () {
                  SharedPrefs.setIsLoggedIn(false);
                  SharedPrefs.setCurrentUserName("");
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                },
                icon: const Icon(Icons.logout))
          ],
          // title: Text("Hello $_username"),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                WebsiteCard(text: "Google", url: "http://google.com"),
                WebsiteCard(text: "Yahoo", url: "http://yahoo.com"),
                WebsiteCard(text: "Times of India", url: "http://timesofindia.com"),
              ],
            ),
          ),
        ));
  }
}
