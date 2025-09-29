import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  static const String _backgroundImagePath = 'assets/images/login.jpg'; 
  static const String _loginIconPath = 'assets/images/login.png';
  static const String _googleIconPath = 'assets/images/google_icon.png';
  static const String _facebookIconPath = 'assets/images/facebook_icon.png';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _loginUser() {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;
      print('Login attempt with Email: $email, Password: $password');
      // TODO: Implement actual login logic 
      // Example: Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              _backgroundImagePath,
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.3),
              colorBlendMode: BlendMode.darken,
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 400,
                  minHeight: screenHeight * 0.7, 
                ),
                child: Container(
                  padding: const EdgeInsets.all(28.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 15.0,
                        spreadRadius: 2.0,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Image.asset(_loginIconPath, height: 80.0, width: 80.0),
                        const SizedBox(height: 20.0),
                        Text(
                          'Welcome Back!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Login to continue your cultural journey.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15.0, color: Colors.grey.shade600),
                        ),
                        const SizedBox(height: 30.0),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: _inputDecoration(
                            hintText: 'Enter your email',
                            labelText: 'Email',
                            prefixIcon: Icons.email_outlined,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) return 'Please enter your email';
                            if (!value.contains('@')) return 'Email must contain an "@" symbol';
                            return null;
                          },
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: _inputDecoration(
                            hintText: 'Enter your password',
                            labelText: 'Password',
                            prefixIcon: Icons.lock_outline,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) return 'Please enter your password';
                            if (value.length < 6) return 'Password must be at least 6 characters';
                            return null;
                          },
                        ),
                        const SizedBox(height: 12.0),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () => print('Forgot Password pressed'),
                            child: Text('Forgot Password?', style: TextStyle(color: Colors.blue.shade700, fontSize: 13.0)),
                          ),
                        ),
                        const SizedBox(height: 25.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber.shade700,
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            textStyle: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                            elevation: 5.0,
                          ),
                          onPressed: _loginUser,
                          child: const Text('Login', style: TextStyle(color: Colors.white)),
                        ),
                        const SizedBox(height: 25.0),
                        // MODIFIED ROW for "Or continue with"
                        Row(
                          children: [
                            const Expanded(child: Divider(thickness: 0.7)),
                            Flexible( // Added Flexible here
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                child: Text('Or continue with', style: TextStyle(color: Colors.grey.shade600, fontSize: 13.0), textAlign: TextAlign.center,),
                              ),
                            ),
                            const Expanded(child: Divider(thickness: 0.7)),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            _buildSocialLoginButton(_googleIconPath, () => print('Google Login')),
                            const SizedBox(width: 25.0),
                            _buildSocialLoginButton(_facebookIconPath, () => print('Facebook Login')),
                          ],
                        ),
                        const SizedBox(height: 30.0),
                        Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 4.0, 
                          children: <Widget>[
                            Text(
                              "Don't have an account?",
                              style: TextStyle(color: Colors.grey.shade700, fontSize: 14.0),
                            ),
                            TextButton(
                              onPressed: () => print('Register pressed'),
                              style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap, alignment: Alignment.centerLeft),
                              child: Text(
                                'Register',
                                style: TextStyle(color: Colors.blue.shade800, fontWeight: FontWeight.bold, fontSize: 14.5),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hintText,
    required String labelText,
    required IconData prefixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      labelText: labelText,
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 8.0),
        child: Icon(prefixIcon, color: Colors.grey.shade600, size: 20),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide(color: Colors.grey.shade300)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide(color: Colors.grey.shade400, width: 0.8)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide(color: Colors.amber.shade700, width: 1.5)),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
    );
  }

  Widget _buildSocialLoginButton(String iconPath, VoidCallback onPressed) {
    // It's crucial that iconPath (e.g., _googleIconPath) points to an existing asset
    // declared in pubspec.yaml, otherwise Image.asset will fail.
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.grey.shade300, width: 0.8),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5.0, offset: const Offset(0, 2))]
        ),
        // If Image.asset fails, it might display an error widget with unexpected sizes,
        // contributing to layout overflows.
        child: Image.asset(iconPath, height: 28.0, width: 28.0, errorBuilder: (context, error, stackTrace) {
          // Optionally, provide a fallback widget if the image fails to load
          print('Error loading social icon $iconPath: $error');
          return Icon(Icons.error, color: Colors.red, size: 28.0); // Placeholder for failed image
        }),
      ),
    );
  }
}
