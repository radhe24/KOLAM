import 'package:flutter/material.dart';

// import 'game_find_symmetry_screen.dart';
// import 'game_genetic_patterns_screen.dart';
// import 'game_spot_imposter_screen.dart';
// import 'game_complete_kolam_screen.dart';
// import 'leaderboard_screen.dart';

class KolamGamesScreen extends StatefulWidget {
  const KolamGamesScreen({super.key});

  @override
  State<KolamGamesScreen> createState() => _KolamGamesScreenState();
}

class _KolamGamesScreenState extends State<KolamGamesScreen> {
  final List<Map<String, dynamic>> _games = [
    {
      'id': 'find_symmetry',
      'title': 'Find the Symmetry',
      'description': 'Identify symmetrical patterns in Kolams.',
      'icon': Icons.flip_camera_android_outlined, // Placeholder
      'progress': 0.75, // Example progress (0.0 to 1.0)
      'badges': [Icons.star, Icons.star_half] // Example badges earned
    },
    {
      'id': 'genetic_patterns',
      'title': 'Genetic Patterns',
      'description': 'Evolve Kolam designs through pattern combination.',
      'icon': Icons.emoji_nature_outlined, // Placeholder
      'progress': 0.4,
      'badges': [Icons.star_border]
    },
    {
      'id': 'spot_the_imposter',
      'title': 'Spot the Imposter',
      'description': 'Find the Kolam that doesn\'t belong.',
      'icon': Icons.help_center_outlined, // Placeholder
      'progress': 0.9,
      'badges': [Icons.star, Icons.star, Icons.star]
    },
    {
      'id': 'complete_kolam',
      'title': 'Complete Kolam',
      'description': 'Finish the incomplete Kolam designs.',
      'icon': Icons.edit_note_outlined, // Placeholder
      'progress': 0.2,
      'badges': []
    },
  ];

  void _navigateToGame(String gameId, String gameTitle) {
    print("Navigate to game: $gameTitle (ID: $gameId)");
    // switch (gameId) {
    //   case 'find_symmetry':
    //     Navigator.push(context, MaterialPageRoute(builder: (context) => const FindSymmetryGameScreen()));
    //     break;
    //   // Add cases for other games
    // }
  }

  void _showLeaderboard() {
    print("Show Leaderboard (placeholder)");
    // Navigator.push(context, MaterialPageRoute(builder: (context) => const LeaderboardScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kolam Games & Challenges"),
        actions: [
          IconButton(
            icon: const Icon(Icons.leaderboard_outlined),
            onPressed: _showLeaderboard,
            tooltip: "Leaderboard",
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Or 1 for a list view, or responsive based on width
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 0.8, // Adjust for card proportions
        ),
        itemCount: _games.length,
        itemBuilder: (context, index) {
          final game = _games[index];
          return _buildGameCard(game);
        },
      ),
    );
  }

  Widget _buildGameCard(Map<String, dynamic> game) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: InkWell(
        onTap: () => _navigateToGame(game['id']!, game['title']!),
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(game['icon'] as IconData? ?? Icons.games_outlined, size: 40, color: Theme.of(context).primaryColor),
                  Row(
                    children: (game['badges'] as List<IconData>)
                        .map((badgeIcon) => Icon(badgeIcon, color: Colors.amber, size: 18))
                        .toList(),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                game['title']!,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                game['description']!,
                style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Progress: ${(game['progress'] * 100).toInt()}%"),
                  const SizedBox(height: 4),
                  LinearProgressIndicator(
                    value: game['progress'] as double,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColorDark),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// These screens should include:
// - Level selectors
// - Animated instructions
// - Timers, hints, streak badges
// - Interactive elements (drag-and-drop, tap responses)
// - Animated feedback for correct/wrong answers
// - Smooth level transitions
// - Logic for unlocking badges/rewards
// - Access to overall progress bar and leaderboard
