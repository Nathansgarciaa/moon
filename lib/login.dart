import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'registration_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'home_screen.dart';
import 'authentification_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final Color customDarkerGrey = Color(0xFF191919);

  Future<void> _login(BuildContext context) async {
    BlocProvider.of<AuthBloc>(context).add(
      LoginEvent(
        emailController.text,
        passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: customDarkerGrey,
      body: BlocProvider(
        create: (context) => AuthBloc(FirebaseAuth.instance),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthAuthenticated) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthLoading) {
                return Center(child: CircularProgressIndicator());
              }
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 50),
                      Image.asset(
                        'assets/login.jpeg', // Your main image
                        height: 200,
                        width: screenWidth,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 20),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                // Handle Google login
                              },
                              icon: Image.asset('assets/google_logo.jpg', height: 24),
                              label: Text('Log in'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[850], // Button color
                                foregroundColor: Colors.white, // Text color
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                // Handle Facebook login
                              },
                              icon: Image.asset('assets/facebook_logo.png', height: 24),
                              label: Text('Log in'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[850], // Button color
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
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
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
                            value: true,
                            onChanged: (bool? newValue) {
                              // Your code here
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
                          _login(context);
                        },
                        child: Text('Log in'),
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
                            // Navigate to registration screen
                            Navigator.pushNamed(context, '/register');
                          },
                          child: Text(
                            'Don\'t have an account? Sign up',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
