import 'package:flutter/material.dart';

import 'login_screen.dart'; // Import LoginScreen

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {"title": "Learn Kolam Heritage", "illustration": "path/to/heritage_illustration.png"},
    {"title": "Draw and Innovate", "illustration": "path/to/draw_illustration.png"},
    {"title": "Analyze and Understand Art", "illustration": "path/to/analyze_illustration.png"},
    {"title": "Play, Connect, Share", "illustration": "path/to/community_illustration.png"},
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNext() {
    if (_currentPage < onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      // Navigate to Login/Register Screen
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    }
  }

  void _onSkip() {
    // Navigate to Login/Register Screen
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: _onSkip,
                style: TextButton.styleFrom(foregroundColor: Colors.teal.shade700),
                child: const Text("Skip"),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingData.length,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (context, index) {
                  return OnboardingCard(
                    title: onboardingData[index]["title"]!,
                    illustrationPath: onboardingData[index]["illustration"]!,
                  );
                },
              ),
            ),
            // Progress Dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onboardingData.length,
                (index) => buildDot(index, context),
              ),
            ),
            const SizedBox(height: 20),
            // Next / Get Started Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _onNext,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amberAccent),
                child: Text(
                  _currentPage == onboardingData.length - 1 ? "Get Started" : "Next",
                  style: TextStyle(color: Colors.teal.shade900),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Placeholder for Progress Dot
  Widget buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: 10,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index ? Colors.amberAccent : Colors.grey,
      ),
    );
  }
}

// Placeholder for Onboarding Card UI
class OnboardingCard extends StatelessWidget {
  final String title;
  final String illustrationPath;

  const OnboardingCard({
    super.key,
    required this.title,
    required this.illustrationPath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Image.asset(illustrationPath, height: 200), // Placeholder
          Icon(Icons.image, size: 150, color: Colors.grey[400]), // Placeholder
          const SizedBox(height: 30),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
