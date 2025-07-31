import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phonenumberController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUp() {
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

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
      appBar: AppBar(title: Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 40),
            Text(
              //SizedBox(height: 40),
              "Let's create your Personal Assistant",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 30),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: phonenumberController,
              decoration: InputDecoration(labelText: 'Mobile-Number'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            TextField(
              controller: confirmPasswordController,
              decoration: InputDecoration(labelText: 'Re-enter Password'),
              obscureText: true,
            ),

            SizedBox(height: 50),
            Column(
              children: [
                ElevatedButton(
                  onPressed: signUp,
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(30, 50), // width: full, height: 50
                    backgroundColor: Colors.white,
                  ),
                  child: Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Text(
                  "Or SignUp with",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 38, 3, 193),
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.g_mobiledata,
                        size: 40,
                        color: Colors.red,
                      ),
                      onPressed: signUpWithGoogle,
                      tooltip: 'Sign up with Google',
                    ),
                    SizedBox(width: 20),
                    IconButton(
                      icon: Icon(Icons.facebook, size: 40, color: Colors.blue),
                      onPressed: signUpWithFacebook,
                      tooltip: 'Sign up with Facebook',
                    ),
                    SizedBox(width: 20),
                    IconButton(
                      icon: Icon(Icons.telegram, size: 40, color: Colors.black),
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
    );
  }
}
