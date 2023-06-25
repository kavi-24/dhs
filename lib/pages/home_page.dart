import 'package:dhs/pages/change_pwd_page.dart';
import 'package:dhs/pages/login_page.dart';
import 'package:dhs/services/database_helper.dart';
import 'package:dhs/services/shared_prefs.dart';
import 'package:dhs/widgets/website_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavigationDrawer(
          children: [
            const SizedBox(
              height: 75,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  "DHS",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangePasswordPage(),
                  ),
                );
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Change Password",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Icon(
                    Icons.lock,
                    size: 30,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                SharedPrefs.setIsLoggedIn(false);
                SharedPrefs.setCurrentUserName("");
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Logout",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Icon(
                    Icons.logout,
                    size: 30,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () async {
                String userName = await SharedPrefs.getCurrentUserName();
                _databaseHelper.deleteUser(userName);
                SharedPrefs.setIsLoggedIn(false);
                SharedPrefs.setCurrentUserName("");
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("User Deleted Successfully"),
                  ),
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Delete User",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Icon(
                    Icons.delete,
                    size: 30,
                  ),
                ],
              ),
            ),
            
          ],
        ),
        appBar: AppBar(
          title: const Text("Home Page"),
          // actions: [
          //   IconButton(
          //     onPressed: () {
          //       SharedPrefs.setIsLoggedIn(false);
          //       SharedPrefs.setCurrentUserName("");
          //       Navigator.pushReplacement(context,
          //           MaterialPageRoute(builder: (context) => const LoginPage()));
          //     },
          //     icon: const Icon(Icons.logout),
          //   ),
          // ],
          // title: Text("Hello $_username"),
        ),
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                WebsiteCard(
                    text: "Google",
                    url: "http://google.com",
                    image: "google.png"),
                WebsiteCard(
                    text: "YouTube",
                    url: "http://youtube.com",
                    image: "youtube.png"),
                WebsiteCard(
                    text: "Times of India",
                    url: "http://timesofindia.com",
                    image: "toi.png"),
              ],
            ),
          ),
        ));
  }
}
