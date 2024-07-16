import 'package:flutter/material.dart'; // Importing Flutter's material design package
import 'package:firebase_auth/firebase_auth.dart'; // Importing Firebase Authentication package

// HomeScreen widget is stateless because it doesn't maintain any state
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold provides a structure for the basic material design visual layout
      appBar: AppBar(
        title: const Text('Home Screen'), // Title of the AppBar
        backgroundColor: Colors.grey[850], // Background color of the AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding around the body content
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center elements vertically
          crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch elements to fill horizontal space
          children: [
            const Spacer(), // Spacer pushes the following widgets to the top
            ElevatedButton(
              onPressed: () {
                // Handle Dio button tap
                Navigator.pushReplacementNamed(context, '/api'); // Navigate to the API screen
              }, // Text on the button
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[850], // Button background color
                foregroundColor: Colors.white, // Button text color
                padding: const EdgeInsets.symmetric(vertical: 16), // Padding inside the button
              ),
              child: const Text('Dio'),
            ),
            const SizedBox(height: 20), // Space between the two buttons
            const Spacer(), // Spacer pushes the logout button to the bottom
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut(); // Sign out the user from Firebase
                Navigator.pushReplacementNamed(context, '/login'); // Navigate to the login screen
              }, // Text on the logout button
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Button background color
                foregroundColor: Colors.white, // Button text color
                padding: const EdgeInsets.symmetric(vertical: 8), // Padding inside the button
              ),
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
