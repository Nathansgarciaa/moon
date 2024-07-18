import 'package:flutter/material.dart';
import 'features/authentication/presentation/screens/splash_screen.dart';
import 'features/authentication/presentation/screens/login.dart';
import 'features/authentication/presentation/screens/registration_screen.dart';
import 'features/authentication/presentation/screens/home_screen.dart';
import 'core/configs/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import '/features/get_products/presentation/screens/api_screen.dart';
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
      home: const SplashScreen(), // The initial screen of the app
      routes: {
        '/login': (context) => LoginScreen(), // Route for the login screen
        '/register': (context) =>  RegistrationScreen(), // Route for the registration screen
        '/home': (context) => const HomeScreen(), // Route for the home screen
        '/api': (context) => const ApiScreen(), // Route for the API screen
      },
    );
  }
}
