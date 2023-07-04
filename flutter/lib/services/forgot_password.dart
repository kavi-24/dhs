/*

Example #
final Email email = Email(
  body: 'Email body',
  subject: 'Email subject',
  recipients: ['example@example.com'],
  cc: ['cc@example.com'],
  bcc: ['bcc@example.com'],
  attachmentPaths: ['/path/to/attachment.zip'],
  isHTML: false,
);

await FlutterEmailSender.send(email);

androidmanifest.xml
<manifest package="com.mycompany.myapp">
  <queries>
    <intent>
      <action android:name="android.intent.action.SENDTO" />
      <data android:scheme="mailto" />
    </intent>
  </queries>
</manifest>
*/

import 'dart:math';
import 'package:dhs/services/database_helper.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class ForgotPassword {
  static Future<bool> sendEmail(String username) async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    String newPass = generatePassword();
    String email_ = await databaseHelper.getEmailByUsername(username);
    databaseHelper.changePassword(username, newPass);
    final Email email = Email(
      body: 'Your password is $newPass. Please change it after logging in.',
      subject: 'Forgot Password for DHS App',
      recipients: [email_],
    );
    await FlutterEmailSender.send(email);
    return true;
  }

  // generate a random strong password
  static String generatePassword() {
    String password = "";
    for (int i = 0; i < 8; i++) {
      password += String.fromCharCode(33 + Random().nextInt(93));
    }
    return password;
  }
}
