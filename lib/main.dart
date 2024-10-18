import 'dart:ui';
import 'package:flutter/material.dart';
import 'dashboard.dart'; // Import the Dashboard screen

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swift Café Login',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _login(BuildContext context) {
    final String username = usernameController.text;
    final String password = passwordController.text;

    if (username == 'test' && password == 'test') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => DashboardScreen()),
      );
    } else {
      _showLoginFailedDialog(context);
    }
  }

  void _showLoginFailedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Login Failed'),
        content: const Text('Incorrect username or password.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          _buildBackground(),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: _buildLoginCard(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Stack(
      children: [
        Image.asset(
          'assets/img.png',
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
        ),
        ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(),
        ),
      ],
    );
  }

  Widget _buildLoginCard(BuildContext context) {
    return Card(
      color: Colors.grey[300]?.withOpacity(0.2),
      elevation: 12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset('assets/asset-1-1.png'),
            const SizedBox(height: 20),
            _buildTitle(),
            const SizedBox(height: 5),
            const Text(
              '\"Latte but never late\"',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: usernameController,
              hintText: 'User Name',
            ),
            const SizedBox(height: 10),
            _buildTextField(
              controller: passwordController,
              hintText: 'Password',
              obscureText: true,
            ),
            const SizedBox(height: 20),
            _buildLoginButton(context),
            const SizedBox(height: 10),
            _buildSignupButton(),
            const SizedBox(height: 10),
            _buildPrivacyPolicyButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
        children: [
          TextSpan(
            text: 'Swift\n',
            style: TextStyle(
              color: Colors.white,
              fontSize: 64,
            ),
          ),
          TextSpan(
            text: 'Café',
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white70),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white70),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(80),
        ),
        elevation: 12,
        shadowColor: Colors.black.withOpacity(0.5),
      ),
      onPressed: () => _login(context),
      child: Ink(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xff331e11), Color.fromRGBO(155, 102, 65, 0.9)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: const SizedBox(
          width: 180,
          height: 36,
          child: Center(
            child: Text(
              'Login',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignupButton() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        side: const BorderSide(color: Colors.white),
        minimumSize: const Size(180, 36),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      onPressed: () {
        // Handle signup
      },
      child: const Text('Signup'),
    );
  }

  Widget _buildPrivacyPolicyButton() {
    return TextButton(
      onPressed: () {
        // Show privacy policy
      },
      child: const Text(
        'Privacy Policy',
        style: TextStyle(color: Colors.white70),
      ),
    );
  }
}
