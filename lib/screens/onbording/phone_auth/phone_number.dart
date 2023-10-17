import 'package:firebase_todo_ui/ui_helper.dart';
import 'package:flutter/material.dart';

import 'otp_screen.dart';

class PhoneNumber extends StatelessWidget {
  const PhoneNumber({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://icons.veryicon.com/png/o/business/official-icon-of-qianjinding-supply-chain-2/mobile-phone-authentication-1.png"))),
            ),
            hSpacher(mHeight: 20.0),
            Text(
              "Enter your Phone Number",
              style: TextStyle(fontSize: 25),
            ),
            hSpacher(mHeight: 10.0),
            Text(
              "Pleace confirm your contury code and \nenter your mobile number",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
            ),
            hSpacher(mHeight: 20.0),
            Text("Country Code"),
            CustomTextFild(),
            hSpacher(mHeight: 50.0),
            CustomContainer("Send OTP", Colors.blueGrey, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => OTPScreens(),));
            },)
          ],
        ),
      ),
    );
  }

  Widget CustomTextFild() {
    return Row(
      children: [
        Expanded(
            flex: 3,
            child: TextField(
              decoration: InputDecoration(
                  hintText: "+91", suffixIcon: Icon(Icons.arrow_drop_down)),
            )),
        wSpacher(),
        Expanded(
            flex: 7,
            child: TextField(
              decoration: InputDecoration(hintText: "Phone Number"),
            ))
      ],
    );
  }
}
