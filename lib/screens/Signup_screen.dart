//import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with SingleTickerProviderStateMixin {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phonenumberController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void signUp() {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String phoneNumber = phonenumberController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (name.isEmpty ||
        email.isEmpty ||
        phoneNumber.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please fill all fields')));
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Passwords do not match!')));
      return;
    }

    // Proceed with sign up logic (placeholder)
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Account created!')));
    Navigator.pop(context); // go back to login
  }

  // Placeholder functions for social signups
  void signUpWithGoogle() {
    // Implement Google signup logic here
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Google SignUp initiated')));
  }

  void signUpWithFacebook() {
    // Implement Facebook signup logic here
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Facebook SignUp initiated')));
  }

  void signUpWithTelegram() {
    // Implement Telegram signup logic here
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Telegram SignUp initiated')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Sign Up', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,

        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade700, Colors.tealAccent.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Center(
            child: SingleChildScrollView(
              child: Card(
                elevation: 12,
                margin: EdgeInsets.symmetric(horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Center(
                        child: Text(
                          "Let's Create Your Personal Assistant",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal[800],
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: phonenumberController,
                        decoration: InputDecoration(
                          labelText: 'Mobile Number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: confirmPasswordController,
                        decoration: InputDecoration(
                          labelText: 'Re-enter Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        obscureText: true,
                      ),
                      SizedBox(height: 50),
                      ElevatedButton(
                        onPressed: signUp,
                        style: ElevatedButton.styleFrom(
                          disabledBackgroundColor: Colors.teal,
                          foregroundColor: Colors.white,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          minimumSize: Size(double.infinity, 50), // full width
                        ),
                        child: Text(
                          'Create Account',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Or Sign Up with",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(
                                  FontAwesomeIcons.google,
                                  color: Colors.black87,
                                  size: 32,
                                ),
                                onPressed: signUpWithGoogle,
                                tooltip: 'Sign up with Google',
                              ),

                              SizedBox(width: 20),
                              IconButton(
                                icon: Icon(
                                  Icons.facebook,
                                  size: 40,
                                  color: Colors.black87,
                                ),
                                onPressed: signUpWithFacebook,
                                tooltip: 'Sign up with Facebook',
                              ),
                              SizedBox(width: 20),
                              IconButton(
                                icon: Icon(
                                  Icons.telegram,
                                  size: 40,
                                  color: Colors.black,
                                ),
                                onPressed: signUpWithTelegram,
                                tooltip: 'Sign up with Telegram',
                              ),
                            ],
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
      ),
    );
  }
}
