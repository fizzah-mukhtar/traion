import 'dart:async';
import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:traion/WebPages/home.dart';

import '../ColorThemes/appColors.dart';

class emailVerificationPage extends StatefulWidget {
  const emailVerificationPage({super.key});

  @override
  State<emailVerificationPage> createState() => _emailVerificationPageState();
}

class _emailVerificationPageState extends State<emailVerificationPage> {
  bool isEmailVerified = false;
  Timer? timer;

  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();
      Timer.periodic(
        Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? HomePage()
      : AlertDialog(
          backgroundColor: mainBackgroundColor,
          title: Text(
              style: TextStyle(color: mainTextColor),
              ("Verification Email Sent, Please Verify")),
          actions: <Widget>[
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: mainButtonsColor),
              child: Text(style: TextStyle(color: mainTextColor), 'OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
}
