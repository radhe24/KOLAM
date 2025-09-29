import 'package:flutter/material.dart';
import 'home_screen.dart'; // Import HomeScreen

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  // final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    _confirmPasswordVisible = false;
  }

  void _register() {
    if (_formKey.currentState?.validate() ?? false) {
      // Process registration
      print("Register button pressed. Form is valid.");
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (Route<dynamic> route) => false, // Remove all previous routes
        );
      }
    }
  }

  void _pickProfileImage() {
    print("Pick profile image (placeholder)");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Account", style: TextStyle(color: Colors.teal.shade700, fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.teal.shade700), // Ensure back button is also teal
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Profile Picture Upload
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[300],
                      child: const Icon(Icons.person, size: 50, color: Colors.grey),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        icon: Icon(Icons.camera_alt, color: Colors.teal.shade700),
                        onPressed: _pickProfileImage,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24.0),
              // Name Input
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Full Name",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                  prefixIcon: const Icon(Icons.person_outline), 
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter your name';
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              // Email/Phone Input
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Email or Phone",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                  prefixIcon: const Icon(Icons.email_outlined), 
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter email/phone';
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16.0),
              // Password Input
              TextFormField(
                // controller: _passwordController, 
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                  prefixIcon: const Icon(Icons.lock_outline), 
                  suffixIcon: IconButton(
                    icon: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off),
                    onPressed: () => setState(() => _passwordVisible = !_passwordVisible),
                  ),
                ),
                obscureText: !_passwordVisible,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter a password';
                  if (value.length < 6) return 'Password must be at least 6 characters';
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              // Confirm Password Input
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                  prefixIcon: const Icon(Icons.lock_outline), 
                  suffixIcon: IconButton(
                    icon: Icon(_confirmPasswordVisible ? Icons.visibility : Icons.visibility_off),
                    onPressed: () => setState(() => _confirmPasswordVisible = !_confirmPasswordVisible),
                  ),
                ),
                obscureText: !_confirmPasswordVisible,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please confirm your password';
                  // if (value != _passwordController.text) return 'Passwords do not match'; 
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              // Optional Age/Gender
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Age (Optional)",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                        prefixIcon: const Icon(Icons.cake_outlined), 
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                            labelText: "Gender (Optional)",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                            prefixIcon: const Icon(Icons.wc_outlined), 
                        ),
                        items: ["Male", "Female", "Other", "Prefer not to say"]
                            .map((label) => DropdownMenuItem(child: Text(label), value: label))
                            .toList(),
                        onChanged: (value) {  },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32.0),
              // Register Button
              ElevatedButton(
                onPressed: _register,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amberAccent, // Updated background color
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                ),
                child: Text("REGISTER", style: TextStyle(color: Colors.teal.shade900)), // Updated text style
              ),
              const SizedBox(height: 16.0),
              // Privacy Policy Link
              TextButton(
                onPressed: () {
                  print("Privacy Policy link pressed (placeholder)");
                },
                child: const Text("By registering, you agree to our Privacy Policy."),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
