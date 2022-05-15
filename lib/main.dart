import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:restaurant_version/login_page.dart';
import 'package:restaurant_version/registration/register_welcome_page.dart';

import 'From_Sulaiman/screens/home_screen.dart';
import 'From_Sulaiman/screens/login_screen.dart';
import 'averege_price_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          brightness: Brightness.light,
          primaryColor: Colors.deepOrange[800]),
      home: FirebaseAuth.instance.currentUser != null
          ? const HomeScreen()
          //HomeScreen()
          : const LoginScreen(),
    );
  }
}
