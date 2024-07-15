import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'login.dart';

class SplashScreen extends StatelessWidget {
  @override
  Color customDarkerGrey = Color(0xFF191919); // Slightly darker than grey[900]

  Widget build(BuildContext context) {
    // Simulate a delay and then navigate to the login screen
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });

    return Scaffold(
      backgroundColor: customDarkerGrey,
      body: Center(
        child: Image.asset(
          'assets/moon.jpeg',
          width: 200, // Set the width as needed
          height: 200, // Set the height as needed
        ),
      ),
    );
  }
}
