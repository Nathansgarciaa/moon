import 'package:flutter/material.dart'; // Importing Flutter's material design package
import 'package:firebase_auth/firebase_auth.dart'; // Importing Firebase Authentication package
import 'package:flutter_bloc/flutter_bloc.dart'; // Importing Flutter BLoC package
import '../../domain/bloc/auth/authentification_bloc.dart'; // Importing the authentication BLoC

// RegistrationScreen widget is stateless because it doesn't maintain any state
class RegistrationScreen extends StatelessWidget {
  // Controllers to handle text input for name, email, and password fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RegistrationScreen({super.key});

  // Function to handle registration logic
  Future<void> _register(BuildContext context) async {
    print("Register button pressed"); // Debug print
    // Adding a registration event to the BLoC with the provided email and password
    BlocProvider.of<AuthBloc>(context).add(
      RegisterEvent(
        emailController.text,
        passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900], // Darker grey background for the entire screen
      body: BlocProvider(
        create: (context) => AuthBloc(FirebaseAuth.instance), // Provide the AuthBloc to the widget tree
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            // Listen to state changes and handle navigation and error messages
            if (state is AuthAuthenticated) {
              Navigator.pushReplacementNamed(context, '/home'); // Navigate to HomeScreen if authenticated
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)), // Show error message if registration fails
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
                        'assets/login.jpeg', // Main image for the registration screen
                        width: double.infinity, // Set image width to fill the parent
                        height: 200, // Set image height
                        fit: BoxFit.cover, // Cover the entire width with the image
                      ),
                      const SizedBox(height: 20), // Space between image and buttons
                      Row(
                        children: [
                          // Google registration button
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                // Handle Google registration
                              },
                              icon: Image.asset('assets/google_logo.jpg', height: 24), // Google logo
                              label: const Text('Register'), // Button label
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[850], // Dark grey button color
                                foregroundColor: Colors.white, // Text color
                              ),
                            ),
                          ),
                          const SizedBox(width: 10), // Space between Google and Facebook buttons
                          // Facebook registration button
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                // Handle Facebook registration
                              },
                              icon: Image.asset('assets/facebook_logo.png', height: 24), // Facebook logo
                              label: const Text('Register'), // Button label
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[850], // Dark grey button color
                                foregroundColor: Colors.white, // Text color
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
                      const SizedBox(height: 20), // Space between text and name field
                      // Name input field
                      TextField(
                        controller: nameController, // Controller for name input
                        decoration: InputDecoration(
                          labelText: 'Full Name', // Label for the name field
                          labelStyle: const TextStyle(color: Colors.grey), // Label text color
                          filled: true, // Fill the background
                          fillColor: Colors.white, // Background color
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0), // Rounded corners
                          ),
                        ),
                        style: const TextStyle(color: Colors.grey), // Input text color
                      ),
                      const SizedBox(height: 20), // Space between name and email fields
                      // Email input field
                      TextField(
                        controller: emailController, // Controller for email input
                        decoration: InputDecoration(
                          labelText: 'E-mail', // Label for the email field
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
                            value: true, // This should be a state variable
                            onChanged: (bool? newValue) {
                              // Handle checkbox state change
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
                      const SizedBox(height: 20), // Space between "Remember me" row and register button
                      // Register button
                      ElevatedButton(
                        onPressed: () {
                          print("Register button clicked"); // Debug print
                          _register(context); // Call register function
                        }, // Button label
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[850], // Button background color
                          foregroundColor: Colors.white, // Button text color
                          padding: const EdgeInsets.symmetric(vertical: 16), // Padding inside the button
                        ),
                        child: const Text('Register'),
                      ),
                      const SizedBox(height: 20), // Space between register button and "Sign in" button
                      Center(
                        // "Sign in" button
                        child: TextButton(
                          onPressed: () {
                            // Navigate to login screen
                            Navigator.pushNamed(context, '/login');
                          },
                          child: const Text(
                            'Already have an account? Sign in', // Button label
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
