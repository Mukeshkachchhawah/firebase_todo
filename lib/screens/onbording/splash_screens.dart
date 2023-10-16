import 'dart:async';

import 'package:firebase_todo_ui/screens/home_page.dart';
import 'package:firebase_todo_ui/screens/onbording/user_ccount/email_password/sign_in.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 4), () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SignScreens(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Splash Screens",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
