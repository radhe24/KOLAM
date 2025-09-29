import 'package:flutter/material.dart';

// import 'login_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkModeEnabled = false;
  bool _areNotificationsEnabled = true;

  void _toggleDarkMode(bool value) {
    setState(() {
      _isDarkModeEnabled = value;
    });
    print("Dark Mode: ${_isDarkModeEnabled ? 'ON' : 'OFF'}");
  }

  void _toggleNotifications(bool value) {
    setState(() {
      _areNotificationsEnabled = value;
    });
    print("Notifications: ${_areNotificationsEnabled ? 'ON' : 'OFF'}");
  }

  void _navigateToAccountSettings() {
    print("Navigate to Account Settings (placeholder)");
    _showInfoDialog("Account Settings", "Account-specific settings like email, password change, linked accounts would be here.");
  }

  void _navigateToPrivacySettings() {
    print("Navigate to Privacy Settings (placeholder)");
     _showInfoDialog("Privacy Settings", "Detailed privacy controls, data management, and terms of service would be accessible here.");
  }

  void _showHelpDialog() {
    print("Show Help dialog (placeholder)");
    _showInfoDialog("Help & Support", "FAQs, contact support, tutorials, and app version information would be found here.");
  }

  void _showAboutDialog() {
    print("Show About dialog (placeholder)");
    _showInfoDialog("About Suvarna Rekha", "App version, credits, licenses, and links to our website or social media.");
  }

  void _showFeedbackForm() {
    print("Show Feedback Form (placeholder)");
    _showInfoDialog("Submit Feedback", "A form or link to submit feedback, report bugs, or suggest features.");
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Logout"),
          content: const Text("Are you sure you want to log out?"),
          actions: <Widget>[
            TextButton(child: const Text("Cancel"), onPressed: () => Navigator.of(context).pop()),
            TextButton(
              child: const Text("Logout"),
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                print("User logged out (placeholder)");
                // Navigator.of(context).pushAndRemoveUntil(
                //   MaterialPageRoute(builder: (context) => const LoginScreen()), 
                //   (Route<dynamic> route) => false, // Remove all previous routes
                // );
              },
            ),
          ],
        );
      },
    );
  }
  
  void _showInfoDialog(String title, String content) { // Helper for placeholder actions
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text("OK"))],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        children: <Widget>[
          _buildSettingsSectionTitle(context, "Preferences"),
          SwitchListTile(
            title: const Text("Dark Mode"),
            value: _isDarkModeEnabled,
            onChanged: _toggleDarkMode,
            secondary: const Icon(Icons.dark_mode_outlined), // Kolam icon placeholder
          ),
          SwitchListTile(
            title: const Text("Enable Notifications"),
            value: _areNotificationsEnabled,
            onChanged: _toggleNotifications,
            secondary: const Icon(Icons.notifications_active_outlined), // Kolam icon placeholder
          ),
          
          _buildSettingsSectionTitle(context, "Account & Privacy"),
          _buildSettingsTile(icon: Icons.account_circle_outlined, title: "Account", onTap: _navigateToAccountSettings),
          _buildSettingsTile(icon: Icons.privacy_tip_outlined, title: "Privacy", onTap: _navigateToPrivacySettings),
          _buildSettingsTile(icon: Icons.accessibility_new_outlined, title: "Accessibility", onTap: () {
             print("Accessibility options (placeholder)");
            _showInfoDialog("Accessibility", "Text size, contrast, and other accessibility features would be configured here.");
          }),

          _buildSettingsSectionTitle(context, "Support & Feedback"),
          _buildSettingsTile(icon: Icons.help_outline, title: "Help & Support", onTap: _showHelpDialog),
          _buildSettingsTile(icon: Icons.info_outline, title: "About Suvarna Rekha", onTap: _showAboutDialog),
          _buildSettingsTile(icon: Icons.feedback_outlined, title: "Send Feedback", onTap: _showFeedbackForm),
          
          const Divider(height: 32.0, thickness: 1),
          _buildSettingsTile(
            icon: Icons.logout_outlined,
            title: "Logout",
            onTap: _logout,
            tileColor: Colors.red[50], // Subtle highlight for logout
            textColor: Colors.red[700],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSettingsSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: Theme.of(context).primaryColorDark, // Or a muted color
          fontWeight: FontWeight.bold,
          fontSize: 13.0,
          letterSpacing: 0.8,
        ),
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? tileColor,
    Color? textColor,
  }) {
    return ListTile(
      leading: Icon(icon, color: textColor ?? Theme.of(context).iconTheme.color), // Kolam icon placeholder
      title: Text(title, style: TextStyle(color: textColor)),
      onTap: onTap,
      tileColor: tileColor,
    );
  }
}
