import 'package:flutter/material.dart';

import 'explore_heritage_screen.dart';
import 'capture_upload_screen.dart';
import 'kolam_recreator_screen.dart';
import 'kolam_games_screen.dart';
import 'user_profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _bottomNavIndex = 0;

  static const Color _yellowCardColor = Color(0xFFFACC15);
  static const Color _greenCardColor = Color(0xFF15803D);
  static const Color _redCardColor = Color(0xFFDC2626);
  static const Color _blueCardColor = Color(0xFF2563EB);
  static const Color _creamBackgroundColor = Color(0xFFFFF8E1); // Light cream

  // Define fixed card size
  static const double _cardWidth = 160.0;
  static const double _cardHeight = 160.0;
  static const double _cardSpacing = 20.0;
  static const double _screenPadding = 20.0;


  void _navigateToFeature(String featureName) {
    if (!mounted) return;
    Widget? screen;
    switch (featureName) {
      case "Explore Kolam Heritage":
        screen = const ExploreHeritageScreen();
        break;
      case "Capture or Upload Kolam":
        screen = const CaptureUploadScreen();
        break;
      case "Create Your Kolam":
      case "Quick Kolam Creation":
        screen = const KolamRecreatorScreen();
        break;
      case "Play Kolam Games":
        screen = const KolamGamesScreen();
        break;
    }
    if (screen != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => screen!));
    } else {
      print("Navigate to $featureName (placeholder or undefined)");
    }
  }

  void _onBottomNavItemTapped(int index) {
    if (!mounted) return;
    setState(() {
      _bottomNavIndex = index;
    });
    Widget? screen;
    switch (index) {
      case 0:
        print("Home Tapped");
        break;
      case 1:
        print("Search Tapped (placeholder)");
        break;
      case 2:
        _navigateToFeature("Quick Kolam Creation");
        return;
      case 3:
        print("Gallery Tapped (CommunityGalleryScreen removed)");
        break;
      case 4:
        screen = const UserProfileScreen();
        break;
    }
    if (screen != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => screen!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _creamBackgroundColor, // Fallback background color
      appBar: AppBar(
        title: const Text("Suvarna Rekha"),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor, // Keep themed AppBar
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
      ),
      body: Container( // Main container for background image
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/homebg.jpg'), 
            fit: BoxFit.cover, // Ensure it covers the area
          ),
        ),
        child: Container( // This container provides the lightening effect
          color: Colors.white.withOpacity(0.4), // Adjust opacity as needed (0.0 to 1.0)
          child: Center( // Existing Center widget now child of the overlay
            child: Padding(
              padding: const EdgeInsets.all(_screenPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Center the Rows vertically
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center, // Center cards horizontally
                    children: <Widget>[
                      _buildFeatureCard(
                        title: "Explore Kolam Heritage",
                        iconData: Icons.explore_outlined,
                        color: _yellowCardColor,
                        onTap: () => _navigateToFeature("Explore Kolam Heritage"),
                      ),
                      SizedBox(width: _cardSpacing),
                      _buildFeatureCard(
                        title: "Capture or Upload Kolam",
                        iconData: Icons.camera_alt_outlined,
                        color: _greenCardColor,
                        onTap: () => _navigateToFeature("Capture or Upload Kolam"),
                      ),
                    ],
                  ),
                  SizedBox(height: _cardSpacing),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center, // Center cards horizontally
                    children: <Widget>[
                      _buildFeatureCard(
                        title: "Create Your Kolam",
                        iconData: Icons.palette_outlined,
                        color: _redCardColor,
                        onTap: () => _navigateToFeature("Create Your Kolam"),
                      ),
                      SizedBox(width: _cardSpacing),
                      _buildFeatureCard(
                        title: "Play Kolam Games",
                        iconData: Icons.sports_esports_outlined,
                        color: _blueCardColor,
                        onTap: () => _navigateToFeature("Play Kolam Games"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToFeature("Quick Kolam Creation"),
        child: const Icon(Icons.add_photo_alternate_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline), label: 'Add'),
          BottomNavigationBarItem(icon: Icon(Icons.photo_library_outlined), label: 'Gallery'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
        currentIndex: _bottomNavIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: _onBottomNavItemTapped,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
      ),
    );
  }

  Widget _buildFeatureCard({
    required String title,
    required IconData iconData,
    required Color color,
    required VoidCallback onTap,
  }) {
    return SizedBox( // Fixed size for the card
      width: _cardWidth,
      height: _cardHeight,
      child: InkWell(
        onTap: onTap,
        child: Card(
          elevation: 3.0, // Subtle shadow
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)), // Nicely rounded
          color: color,
          child: Padding(
            padding: const EdgeInsets.all(12.0), // Padding within the card
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
              crossAxisAlignment: CrossAxisAlignment.center, // Center content horizontally
              children: <Widget>[
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 15.0, // Adjusted for smaller card
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10.0), // Space between text and icon
                Icon(
                  iconData,
                  size: 36.0, // Adjusted for smaller card
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
