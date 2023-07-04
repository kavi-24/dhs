import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {

  static String isLoggedInKey = "ISLOGGEDIN";
  static String currentUserNameKey = "USERNAME";

  static Future<bool> getIsLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isLoggedInKey) ?? false;
  }

  static Future<bool> setIsLoggedIn(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(isLoggedInKey, isLoggedIn);
  }

  static Future<bool> setCurrentUserName(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(currentUserNameKey, username);
  }

  static Future<String> getCurrentUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(currentUserNameKey) ?? "";
  }

}