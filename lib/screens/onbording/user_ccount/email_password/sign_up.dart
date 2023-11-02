



import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_todo_ui/modal/user_modal.dart';
import 'package:firebase_todo_ui/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../phone_auth/phone_number.dart';
import 'sign_in.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpUpState();
}

class _SignUpUpState extends State<SignUp> {
  var formKey = GlobalKey<FormState>();

  var userNameController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var confromPasswrod = TextEditingController();
  var phoneNoController = TextEditingController();


  bool isHide = false;

  ////// user profile
  var storage = FirebaseStorage.instance.ref();
  // late Reference downloadRef;
  late ListResult downloadRef;

  String imageUrl = "";

  List<String> arrImg = [];

  String imgPath = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffd6e2ea),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 50),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                hSpacher(),

                Text(
                  "User Sign Up",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),

                hSpacher(),
              Center(
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage("https://static.thenounproject.com/png/736670-200.png"))
                  ),
                ),
              ),
              hSpacher(),
                /// Add User Form TextForm Fild
                UserInput(),
                hSpacher(mHeight: 20.0),
                InkWell(
                  onTap: () {
                    var mEmail = emailController.text.toString();
                    var mPass = passController.text.toString();

                    print("object");

                    //// check condition by block is empty
                    if (formKey.currentState!.validate()) {
                      //// us try and catch add data firebase
                      try {
                        final credential = FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: mEmail,
                          password: mPass,
                        )
                            .then((value) {
                          print("Added Complet");
                          var userModal = UserModal(
                              address: "jodhpur",
                              age: "21",
                              confromPasswrod: confromPasswrod.text.toString(),
                              dob: "21/11/1241",
                              email: emailController.text.toString(),
                              gender: "fem",
                              mobNo: "121231234",
                              name: userNameController.text.toString(),
                              password: passController.text.toString(),
                              uid: value.user!.uid);
                          var db = FirebaseFirestore.instance;
                          db
                              .collection("user")
                              .doc(value.user!.uid)
                              .set(userModal.tojson())
                              .then((value) {
                            print("User data add");
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignIn(),
                              ));
                        });
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          print('The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          print('The account already exists for that email.');
                        }
                      } catch (e) {
                        print(e);
                      }
                    }
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "Sign UP",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
                hSpacher(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Alerdy Login user"),
                    wSpacher(mWidht: 5.0),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignIn(),
                            ));
                      },
                      child: Text(
                        "Sign in",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
             
             ,
             hSpacher(mHeight: 20.0),
             CustomContainer("Sign in Phoen Number", Colors.blue, () {
               Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PhoneNumber(),
                              ));
              }) ],
            ),
          ),
        ),
      ),
    );
  }

  Widget UserInput() {
    return Column(
      children: [
        TextFormField(
          controller: userNameController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Enter Your user name';
            }
            return null;
          },
          decoration: InputDecoration(
              hintText: "User Name", border: OutlineInputBorder()),
        ),
        hSpacher(),
        TextFormField(
          controller: emailController,
          validator: (value) {
            if (value == "" || !value!.contains("@")) {
              return 'Enter Your Valid Email';
            }
            return null;
          },
          decoration: InputDecoration(
              hintText: "Email",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
        ),
        hSpacher(),
        TextFormField(
          controller: passController,
          obscureText: isHide,
          validator: (value) {
            if (value == "" || value!.length < 5) {
              return 'Enter Your password';
            }
            return null;
          },
          decoration: InputDecoration(
              hintText: "Password",
              suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      isHide = !isHide;
                    });
                  },
                  child:
                      Icon(isHide ? Icons.visibility_off : Icons.visibility)),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
        ),
        hSpacher(),
        TextFormField(
          controller: confromPasswrod,
          obscureText: isHide,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus!.unfocus();
          },
          validator: (value) {
            if (value == "" || value!.length < 5) {
              return 'Confrom passwrod';
            }
            return null;
          },
          decoration: InputDecoration(
              hintText: "Confrom Password",
              suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      isHide = !isHide;
                    });
                  },
                  child:
                      Icon(isHide ? Icons.visibility_off : Icons.visibility)),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
        ),
        hSpacher(),
     
      ],
    );
  }
}

