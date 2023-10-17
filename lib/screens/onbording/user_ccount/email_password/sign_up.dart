import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_todo_ui/ui_helper.dart';
import 'package:flutter/material.dart';

class SingUp extends StatefulWidget {
  const SingUp({super.key});

  @override
  State<SingUp> createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Form(
          key: formKey,
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
                controller: emailController,
                decoration: InputDecoration(
                    hintText: "Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
              hSpacher(),
              TextField(
                controller: passwordController,
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
              InkWell(
                onTap: () {
                  var mEmail = emailController.text.toString();
                  var mPass = passwordController.text.toString();
        
                  var auth = FirebaseAuth.instance;
        
                  try{
        
                    auth.createUserWithEmailAndPassword(email: mEmail, password: mPass).then((value){
                      print("Added Account");
                    });
        
                  } on FirebaseAuthException catch(e){
                    if(e.code=="Week Password"){
                      print("THe Passwrod provided is tpp week");
                    }else if(e.code=="Email is Alerdy in use"){
                      print("The Account Add");
                    }
        
                  }catch(e){
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
      ),
    );
  }
}
