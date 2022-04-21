import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../services/firbase.dart';
import 'home_screen.dart';
import 'registration_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseAthentications firebaseFunction = FirebaseAthentications();
  // form key
  final _formKey = GlobalKey<FormState>();
  //editing controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  //========================= firebase auth function =========================
  // firebase
  final _auth = FirebaseAuth.instance;
  // string for displaying the error Message
  String? errorMessage;
  @override
  Widget build(BuildContext context) {
    //=====================email input filed ==============================//
    // email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ('Please enter you email');
        }

        // reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ('Please enter a valid email');
        }

        return null;
      },
      //validator: () {},
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.email),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "example@gmail.com",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    //=====================password input filed ==============================//
    // password field
    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: passwordController,
      keyboardType: TextInputType.visiblePassword,
      validator: (value) {
        RegExp regexp = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ('Password is required');
        }

        if (!regexp.hasMatch(value)) {
          return ('Please enter the of six characters');
        }
      },
      //validator: () {},
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "********",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.pink,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          firebaseFunction.signInUser(
              emailController.text, passwordController.text, context);

          // Navigator.pushReplacement(
          //     context, MaterialPageRoute(builder: (context) => HomeScreen()));
          // signIn(emailController.text, passwordController.text);
        },
        child: const Text(
          'Login',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
            child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    width: 200,
                    height: 200,
                    child: CircleAvatar(
                      backgroundImage: AssetImage('images/pizza.png'),
                      radius: 50,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      'RAVIE',
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink,
                          fontFamily: 'pacifico'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: emailField,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: passwordField,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: loginButton,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?"),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RegistrationScreen()));
                          },
                          child: const Text(
                            " SignUp",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.pink,
                                decoration: TextDecoration.underline),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }

// login function
  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  Fluttertoast.showToast(msg: "Login Successful"),
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HomeScreen())),
                });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be invalid.";

            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }
}
