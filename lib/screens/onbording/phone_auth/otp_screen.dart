import 'package:firebase_todo_ui/screens/home_page.dart';
import 'package:firebase_todo_ui/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OTPScreens extends StatelessWidget {
  const OTPScreens({super.key});

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
            InputOpt(context),
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
}
