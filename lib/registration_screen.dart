import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _register(BuildContext context) async {
    print("Register button pressed"); // Debug print
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // Handle successful registration
      print('Registration successful');
      Navigator.pushNamed(context, '/home'); // Navigate to HomeScreen
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException caught: ${e.code}'); // Print the exact error code
      print('Error message: ${e.message}');
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else {
        print('Error: ${e.message}'); // Print the error message for other cases
      }
    } catch (e) {
      print('General exception caught: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900], // Darker grey background for the entire screen
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 50),
              Image.asset(
                'assets/login.jpeg', // Your main image
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Handle Google registration
                      },
                      icon: Image.asset('assets/google_logo.jpg', height: 24),
                      label: Text('Register'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[850], // Dark grey button color
                        foregroundColor: Colors.white, // Text color
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Handle Facebook registration
                      },
                      icon: Image.asset('assets/facebook_logo.png', height: 24),
                      label: Text('Register'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[850], // Dark grey button color
                        foregroundColor: Colors.white, // Text color
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'or continue with',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  labelStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  labelStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 20),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                obscureText: true,
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Checkbox(
                    value: true, // This should be a state variable
                    onChanged: (bool? newValue) {
                      // Handle checkbox state change
                    },
                  ),
                  Text(
                    'Remember me',
                    style: TextStyle(color: Colors.white),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      // Handle "Forgot your password?" tap
                    },
                    child: Text(
                      'Forgot your password?',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  print("Register button clicked"); // Debug print
                  _register(context);
                },
                child: Text('Register'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[850],
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: () {
                    // Navigate to login screen
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text(
                    'Already have an account? Sign in',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
