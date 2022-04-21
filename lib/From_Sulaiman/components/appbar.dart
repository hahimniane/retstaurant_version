import 'package:flutter/material.dart';

import '../screens/login_screen.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    actions: [
      IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginScreen()));
          },
          icon: const Icon(Icons.lock))
    ],
    backgroundColor: Colors.pink,
    title: const Text(
      'Restaurant App',
      style: TextStyle(
          color: Colors.white, fontSize: 24.00, fontWeight: FontWeight.bold),
    ),
    centerTitle: true,
    // leading: const Icon(Icons.notifications),
  );
}
