import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/splash.jpg', // Ensure you have an image in the assets folder
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
