import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseScreen extends StatefulWidget {
  @override
  _ExpenseScreenState createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final amountController = TextEditingController();
  String? selectedExpenseType;
  DateTime? selectedDate;

  final List<String> expenseTypes = [
    'Food',
    'Travel',
    'Educational',
    'Insurance',
  ];

  void pickDate() async {
    DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void saveExpense() {
    if (selectedExpenseType == null ||
        amountController.text.isEmpty ||
        selectedDate == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please fill all fields')));
      return;
    }

    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate!);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Expense saved:\nType: $selectedExpenseType\nAmount: ${amountController.text}\nDate: $formattedDate',
        ),
      ),
    );

    // Clear fields
    setState(() {
      selectedExpenseType = null;
      amountController.clear();
      selectedDate = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Expenses')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: selectedExpenseType,
              hint: Text('Select Expense Type'),
              items: expenseTypes.map((type) {
                return DropdownMenuItem(value: type, child: Text(type));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedExpenseType = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Expense Type',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            InkWell(
              onTap: pickDate,
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Date',
                  border: OutlineInputBorder(),
                ),
                child: Text(
                  selectedDate != null
                      ? DateFormat('yyyy-MM-dd').format(selectedDate!)
                      : 'Select a date',
                  style: TextStyle(
                    color: selectedDate != null ? Colors.black : Colors.grey,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: saveExpense,
              child: Text('OK'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
