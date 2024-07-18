import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  double _dioButtonOpacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        backgroundColor: Colors.grey[850],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.grey[900]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Center(
                child: Icon(
                  Icons.nightlight_round,
                  size: 100,
                  color: Colors.yellow[700],
                ),
              ),
              const SizedBox(height: 40),
              AnimatedOpacity(
                opacity: _dioButtonOpacity,
                duration: Duration(seconds: 1),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _dioButtonOpacity = _dioButtonOpacity == 1.0 ? 0.5 : 1.0;
                    });
                    Navigator.pushReplacementNamed(context, '/api');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[850],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Dio'),
                ),
              ),
              const SizedBox(height: 20),
              const Spacer(),
              ElevatedButton(
                onPressed: () async {
                  await signOut();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }
}
