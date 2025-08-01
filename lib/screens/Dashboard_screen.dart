import 'package:flutter/material.dart';
import 'Income_screen.dart';
import 'Expence_screen.dart';
import 'Investments_screen.dart';
import 'Meetings_screen.dart';
import 'Budget_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        centerTitle: true,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello You are Welcome',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 24),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildDashboardCard(
                    context,
                    title: 'Expenses',
                    icon: Icons.money_off,
                    backgroundColor: Colors.red.shade400,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ExpenseScreen()),
                    ),
                  ),
                  _buildDashboardCard(
                    context,
                    title: 'Income',
                    icon: Icons.attach_money,
                    backgroundColor: Colors.green.shade600,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => IncomeScreen()),
                    ),
                  ),
                  _buildDashboardCard(
                    context,
                    title: 'Investments',
                    icon: Icons.trending_up,
                    backgroundColor: Colors.blue.shade600,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => InvestmentScreen()),
                    ),
                  ),
                  _buildDashboardCard(
                    context,
                    title: 'Meetings',
                    icon: Icons.group,
                    backgroundColor: Colors.purple.shade600,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => MeetingsScreen()),
                    ),
                  ),
                  _buildDashboardCard(
                    context,
                    title: 'Budget',
                    icon: Icons.account_balance_wallet,
                    backgroundColor: const Color.fromARGB(255, 208, 171, 5),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => BudgetScreen()),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color backgroundColor,
    required VoidCallback onTap,
    TextStyle? textStyle,
  }) {
    return Card(
      elevation: 4,
      surfaceTintColor: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.white24,
        child: Container(
          padding: EdgeInsets.all(16),
          color: backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 36, color: Colors.black87),
              SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
