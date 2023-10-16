import 'package:firebase_todo_ui/ui_helper.dart';
import 'package:flutter/material.dart';

class SingUp extends StatelessWidget {
  const SingUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: Color.fromARGB(183, 236, 234, 234),
                    borderRadius: BorderRadius.circular(100)),
                child: Icon(Icons.arrow_back),
              ),
            ),
            hSpacher(),
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 204, 197, 197),
                  borderRadius: BorderRadius.circular(10)),
              child: Icon(Icons.arrow_back),
            ),
            hSpacher(mHeight: 20.0),
            TextField(
              decoration: InputDecoration(
                  hintText: "User Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))),
            ),
            hSpacher(),
            TextField(
              decoration: InputDecoration(
                  hintText: "Email",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))),
            ),
            hSpacher(),
            TextField(
              decoration: InputDecoration(
                  hintText: "Password",
                  suffixIcon: Icon(Icons.remove_red_eye),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))),
            ),
            hSpacher(),
            TextField(
              decoration: InputDecoration(
                  hintText: "Confrom Passwrod",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))),
            ),
            hSpacher(mHeight: 20.0),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  "Sign In",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            hSpacher(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 2,
                  width: 130,
                  color: Colors.black,
                ),
                wSpacher(),
                Text("more sign In"),
                wSpacher(),
                Container(
                  height: 2,
                  width: 130,
                  color: Colors.black,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SocilMedia(
                  Icon(
                    Icons.facebook,
                  ),
                  () {},
                ),
                SocilMedia(
                  Icon(
                    Icons.face,
                  ),
                  () {},
                ),
                SocilMedia(
                  Icon(
                    Icons.facebook,
                  ),
                  () {},
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Sign In with Phone Number"),
                wSpacher(mWidht: 5.0),
                Text(
                  "Click",
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
