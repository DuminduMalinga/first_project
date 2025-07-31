import 'package:flutter/material.dart';
import 'Dashboard_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardScreen()),
      );
    });

    return Scaffold(
      body: Center(child: CircularProgressIndicator()), // optional loading
    );
  }
}
