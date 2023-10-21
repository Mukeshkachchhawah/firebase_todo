import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  var addressController = TextEditingController();

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PhoneNumber(),
                              ));
                        },
                        child: Text("Skip")),
                  ],
                ),
                hSpacher(),

                Text(
                  "User Sign Up",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),

                hSpacher(),
                UserProfile(),
                hSpacher(),

                /// Add User Form TextForm Fild
                UserInput(),
                hSpacher(mHeight: 20.0),
                InkWell(
                  onTap: () {
                    var mEmail = emailController.text.toString();
                    var mPass = passController.text.toString();

                    var auth = FirebaseAuth.instance;
if(formKey.currentState!.validate()){

                    try {
                      auth
                          .createUserWithEmailAndPassword(
                              email: mEmail, password: mPass)
                          .then((value) {
                        print("Added Account");
// add UserModal Class Data
                        var userModal = UserModal(
                            uid: value.user!.uid,
                            name: userNameController.text.toString(),
                            email: mEmail,
                            age: "21",
                            address: "jpodhpur",
                            dob: "12/3/2021",
                            gender: "mal",
                            mobNo: "91 2398843823",
                            password: passController.text.toString(),
                            confromPasswrod: confromPasswrod.text.toString());
                        var db = FirebaseFirestore.instance;

                        /// uid firebase auth uid
                        /// tojson UserModal se
                        db
                            .collection("users")
                            .doc(value.user!.uid)
                            .set(userModal.tojson())
                            .then((value) {
                          print("User Added");
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignIn(),
                            ));
                      });
                    } on FirebaseAuthException catch (e) {
                      if (e.code == "Week Password") {
                        print("THe Passwrod provided is tpp week");
                      } else if (e.code == "Email is Alerdy in use") {
                        print("The Account Add");
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget UserProfile() {
    return Column(
      children: [
        Center(
          child: InkWell(
            onTap: () async {
              var imgXFile =
                  await ImagePicker().pickImage(source: ImageSource.gallery);
              if (imgXFile != null) {
                var croppedImgFile = await ImageCropper().cropImage(
                  sourcePath: imgXFile.path,
                  aspectRatioPresets: [
                    CropAspectRatioPreset.square,
                    CropAspectRatioPreset.ratio3x2,
                    CropAspectRatioPreset.original,
                    CropAspectRatioPreset.ratio4x3,
                    CropAspectRatioPreset.ratio16x9
                  ],
                  uiSettings: [
                    AndroidUiSettings(
                        toolbarTitle: 'Cropper',
                        toolbarColor: Colors.deepOrange,
                        toolbarWidgetColor: Colors.white,
                        initAspectRatio: CropAspectRatioPreset.original,
                        lockAspectRatio: false),
                    IOSUiSettings(
                      title: 'Cropper',
                    ),
                    WebUiSettings(
                      context: context,
                    ),
                  ],
                );

                if (croppedImgFile != null) {
                  imgPath = croppedImgFile.path;
                  setState(() {});
                }
                setState(() {});
              }
            },
            child: imgPath != " "
                ? Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: FileImage(File(imgPath)),
                            fit: BoxFit.cover)),
                  )
                : Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzBpnouxDuF063trW5gZOyXtyuQaExCQVMYA&usqp=CAU"))),
                  ),
          ),
        ),
        ElevatedButton(
            onPressed: () {
              var timeMilisecond = DateTime.now().microsecondsSinceEpoch;
              var uploadRef =
                  storage.child("images/profile_pic/img_$timeMilisecond.jpg");

              if (imgPath != "") {
                /// upload
                uploadRef
                    .putFile(File(imgPath))
                    .then((p0) => print("File Uploaded"));
              }
            },
            child: Text("Upload"))
      ],
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
              return 'confrom passwrod';
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
        TextFormField(
          controller: phoneNoController,
          obscureText: isHide,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Enter Your phone number';
            }
            return null;
          },
          decoration: InputDecoration(
              hintText: "Phone Number",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
        ),
        hSpacher(),
        TextFormField(
          controller: addressController,
          obscureText: isHide,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus!.unfocus();
          },
          validator: (value) {
            if (value!.isEmpty) {
              return 'Enter Your address';
            }
            return null;
          },
          decoration: InputDecoration(
              hintText: "Address",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
        )
      ],
    );
  }
}
