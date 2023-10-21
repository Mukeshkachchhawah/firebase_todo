import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_todo_ui/firebase_options.dart';
import 'package:firebase_todo_ui/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/image_pic.dart';
import 'screens/onbording/splash_screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodoProvider(),
      child: MaterialApp(
        title: 'Firebase Todo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),

      //  home: ImageProfile(),
         home: SplashScreen(),
      ),
    );
  }
}
