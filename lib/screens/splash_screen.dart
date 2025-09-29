import 'package:flutter/material.dart';
import 'dart:async'; // For Timer

import 'onboarding_screen.dart'; // Import OnboardingScreen

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      if (mounted) { // Check if the widget is still in the tree
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Background Gradient and Kolam Pattern
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal.shade700, Colors.teal.shade200, Colors.amberAccent.shade100],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Center Content: Logo, Tagline, Loading Indicator
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Display the Suvarna Rekha Logo
              Image.asset(
                'assets/images/logo.png', 
                height: 150.0, // Adjust height as needed, consider width too
                // You might want to add errorBuilder for robustness:
                // errorBuilder: (context, error, stackTrace) {
                //   return const Icon(Icons.broken_image, size: 100); // Placeholder on error
                // },
              ),
              const SizedBox(height: 24.0),
              const Text(
                "Discover, Create, Connect",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Changed to white for better contrast on new gradient
                ),
              ),
              const SizedBox(height: 48.0),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
