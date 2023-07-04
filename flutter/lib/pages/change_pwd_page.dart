import 'package:dhs/models/user_model.dart';
import 'package:dhs/services/database_helper.dart';
import 'package:dhs/services/shared_prefs.dart';
import 'package:flutter/material.dart';

class ChangePasswordPage extends StatelessWidget {
  ChangePasswordPage({super.key});

  final TextEditingController _oldPwdController = TextEditingController();
  final TextEditingController _newPwdController = TextEditingController();
  final TextEditingController _confirmPwdController = TextEditingController();
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  final User user = User.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Password for ${user.username}"),
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
                controller: _oldPwdController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Old Password",
                  hintText: "Enter Old Password",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _newPwdController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "New Password",
                  hintText: "Enter New Password",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _confirmPwdController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Confirm Password",
                  hintText: "Enter Confirm Password",
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                String userName = await SharedPrefs.getCurrentUserName();
                if (_newPwdController.text == _confirmPwdController.text && _oldPwdController.text != "" && _newPwdController.text != "" && _confirmPwdController.text != "") {
                  bool success = await _databaseHelper.changePassword(userName, _newPwdController.text);
                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Successfully changed password"),
                      ),
                    );
                    await Future.delayed(const Duration(seconds: 1, milliseconds: 500));
                    Navigator.of(context).pop();
                    // Navigator.of(context).pushReplacement(
                    //   MaterialPageRoute(
                    //     builder: (context) => const HomePage(),
                    //   ),
                    // );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Error changing password"),
                      ),
                    );
                  }
                }
                else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Check your inputs"),
                    ),
                  );
                }
              },
              child: const Text("Change Password"),
            ),
          ],
        )
      )
    );
  }
}