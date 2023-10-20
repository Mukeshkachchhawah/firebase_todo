import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_todo_ui/modal/user_modal.dart';
import 'package:firebase_todo_ui/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

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

  FocusNode username = FocusNode();
  FocusNode emailNode = FocusNode();
  FocusNode passNode = FocusNode();
  FocusNode confpassNode = FocusNode();
  bool isHide = false;

  StateMachineController? machineController;
  SMIInput<bool>? isChecking;
  SMIInput<double>? numLook;
  SMIInput<bool>? isHandsUp;
  SMIInput<bool>? trigSuccess;
  SMIInput<bool>? trigFail;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    username.addListener(userName);
    emailNode.addListener(focusEmail);

    passNode.addListener(focusPass);
    confpassNode.addListener(confPassword);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    username.removeListener(userName);
    emailNode.removeListener(focusEmail);
    passNode.removeListener(focusPass);
    confpassNode.removeListener(confPassword);
  }

  void userName() {
    isChecking!.change(username.hasFocus);
  }

  void focusPass() {
    isHandsUp!.change(passNode.hasFocus);
  }

  void focusEmail() {
    isChecking!.change(emailNode.hasFocus);
  }

  void confPassword() {
    isHandsUp!.change(confpassNode.hasFocus);
  }

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

                /// Rive Animation
                RiveAnimationUse(),
                hSpacher(mHeight: 150.0),

                Text(
                  "User Sign Up",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                hSpacher(),

                /// Add User Form TextForm Fild
                UserInput(),
                hSpacher(mHeight: 20.0),
                InkWell(
                  onTap: () {
                    var mEmail = emailController.text.toString();
                    var mPass = passController.text.toString();

                    var auth = FirebaseAuth.instance;

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
                            confromPasswrod: confromPasswrod.text.toString()
                            );
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

                /// Divider
                ReadMore(),

                /// Social Media
                MoreLogin(),

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

  Widget RiveAnimationUse() {
    return Center(
      child: SizedBox(
        height: 100,
        width: 200,
        child: RiveAnimation.asset(
          "assets/animation/teddy-bear.riv",
          fit: BoxFit.cover,
          stateMachines: const ["Login Machine"],
          onInit: (artboard) {
            machineController =
                StateMachineController.fromArtboard(artboard, "Login Machine");
            if (machineController == null) return;

            artboard.addController(machineController!);
            isChecking = machineController!.findInput("isChecking");
            numLook = machineController!.findInput("numLook");
            isHandsUp = machineController!.findInput("isHandsUp");
            trigSuccess = machineController!.findInput("trigSuccess");
            trigFail = machineController!.findInput("trigFail");
          },
        ),
      ),
    );
  }

  Widget UserInput() {
    return Column(
      children: [
        TextFormField(
          controller: userNameController,
          focusNode: username,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus!.unfocus();
          },
          onChanged: (value) {
            numLook!.change(value.length + 10);
          },
          decoration: InputDecoration(
              hintText: "User Name", border: OutlineInputBorder()),
        ),
        hSpacher(),
        TextFormField(
          controller: emailController,
          focusNode: emailNode,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus!.unfocus();
          },
          onChanged: (value) {
            numLook!.change(value.length + 10);
          },
          validator: (value) {
            if (value!.isEmpty) {
              return 'Enter Your Valid Email';
            }
          },
          decoration: InputDecoration(
              hintText: "Email",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
        ),
        hSpacher(),
        TextField(
          focusNode: passNode,
          controller: passController,
          obscureText: isHide,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus!.unfocus();
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
        TextField(
          focusNode: confpassNode,
          controller: confromPasswrod,
          obscureText: isHide,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus!.unfocus();
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
      ],
    );
  }
}

Widget ReadMore() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        height: 2,
        width: 120,
        color: Colors.black,
      ),
      wSpacher(),
      Text("more sign In"),
      wSpacher(),
      Container(
        height: 2,
        width: 120,
        color: Colors.black,
      ),
    ],
  );
}

Widget MoreLogin() {
  return Row(
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
  );
}
