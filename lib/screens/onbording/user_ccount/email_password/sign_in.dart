import 'package:firebase_todo_ui/screens/onbording/phone_auth/phone_number.dart';
import 'package:firebase_todo_ui/screens/onbording/user_ccount/email_password/sign_up.dart';
import 'package:firebase_todo_ui/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../../../home_page.dart';

class SignScreens extends StatefulWidget {
  const SignScreens({super.key});

  @override
  State<SignScreens> createState() => _SignScreensState();
}
/* 
class _SignScreensState extends State<SignScreens> {
  FocusNode emailNode = FocusNode();
  FocusNode emailSignUpNode = FocusNode();
  FocusNode passNode = FocusNode();
  FocusNode passSignUpNode = FocusNode();
  FocusNode cpassNode = FocusNode();
  var txtEmailController = TextEditingController();
  var txtEmailSignUpController = TextEditingController();
  var txtPassController = TextEditingController();
  var txtPassSignUpController = TextEditingController();
  var txtcPassController = TextEditingController();
  bool isHide = false;
  // final validEmail = "arvindra@gmail.com";
  // final validPass = "12345";

  StateMachineController? machineController;
  SMIInput<bool>? isChecking;
  SMIInput<double>? numLook;
  SMIInput<bool>? isHandsUp;
  SMIInput<bool>? trigSuccess;
  SMIInput<bool>? trigFail;

  CrossFadeState state = CrossFadeState.showFirst;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailNode.addListener(focusEmail);
    emailSignUpNode.addListener(focusEmail);
    passNode.addListener(focusPass);
    passSignUpNode.addListener(focusPass);
    cpassNode.addListener(focusPass);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailNode.removeListener(focusEmail);
    passNode.removeListener(focusPass);
    emailSignUpNode.removeListener(focusEmail);
    passSignUpNode.removeListener(focusPass);
    cpassNode.removeListener(focusPass);
  }

  void focusPass() {
    isHandsUp!.change(state == CrossFadeState.showFirst
        ? passNode.hasFocus
        : passSignUpNode.hasFocus || cpassNode.hasFocus);
  }

  void focusEmail() {
    isChecking!.change(state == CrossFadeState.showFirst
        ? emailNode.hasFocus
        : emailSignUpNode.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffD6E2EA),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_ios)),
            hSpacher(),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 185, 120, 115)),
                    child: RiveAnimation.asset(
                      "assets/animation/teddy-bear.riv",
                      fit: BoxFit.cover,
                      stateMachines: const ["Login Machine"],
                      onInit: (artboard) {
                        machineController = StateMachineController.fromArtboard(
                            artboard, "Login Machine");
                        if (machineController == null) return;

                        artboard.addController(machineController!);
                        isChecking = machineController!.findInput("isChecking");
                        numLook = machineController!.findInput("numLook");
                        isHandsUp = machineController!.findInput("isHandsUp");
                        trigSuccess =
                            machineController!.findInput("trigSuccess");
                        trigFail = machineController!.findInput("trigFail");
                      },
                    )),
              ],
            ),
            hSpacher(),
            Text(
              "Sign In",
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),

            /// add Custom Widget TextForm  Fild
            ///
            TextField(
              // focusNode: ,
              onChanged: (value) {
                numLook!.change((value.length + 10));
              },
              focusNode: emailNode,
              controller: txtEmailController,
              onTapOutside: (e) {
                FocusManager.instance.primaryFocus!.unfocus();
              },
              decoration: InputDecoration(
                  hintText: "email", border: OutlineInputBorder()),
            ),
            hSpacher(),
            TextFormField(
              focusNode: passNode,
              controller: txtPassController,
              obscureText: isHide,
              onTapOutside: (e) {
                FocusManager.instance.primaryFocus!.unfocus();
              },
              decoration: InputDecoration(
                  hintText: "password",
                  border: OutlineInputBorder(),
                  suffixIcon: InkWell(
                      onTap: () {
                        isHide = !isHide;
                        setState(() {});
                      },
                      child: Icon(
                          isHide ? Icons.visibility_off : Icons.visibility))),
            ),
            /*   CustomTextFormFild(
              hinttext: 'Enter User Email',
              labletext: 'Email',
              prefixIcons: Icon(Icons.email),
              sufIcons: Icon(Icons.done),
            ),
            hSpacher(mheight: 20),
            CustomTextFormFild(
              hinttext: 'Enter User Password',
              labletext: 'Passwrod',
              prefixIcons: Icon(Icons.lock),
              sufIcons: Icon(Icons.remove_red_eye_outlined),
            ), */
            hSpacher(),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {},
                  child: Text(
                    "Forget Password ? ",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.black),
                  ),
                ),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.red,
                  size: 19,
                )
              ],
            ),

            hSpacher(),
            Center(
                child: Text(
              'or sign up with social account',
              style: TextStyle(
                fontSize: 18,
              ),
            )),
            hSpacher(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [SocialBotton(), SocialBotton(), SocialBotton()],
            )
          ],
        ),
      ),
    );
  }

  Widget SocialBotton() {
    return Container(
      height: 50,
      width: 80,
      decoration: BoxDecoration(
          color: Colors.indigo, borderRadius: BorderRadius.circular(20)),
      child: Center(
        child: Icon(
          Icons.facebook,
          color: Colors.white,
        ),
      ),
    );
  }
}

 */

class _SignScreensState extends State<SignScreens> {

  var formKey = GlobalKey<FormState>();
  FocusNode emailNode = FocusNode();

  FocusNode passNode = FocusNode();

  var txtEmailController = TextEditingController();

  var txtPassController = TextEditingController();
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: SingleChildScrollView(
          child: Form(
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
                Container(
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
                      machineController = StateMachineController.fromArtboard(
                          artboard, "Login Machine");
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
                TextFormField(
                  controller: txtEmailController,
                  focusNode: emailNode,
                  onTapOutside: (event) {
                    FocusManager.instance.primaryFocus!.unfocus();
                  },
                  validator: (value) {
                    if(value!.isEmpty){
                      return 'Enter Your Valid Email';
                    }
                  },
                  onChanged: (value) {
                    numLook!.change(value.length + 10);
                  },
                  decoration: InputDecoration(
                      hintText: "Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
                hSpacher(),
                TextField(
                  focusNode: passNode,
                  controller: txtPassController,
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
                          child: Icon(
                              isHide ? Icons.visibility_off : Icons.visibility)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
                hSpacher(mHeight: 20.0),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ));
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
                              builder: (context) => SingUp(),
                            ));
                      },
                      child: Text(
                        "Sign Up",
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
}
