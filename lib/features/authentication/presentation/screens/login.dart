import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';
import '../controllers/authentication_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';

// LoginScreen widget is stateless because it doesn't maintain any state
class LoginScreen extends StatelessWidget {
  // Controllers to handle text input for email and password fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final Color customDarkerGrey = const Color(0xFF191919);

  LoginScreen({super.key}); // Custom color for background

  // Function to handle login logic
  Future<void> _login(BuildContext context) async {
    // Adding a login event to the BLoC with the provided email and password
    BlocProvider.of<AuthBloc>(context).add(
      LoginEvent(
        emailController.text,
        passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // Get screen width for responsive design
    return Scaffold(
      backgroundColor: customDarkerGrey, // Set custom background color
      body: BlocProvider(
        create: (context) => AuthBloc(FirebaseAuth.instance), // Provide the AuthBloc to the widget tree
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            // Listen to state changes and handle navigation and error messages
            if (state is AuthAuthenticated) {
              // Navigate to home screen if authenticated
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            } else if (state is AuthError) {
              // Show error message if authentication fails
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthLoading) {
                // Show a loading indicator while authentication is in progress
                return const Center(child: CircularProgressIndicator());
              }
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0), // Padding around the content
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch children to fill horizontal space
                      children: [
                      const SizedBox(height: 50), // Space at the top
                  Image.asset(
                      'assets/login.jpeg', // Main image for the login screen

                  height: 200, // Set image height
                  width: screenWidth, // Set image width to screen width
                  fit: BoxFit.cover, // Cover the entire width with the image
                ),
                const SizedBox(height: 20), // Space between image and buttons
                Row(
                  children: [
                    // Google login button
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Handle Google login
                        },
                        icon: Image.asset('assets/google_logo.jpg', height: 24), // Google logo
                        label: const Text('Log in'), // Button label
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[850], // Button background color
                          foregroundColor: Colors.white, // Button text color
                        ),
                      ),
                    ),
                    const SizedBox(width: 10), // Space between Google and Facebook buttons
                    // Facebook login button
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Handle Facebook login
                        },
                        icon: Image.asset('assets/facebook_logo.png', height: 24), // Facebook logo
                        label: const Text('Log in'), // Button label
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[850], // Button background color
                          foregroundColor: Colors.white, // Button text color
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20), // Space between buttons and text
                const Text(
                  'or continue with',
                  textAlign: TextAlign.center, // Center-align the text
                  style: TextStyle(color: Colors.white), // Text color
                ),
                const SizedBox(height: 20), // Space between text and email field
                // Email input field
                TextField(
                  controller: emailController, // Controller for email input
                  decoration: InputDecoration(
                    labelText: 'Email', // Label for the email field
                    labelStyle: const TextStyle(color: Colors.grey), // Label text color
                    filled: true, // Fill the background
                    fillColor: Colors.white, // Background color
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0), // Rounded corners
                    ),
                  ),
                  style: const TextStyle(color: Colors.grey), // Input text color
                ),
                const SizedBox(height: 20), // Space between email and password fields
                // Password input field
                TextField(
                  controller: passwordController, // Controller for password input
                  decoration: InputDecoration(
                    labelText: 'Password', // Label for the password field
                    labelStyle: const TextStyle(color: Colors.grey), // Label text color
                    filled: true, // Fill the background
                    fillColor: Colors.white, // Background color
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0), // Rounded corners
                    ),
                  ),
                  obscureText: true, // Hide the password text
                  style: const TextStyle(color: Colors.grey), // Input text color
                ),
                const SizedBox(height: 20), // Space between password field and "Remember me" row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between the children
                  children: [
                    // "Remember me" checkbox
                    Checkbox(
                      value: true, // Initial value of the checkbox
                      onChanged: (bool? newValue) {
                        // Handle checkbox change
                      },
                    ),
                    const Text(
                      'Remember me', // Checkbox label
                      style: TextStyle(color: Colors.white), // Text color
                    ),
                    const Spacer(), // Spacer to push the "Forgot your password?" to the right
                    // "Forgot your password?" button
                    TextButton(
                      onPressed: () {
                        // Handle "Forgot your password?" tap
                      },
                      child: const Text(
                        'Forgot your password?', // Button label
                        style: TextStyle(color: Colors.white), // Text color
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20), // Space between "Remember me" row and login button
                // Login button
                ElevatedButton(
                  onPressed: () {
                    _login(context); // Call login function
                  }, // Button label
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[850], // Button background color
                    foregroundColor: Colors.white, // Button text color
                    padding: const EdgeInsets.symmetric(vertical: 16), // Padding inside the button
                  ),
                  child: const Text('Log in'),
                ),
                const SizedBox(height: 20), // Space between login button and "Sign up" button
                Center(
                  // "Sign up" button
                  child: TextButton(
                    onPressed: () {
                      // Navigate to registration screen
                      Navigator.pushNamed(context, '/register');
                    },
                    child: const Text(
                      'Don\'t have an account? Sign up', // Button label
                      style: TextStyle(color: Colors.white), // Text color
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