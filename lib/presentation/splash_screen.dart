// Importing Flutter's Cupertino package for iOS-styled widgets
import 'package:flutter/material.dart'; // Importing Flutter's material design package
import 'login.dart'; // Importing the login screen

// SplashScreen widget is stateless because it doesn't maintain any state
class SplashScreen extends StatelessWidget {
  // Custom color for the background, slightly darker than grey[900]
  @override
  Color customDarkerGrey = const Color(0xFF191919);

  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulate a delay and then navigate to the login screen
    Future.delayed(const Duration(seconds: 3), () {
      // After a 3-second delay, navigate to the LoginScreen and replace the current route
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });

    return Scaffold(
      backgroundColor: customDarkerGrey, // Set the background color of the screen
      body: Center(
        child: Image.asset(
          'assets/moon.jpeg', // Path to the splash screen image
          width: 200, // Set the width of the image
          height: 200, // Set the height of the image
        ),
      ),
    );
  }
}
