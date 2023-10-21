import 'package:firebase_todo_ui/screens/onbording/splash_screens.dart';
import 'package:firebase_todo_ui/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../home_page.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
   var _formKey = GlobalKey<FormState>();

  FocusNode emailNode = FocusNode();

  FocusNode passNode = FocusNode();

  var txtEmailController = TextEditingController();

  var txtPassController = TextEditingController();
  var userController = TextEditingController();
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
    emailNode.addListener(focusEmail);

    passNode.addListener(focusPass);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailNode.removeListener(focusEmail);
    passNode.removeListener(focusPass);
  }

  void focusPass() {
    isHandsUp!.change(passNode.hasFocus);
  }

  void focusEmail() {
    isChecking!.change(emailNode.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffd6e2ea),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 50),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                hSpacher(),

                /// Rive Animation Add
                RiveAnimationUse(),

                hSpacher(mHeight: 20.0),
                UserInput(),
                hSpacher(),

                hSpacher(),
                InkWell(
                  onTap: () async {
                  // ////// If Successfully Logged in(creds are Correct ////////)

                  if (_formKey.currentState!.validate()) {
                    var sp = await SharedPreferences.getInstance();
                    sp.setBool(SplashScreenState.LOGIN_KEY, true);

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
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
                        "Sign in",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
                hSpacher(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 2,
                      width: 157,
                      color: Colors.black,
                    ),
                    wSpacher(),
                    Text("or"),
                    wSpacher(),
                    Container(
                      height: 2,
                      width: 157,
                      color: Colors.black,
                    ),
                  ],
                ),
                hSpacher(),

                MoreLogin()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget RiveAnimationUse() {
    return Container(
      height: 400,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 175, 200, 209),
          borderRadius: BorderRadius.circular(10)),
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
    );
  }

  Widget UserInput() {
    return Column(
      children: [
        TextFormField(
          controller: txtEmailController,
          focusNode: emailNode,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus!.unfocus();
          },
          onChanged: (value) {
            numLook!.change(value.length + 10);
          },
          validator: (value) {
            if (value == "" || !value!.contains("@")) {
              return 'Enter uour valid email';
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
          focusNode: passNode,
          controller: txtPassController,
          obscureText: isHide,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus!.unfocus();
          },
          validator: (value) {
            if (value == "" || value!.length < 5) {
              return "Please enter valid Password(length must be 6 characters)!";
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
      ],
    );
  }

  Widget MoreLogin() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      SocilMedia(
       
        () {},
        /// facebook image
       "assets/images/google.png"
      ),
    
      SocilMedia(() { }, 

      /// google image
"assets/images/facebook.webp")
     
    ],
  );
}
}
