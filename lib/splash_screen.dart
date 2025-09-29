import 'package:flutter/material.dart';
import 'dart:async';
import 'screens/home_screen.dart'; // Ensure HomeScreen is imported
// import 'screens/login_screen.dart'; // LoginScreen import removed

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  // Logo Animations
  late Animation<double> _logoFadeAnimation;
  late Animation<double> _logoScaleAnimation;

  // Tagline Animations
  late Animation<double> _discoverFadeAnimation;
  late Animation<double> _discoverScaleAnimation;
  late Animation<double> _createFadeAnimation;
  late Animation<double> _createScaleAnimation;
  late Animation<double> _connectFadeAnimation;
  late Animation<double> _connectScaleAnimation;

  @override
  void initState() {
    super.initState();

    const int animationDurationMillis = 2500; // Total duration for entry animations
    const int splashScreenTotalDurationMillis = animationDurationMillis + 1000; // Animation + pause

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: animationDurationMillis),
    );

    // Logo animations (first 50% of duration)
    _logoFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );
    _logoScaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
      ),
    );

    // Tagline "Discover" (30% to 70% of duration)
    _discoverFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 0.7, curve: Curves.easeIn),
      ),
    );
    _discoverScaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 0.75, curve: Curves.easeOutBack),
      ),
    );

    // Tagline "Create" (45% to 85% of duration)
    _createFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.45, 0.85, curve: Curves.easeIn),
      ),
    );
    _createScaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.45, 0.90, curve: Curves.easeOutBack),
      ),
    );

    // Tagline "Connect" (60% to 100% of duration)
    _connectFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.60, 1.0, curve: Curves.easeIn),
      ),
    );
    _connectScaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.60, 1.0, curve: Curves.easeOutBack),
      ),
    );

    _animationController.forward();

    Timer(
      const Duration(milliseconds: splashScreenTotalDurationMillis),
      () {
        if (mounted) {
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(), // Navigate to HomeScreen
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
              transitionDuration: const Duration(milliseconds: 700), 
            ),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color(0xFF8C3B0C).withOpacity(0.9), const Color(0xFF5A0000)], // Deep Amber to Maroon
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            // --- Optional Watermark (Uncomment and provide path if you have one) ---
            // Center(
            //   child: Opacity(
            //     opacity: 0.05, // Very faint
            //     child: Image.asset(
            //       'assets/images/mandala_watermark.png', // Replace with your watermark image path
            //       fit: BoxFit.contain, 
            //       width: MediaQuery.of(context).size.width * 0.8,
            //       height: MediaQuery.of(context).size.height * 0.8,
            //     ),
            //   ),
            // ),
            // --- Main Content ---
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Animated Logo with Glow
                  ScaleTransition(
                    scale: _logoScaleAnimation,
                    child: FadeTransition(
                      opacity: _logoFadeAnimation,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle, 
                          boxShadow: [
                            BoxShadow(
                              color: Colors.amber.withOpacity(0.5), 
                              blurRadius: 25.0,
                              spreadRadius: 5.0,
                            ),
                          ],
                        ),
                        child: ClipOval( 
                          child: Image.asset(
                            'assets/images/splashscreen.png', 
                            height: 140.0, 
                            width: 140.0,
                            fit: BoxFit.cover, 
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 35.0),
                  // Animated Tagline
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildAnimatedTaglineWord("Discover", _discoverFadeAnimation, _discoverScaleAnimation),
                      const SizedBox(width: 10),
                      _buildAnimatedTaglineWord("Create", _createFadeAnimation, _createScaleAnimation),
                      const SizedBox(width: 10),
                      _buildAnimatedTaglineWord("Connect", _connectFadeAnimation, _connectScaleAnimation),
                    ],
                  ),
                  const SizedBox(height: 50.0),
                  FadeTransition(
                    opacity: _logoFadeAnimation, 
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white70),
                      strokeWidth: 2.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedTaglineWord(String word, Animation<double> fadeAnim, Animation<double> scaleAnim) {
    return ScaleTransition(
      scale: scaleAnim,
      child: FadeTransition(
        opacity: fadeAnim,
        child: Text(
          word,
          style: TextStyle(
            fontSize: 22.0, 
            fontWeight: FontWeight.w500,
            color: Colors.white.withOpacity(0.85),
            shadows: [
              Shadow(
                blurRadius: 2.0,
                color: Colors.black.withOpacity(0.2),
                offset: const Offset(1, 1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
