import 'dart:async';

import 'package:firebase_todo_ui/screens/home_page.dart';
import 'package:firebase_todo_ui/screens/onbording/user_ccount/email_password/sign_in.dart';
import 'package:firebase_todo_ui/screens/onbording/user_ccount/email_password/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  static const String LOGIN_KEY = "LoggedIn";

  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   whereToGo();
  }

  // void SherPref()async{
  //  final SharedPreferences pref = await SharedPreferences.getInstance();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/to-do.png", scale: 3,),
          Center(
            child: Text(
              "To-do List",
              style: TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  /// sherPref
   void whereToGo() async {
    var pref = await SharedPreferences.getInstance();

    var isLogin = pref.getBool(LOGIN_KEY);
    Timer(Duration(seconds: 2), () async {
      // Widget navigateToPage = LoginScreen();

      if (isLogin != null) {
        if (isLogin) {
          //when true
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
        } else {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignIn(),));
          // navigateToPage = SignUpScreen();
        }
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUp(),));
        // navigateToPage = SignUpScreen();
      }

      // Navigator.pushReplacement(
      //     context as BuildContext,
      //     MaterialPageRoute(
      //       builder: (context) => navigateToPage,
      //     ));
    });
  }
}
