import 'package:flutter/material.dart';

class MeetingsScreen extends StatefulWidget {
  const MeetingsScreen({super.key});

  @override
  _MeetingsScreenState createState() => _MeetingsScreenState();
}

class _MeetingsScreenState extends State<MeetingsScreen> {
  final _formKey = GlobalKey<FormState>();

  String? meetingName;
  DateTime? meetingDate;
  TimeOfDay? meetingTime;
  String? venue;
  String? link;
  bool isOnline = false;

  Future<void> _pickDate() async {
    DateTime now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: meetingDate ?? now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
    );
    if (picked != null) {
      setState(() {
        meetingDate = picked;
      });
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: meetingTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        meetingTime = picked;
      });
    }
  }

  String getFormattedDate() {
    if (meetingDate == null) return 'Select Date';
    return '${meetingDate!.year}-${meetingDate!.month.toString().padLeft(2, '0')}-${meetingDate!.day.toString().padLeft(2, '0')}';
  }

  String getFormattedTime() {
    if (meetingTime == null) return 'Select Time';
    final hour = meetingTime!.hourOfPeriod.toString().padLeft(2, '0');
    final minute = meetingTime!.minute.toString().padLeft(2, '0');
    final period = meetingTime!.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Meetings')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Meeting Name'),
                onSaved: (val) => meetingName = val,
                validator: (val) =>
                    val == null || val.isEmpty ? 'Enter meeting name' : null,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _pickDate,
                      child: Text(getFormattedDate()),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _pickTime,
                      child: Text(getFormattedTime()),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: isOnline,
                    onChanged: (val) {
                      setState(() {
                        isOnline = val ?? false;
                      });
                    },
                  ),
                  Text('Online Meeting'),
                ],
              ),
              SizedBox(height: 16),
              if (!isOnline)
                TextFormField(
                  decoration: InputDecoration(labelText: 'Venue'),
                  onSaved: (val) => venue = val,
                  validator: (val) {
                    if (!isOnline && (val == null || val.isEmpty)) {
                      return 'Enter venue';
                    }
                    return null;
                  },
                ),
              if (isOnline)
                TextFormField(
                  decoration: InputDecoration(labelText: 'Online Meeting Link'),
                  onSaved: (val) => link = val,
                  validator: (val) {
                    if (isOnline && (val == null || val.isEmpty)) {
                      return 'Enter meeting link';
                    }
                    return null;
                  },
                ),

              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text('Meeting Info'),
                        content: Text(
                          'Name: $meetingName\nDate: ${getFormattedDate()}\nTime: ${getFormattedTime()}\n${isOnline ? "Link: $link\nOnline Meeting" : "Venue: $venue\nPhysical Meeting"}',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: Text('Save Meeting'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
