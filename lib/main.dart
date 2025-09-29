import 'package:flutter/material.dart';
import 'splash_screen.dart'; // Import the SplashScreen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Suvarna Rekha', // Updated title
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal), // Changed seedColor to teal
        useMaterial3: true, // It's good practice to explicitly set useMaterial3
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.teal[700], // Vibrant darker teal for AppBar
          foregroundColor: Colors.white, // White text and icons on AppBar
        ),
      ),
      home: SplashScreen(), // Set SplashScreen as the home
      debugShowCheckedModeBanner: false, // Optionally remove debug banner
    );
  }
}
