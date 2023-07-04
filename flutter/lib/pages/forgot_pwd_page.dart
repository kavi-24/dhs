import 'package:dhs/models/user_model.dart';
import 'package:dhs/services/database_helper.dart';
// import 'package:dhs/services/forgot_password.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _newPwdController = TextEditingController();
  final TextEditingController _confirmPwdController = TextEditingController();
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final User user = User.instance;
  bool userNameExists = false;
  bool? obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text("Change Password for ${user.username}"),
        title: const Text("Forgot Password"),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
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
                hintText: "Enter Your Username",
              ),
            ),
          ),
          !userNameExists
              ? ElevatedButton(
                  onPressed: () async {
                    bool userNameExists_ = await _databaseHelper.checkUser(
                        _usernameController.text, "");
                    if (!userNameExists_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Username does not exist"),
                        ),
                      );
                    }
                    setState(() {
                      userNameExists = userNameExists_;
                    });
                  },
                  child: const Text("Check if username exists"),
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _newPwdController,
                        obscureText: obscureText!,
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
                        if (_newPwdController.text !=
                            _confirmPwdController.text) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Passwords do not match"),
                            ),
                          );
                          return;
                        } else {
                          _databaseHelper.changePassword(
                              _usernameController.text, _newPwdController.text);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Password changed successfully"),
                            ),
                          );
                          Navigator.pop(context);
                          // bool success = await ForgotPassword.sendEmail(_usernameController.text) ? true : false;
                          // if (success) {
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     const SnackBar(
                          //       content: Text("Email sent successfully"),
                          //     ),
                          //   );
                          // }
                          // else {
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     const SnackBar(
                          //       content: Text("Email could not be sent"),
                          //     ),
                          //   );
                          // }
                        }
                      },
                      child: const Text("Change Password"),
                    ),
                  ],
                ),
        ]),
      ),
    );
  }
}


/*
            
*/