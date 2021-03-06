import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_version/services/firbase.dart';
import 'package:restaurant_version/components/methods.dart';

class ResetPasswordPage extends StatelessWidget {
  ResetPasswordPage({Key? key}) : super(key: key);
  TextEditingController userNameOrEmail = TextEditingController();
  FirebaseAthentications firebaseAthentications = FirebaseAthentications();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: GoogleFonts.alata(
            textStyle: const TextStyle(
                color: Colors.white,
                letterSpacing: .20,
                fontWeight: FontWeight.w900),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.02,
            ),
            buildTextField(
                width, height, 'Username/E-mail', 0.070, userNameOrEmail),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: SizedBox(
                child: buildTextButton(() async {
                  firebaseAthentications.resetPassword(userNameOrEmail.text);
                }, const Color(0xff2ACB81), 'SEND'),
                width: width * 0.95,
                height: height * 0.054,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
