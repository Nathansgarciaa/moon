import 'package:flutter/material.dart'; // Importing Flutter's material design package
import 'presentation/views/splash_screen.dart'; // Importing the splash screen
import 'presentation/views/login.dart'; // Importing the login screen
import 'presentation/views/registration_screen.dart'; // Importing the registration screen
import 'presentation/views/home_screen.dart'; // Importing the home screen
import 'data/configs/firebase_options.dart'; // Importing Firebase options for configuration
import 'package:firebase_core/firebase_core.dart'; // Importing Firebase core package
import 'presentation/views/api_screen.dart'; // Importing the API screen

// Main function to initialize the app
void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures that all widgets are initialized before running the app
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Initializes Firebase with the platform-specific options
  );
  runApp(const MyApp()); // Runs the MyApp widget
}

// Root widget of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App', // Title of the app
      theme: ThemeData(
        primarySwatch: Colors.blue, // Setting the primary color theme of the app
      ),
      home: SplashScreen(), // The initial screen of the app
      routes: {
        '/login': (context) => LoginScreen(), // Route for the login screen
        '/register': (context) => RegistrationScreen(), // Route for the registration screen
        '/home': (context) => const HomeScreen(), // Route for the home screen
        '/api': (context) => const ApiScreen(), // Route for the API screen
      },
    );
  }
}
