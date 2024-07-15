import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class AuthChecker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    // Check if the user is null
    if (user == null) {
      // User is not logged in, navigate to LoginScreen
      return LoginScreen();
    } else {
      // User is logged in, navigate to HomeScreen
      return HomeScreen();
    }
  }
}
