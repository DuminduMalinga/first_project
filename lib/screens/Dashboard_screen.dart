import 'package:flutter/material.dart';
import 'Income_screen.dart';
import 'Expence_screen.dart';
import 'Investments_screen.dart';
import 'Meetings_screen.dart';

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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  //             physics: NeverScrollableScrollPhysics(),
  //             children: [
  //               _buildDashboardButton(context, 'Expenses', Icons.money_off, () {
  //                 Navigator.push(
  //                   context,
  //                   MaterialPageRoute(builder: (_) => ExpenseScreen()),
  //                 );
  //               }),

  //               _buildDashboardButton(
  //                 context,
  //                 'Income',
  //                 Icons.attach_money,
  //                 () {
  //                   Navigator.push(
  //                     context,
  //                     MaterialPageRoute(builder: (_) => IncomeScreen()),
  //                   );
  //                 },
  //               ),
  //               _buildDashboardButton(
  //                 context,
  //                 'Investments',
  //                 Icons.trending_up,
  //                 () {
  //                   Navigator.push(
  //                     context,
  //                     MaterialPageRoute(builder: (_) => InvestmentScreen()),
  //                   );
  //                 },
  //               ),

  //               _buildDashboardButton(
  //                 context,
  //                 'Meetings',
  //                 Icons.trending_up,
  //                 () {
  //                   Navigator.push(
  //                     context,
  //                     MaterialPageRoute(builder: (_) => MeetingsScreen()),
  //                   );
  //                 },
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildDashboardCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color backgroundColor,
    required VoidCallback onTap,
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
              Icon(icon, size: 36, color: Colors.white),
              SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
