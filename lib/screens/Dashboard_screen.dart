import 'dart:ffi';

import 'package:flutter/material.dart';
import 'Income_screen.dart';
import 'Expence_screen.dart';
import 'Investments_screen.dart';
import 'Meetings_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello You are Welcome',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 30),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              physics: NeverScrollableScrollPhysics(),
              children: [
                _buildDashboardButton(context, 'Expenses', Icons.money_off, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ExpenseScreen()),
                  );
                }),

                _buildDashboardButton(
                  context,
                  'Income',
                  Icons.attach_money,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => IncomeScreen()),
                    );
                  },
                ),
                _buildDashboardButton(
                  context,
                  'Investments',
                  Icons.trending_up,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => InvestmentScreen()),
                    );
                  },
                ),

                _buildDashboardButton(
                  context,
                  'Meetings',
                  Icons.trending_up,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => MeetingsScreen()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardButton(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(16),
        backgroundColor: Colors.blue.shade600,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32),
          SizedBox(height: 10),
          Text(title, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
