import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_todo_ui/screens/home_page.dart';
import 'package:firebase_todo_ui/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OTPScreens extends StatefulWidget {
  String mVerification;
  OTPScreens({required this.mVerification});

  @override
  State<OTPScreens> createState() => _OTPScreensState();
}

class _OTPScreensState extends State<OTPScreens> {
  /// global
  var auth = FirebaseAuth.instance;
  var otpNo1Controller = TextEditingController();
  var otpNo2Controller = TextEditingController();

  var otpNo3Controller = TextEditingController();

  var otpNo4Controller = TextEditingController();

  var otpNo5Controller = TextEditingController();

  var otpNo6Controller = TextEditingController();

  var mVerification = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: NetworkImage(
                    "https://cdn3.iconfinder.com/data/icons/cloud-technology-fill-group-of-networked/512/Cloud_two_step_verification-512.png"),
                scale: 2,
              )),
            ),
            hSpacher(mHeight: 25.0),
            Text(
              "OTP Verification Code",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            hSpacher(),
            Text(
                "Please enter the verification code send\n                 to  +91-00000000",
                style: TextStyle(fontSize: 16)),
            hSpacher(mHeight: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Container(
                //   height: 50,
                //   width: 50,
                //   color: Colors.red,
                // ) , Container(
                //   height: 50,
                //   width: 50,
                //   color: Colors.red,
                // )
                CustomOtpTextFild(otpNo1Controller, true),
                CustomOtpTextFild(otpNo2Controller, false),
                CustomOtpTextFild(otpNo3Controller, false),
                CustomOtpTextFild(otpNo4Controller, false),
                CustomOtpTextFild(otpNo5Controller, false),
                CustomOtpTextFild(otpNo6Controller, false),
              ],
            ),

            /*    //// package otp formate
            InputOpt(context), */
            hSpacher(),
            InkWell(
                onTap: () {},
                child: Text(
                  "Resend-otp",
                  style: TextStyle(fontSize: 16, color: Colors.red),
                )),
            hSpacher(mHeight: 20.0),
            CustomContainer(
              "Verify",
              Colors.blueGrey,
              () {
                var otp =
                    "${otpNo1Controller.text.toString()}${otpNo2Controller.text.toString()} ${otpNo3Controller.text.toString()}${otpNo4Controller.text.toString()}    ${otpNo5Controller.text.toString()} ${otpNo6Controller.text.toString()}";

                if (mVerification != " ") {
                  var credential = PhoneAuthProvider.credential(
                      verificationId: mVerification, smsCode: otp);
                  auth.signInWithCredential(credential).then((value) {
                    print("Auto SIgn in Complated!!: ${value.user!.uid}");
                  });
                }

                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ));
              },
            )
          ],
        ),
      ),
    );
  }

// add package otpformat
  Widget InputOpt(BuildContext context) {
    return OtpTextField(
      numberOfFields: 4,
      borderColor: Color(0xFF512DA8),
      //set to true to show as box or false to show as dash
      showFieldAsBox: true,
      //runs when a code is typed in
      onCodeChanged: (String code) {
        //handle validation or checks here
      },
      //runs when every textfield is filled
      onSubmit: (String verificationCode) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Verification Code"),
                content: Text('Code entered is $verificationCode'),
              );
            });
      }, // end onSubmit
    );
  }

  Widget CustomOtpTextFild(mController, mAutoFouc) {
    return SizedBox(
      height: 50,
      width: 50,
      child: TextField(
        controller: mController,
        minLines: 1,
        maxLength: 1,
        maxLines: 1,
        autofocus: mAutoFouc,
        onChanged: (value) {
          if (value.isNotEmpty) {
            FocusScope.of(context).nextFocus();
          }
        },
        decoration: InputDecoration(
            counterText: "",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}
