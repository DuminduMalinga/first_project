import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GoalScreen extends StatefulWidget {
  const GoalScreen({super.key});

  @override
  _GoalScreenState createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen>
    with SingleTickerProviderStateMixin {
  final _goalNameController = TextEditingController();
  final _targetAmountController = TextEditingController();
  double _currentAmount = 0.0;
  double _targetAmount = 0.0;
  double _progress = 0.0;

  late final AnimationController _controller;
  late Animation<double> _fadeAnimation;

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
    _goalNameController.dispose();
    _targetAmountController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _setGoal() {
    double target = double.tryParse(_targetAmountController.text) ?? 0.0;
    if (_goalNameController.text.isEmpty || target <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields with valid Values!'),
        ),
      );
      return;
    }
    setState(() {
      _targetAmount = target;
      _updateProgress();
    });
    _goalNameController.clear();
    _targetAmountController.clear();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Goal set Successfully!')));
  }

  void _addContribution(double amount) {
    if (amount > 0 && _currentAmount + amount <= _targetAmount) {
      setState(() {
        _currentAmount += amount;
        _updateProgress();
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Contribution added!')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid contribution amount!')),
      );
    }
  }

  void _updateProgress() {
    if (_targetAmount > 0) {
      _progress = (_currentAmount / _targetAmount) * 100;
    } else {
      _progress = 0.0;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Set Your Goals',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.tealAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Center(
            child: Card(
              elevation: 12,
              margin: const EdgeInsets.symmetric(horizontal: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              // color: Colors.white.withOpacity(0.95),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        'Set Your Savings or Investments Goals',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 160, 97, 2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _goalNameController,
                      decoration: const InputDecoration(
                        labelText: 'Goal Name',
                        labelStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        prefixIcon: Icon(Icons.flag, color: Colors.red),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        filled: true,
                        fillColor: Colors.teal,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _targetAmountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Target Amount',
                        labelStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        prefixIcon: Icon(
                          FontAwesomeIcons.bullseye,
                          color: Colors.red,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        filled: true,
                        fillColor: Colors.teal,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _setGoal,
                      child: const Text(
                        'Set Goal',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Card(
                      color: Colors.lightGreen[50],
                      child: ListTile(
                        leading: Icon(Icons.flag, color: Colors.red),
                        title: Text(
                          _goalNameController.text.isEmpty
                              ? 'No Goal Set'
                              : _goalNameController.text,
                        ),
                        subtitle: Text(
                          'Target Amount: \$${_targetAmount.toStringAsFixed(2)}',
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Card(
                      color: Colors.lightGreen[50],
                      child: ListTile(
                        leading: Icon(Icons.money, color: Colors.red),
                        title: const Text('Current Amount'),
                        subtitle: Text(
                          '\$${_currentAmount.toStringAsFixed(2)}',
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    LinearProgressIndicator(
                      value: _progress / 100,
                      backgroundColor: Colors.grey[300],
                      color: Colors.lightGreen,
                      minHeight: 10,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Progress: ${_progress.toStringAsFixed(2)}%',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Add Contribution',
                        labelStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        prefixIcon: Icon(Icons.add, color: Colors.black87),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        filled: true,
                        fillColor: Colors.teal,
                      ),
                      onSubmitted: (value) =>
                          _addContribution(double.tryParse(value) ?? 0.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
