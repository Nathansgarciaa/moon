import 'package:flutter/material.dart'; // Importing Flutter's material design package
import 'login.dart'; // Importing the login screen

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  final Color customDarkerGrey = const Color(0xFF191919);
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    // Simulate a delay and then navigate to the login screen
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildCircle(Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 2.0),
          width: animation.value * 10 + 5,
          height: animation.value * 10 + 5,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customDarkerGrey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              width: 200,
              height: 200,
              duration: Duration(seconds: 2),
              curve: Curves.easeInOut,
              child: Image.asset(
                'assets/moon.jpeg',
                width: 200,
                height: 200,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Loading...',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildCircle(_animation),
                buildCircle(Tween(begin: 0.2, end: 1.0).animate(_controller)),
                buildCircle(Tween(begin: 0.4, end: 1.0).animate(_controller)),
                buildCircle(Tween(begin: 0.6, end: 1.0).animate(_controller)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
