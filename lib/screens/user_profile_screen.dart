import 'package:flutter/material.dart';

// import '../models/user_data_model.dart';
// import '../models/kolam_design_model.dart';

class UserProfileScreen extends StatefulWidget {
  final String? userId; // Optional: for viewing other users' profiles

  const UserProfileScreen({super.key, this.userId});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  String _userName = "Saraswati Devi"; // Placeholder
  String _userAvatarUrl = "https://via.placeholder.com/150/4CAF50/FFFFFF?Text=SD"; // Placeholder
  int _achievementStars = 4; // Placeholder
  List<String> _badges = ["Kolam Master", "Creative Hand", "Daily Dabbler"]; // Placeholder badge names

  final List<Map<String, String>> _savedKolams = List.generate(8, (i) => {'id': 'k$i', 'title': 'My Kolam ${i+1}', 'thumbnailUrl': 'https://picsum.photos/seed/${i+100}/200/200'});
  final List<Map<String, String>> _gameStats = List.generate(3, (i) => {'gameName': 'Game ${i+1}', 'score': '${(i+1)*1500}', 'rank': '#${10-i}'});
  final List<String> _milestones = ["Joined Community", "Shared 10 Kolams", "Won a Contest"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this); // Designs, Games, Milestones, Stats
    if (widget.userId != null) {
      print("Loading profile for user: ${widget.userId}");
      // _userName = "Another User"; // Update with fetched data
    } else {
      print("Loading current user's profile");
    }
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  void _editProfile() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets, // Handles keyboard overlap
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text("Edit Profile", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              TextFormField(initialValue: _userName, decoration: const InputDecoration(labelText: "Name")),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: () { Navigator.pop(context); }, child: const Text("Save Changes")),
            ],
          ),
        ),
      ),
    );
    print("Edit Profile button pressed (placeholder)");
  }

  @override
  Widget build(BuildContext context) {
    bool isOwnProfile = widget.userId == null; // Determine if it's the current user's profile

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 220.0, // Adjust as needed
              floating: false,
              pinned: true,
              elevation: 2.0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(_userName, style: const TextStyle(fontSize: 16.0, shadows: [Shadow(blurRadius: 2.0)])), // Title visible when collapsed
                background: _buildProfileHeader(isOwnProfile),
              ),
              actions: [
                if (isOwnProfile)
                  IconButton(icon: const Icon(Icons.edit_outlined), onPressed: _editProfile, tooltip: "Edit Profile"),
              ],
            ),
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                TabBar(
                  controller: _tabController,
                  labelColor: Theme.of(context).primaryColor,
                  unselectedLabelColor: Colors.grey,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: const [
                    Tab(text: "Designs"),
                    Tab(text: "Games"),
                    Tab(text: "Milestones"),
                    Tab(text: "Stats"),
                  ],
                ),
              ),
              pinned: true,
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildDesignsTab(),
            _buildGameStatsTab(),
            _buildMilestonesTab(),
            _buildGenericStatsTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(bool isOwnProfile) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: kToolbarHeight, left: 16.0, right: 16.0, bottom: 50.0), // Adjust bottom padding for tab bar space
        child: Row(
          children: <Widget>[
            // Avatar
            Stack(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(_userAvatarUrl),
                ),
                if (isOwnProfile)
                  Positioned(
                    bottom: 0, right: 0,
                    child: GestureDetector(
                      onTap: _editProfile, // Or a specific avatar change function
                      child: const CircleAvatar(radius: 14, child: Icon(Icons.edit, size: 16)),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(_userName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)), // Ensure contrast if background is image
                  const SizedBox(height: 4.0),
                  Row(
                    children: List.generate(5, (index) => Icon(
                      index < _achievementStars ? Icons.star : Icons.star_border,
                      color: Colors.amber, size: 20,
                    )),
                  ),
                  const SizedBox(height: 8.0),
                  Wrap(
                    spacing: 6.0,
                    runSpacing: 4.0,
                    children: _badges.map((badge) => Chip(label: Text(badge, style: const TextStyle(fontSize: 10)), padding: EdgeInsets.zero)).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesignsTab() {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 8.0, mainAxisSpacing: 8.0),
      itemCount: _savedKolams.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () { print("Tapped on Kolam: ${_savedKolams[index]['title']}"); },
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Image.network(_savedKolams[index]['thumbnailUrl']!, fit: BoxFit.cover, width: double.infinity)), 
                Padding(padding: const EdgeInsets.all(4.0), child: Text(_savedKolams[index]['title']!, style: const TextStyle(fontSize: 12), overflow: TextOverflow.ellipsis)),
              ]
            ),
          ),
        );
      },
    );
  }

  Widget _buildGameStatsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: _gameStats.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          child: ListTile(
            leading: const Icon(Icons.sports_esports_outlined), // Placeholder icon
            title: Text(_gameStats[index]['gameName']!),
            subtitle: Text("Score: ${_gameStats[index]['score']} - Rank: ${_gameStats[index]['rank']}"),
            onTap: () { print("Tapped on game: ${_gameStats[index]['gameName']}"); },
          ),
        );
      },
    );
  }

  Widget _buildMilestonesTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: _milestones.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          child: ListTile(
            leading: const Icon(Icons.emoji_events_outlined), // Placeholder icon
            title: Text(_milestones[index]),
            onTap: () {  },
          ),
        );
      },
    );
  }

  Widget _buildGenericStatsTab() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text("Other statistics like total likes received, designs shared, challenges completed, etc. will be displayed here.", textAlign: TextAlign.center),
      ),
    );
  }
}

// Helper class for SliverAppBar TabBar
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);
  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor, // Or AppBar color
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
