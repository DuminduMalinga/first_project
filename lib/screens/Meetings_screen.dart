import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MeetingsScreen extends StatefulWidget {
  const MeetingsScreen({super.key});

  @override
  _MeetingsScreenState createState() => _MeetingsScreenState();
}

class _MeetingsScreenState extends State<MeetingsScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  void resetForm() {
    _formKey.currentState?.reset();
    setState(() {
      meetingName = null;
      meetingDate = null;
      meetingTime = null;
      venue = null;
      link = null;
      isOnline = false;
    });
  }

  String? meetingName;
  DateTime? meetingDate;
  TimeOfDay? meetingTime;
  String? venue;
  String? link;
  bool isOnline = false;

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
    _controller.dispose();
    super.dispose();
  }

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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Organize Meetings',
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
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 20),
                      Center(
                        child: Text(
                          'Plan Your Upcoming Meeting',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 159, 73, 8),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Meeting Name',
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                          prefixIcon: Icon(FontAwesomeIcons.handshake),
                          filled: true,
                          fillColor: Color.fromARGB(255, 240, 226, 186),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                        onSaved: (val) => meetingName = val,
                        validator: (val) => val == null || val.isEmpty
                            ? 'Enter meeting name'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: _pickDate,
                              icon: const Icon(Icons.calendar_today),
                              label: Text(getFormattedDate()),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: _pickTime,
                              icon: const Icon(Icons.access_time),
                              label: Text(getFormattedTime()),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
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
                          const Text(
                            'Online Meeting',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      if (!isOnline)
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Venue',
                            labelStyle: TextStyle(fontWeight: FontWeight.bold),
                            prefixIcon: Icon(FontAwesomeIcons.locationDot),
                            filled: true,
                            fillColor: Color.fromARGB(255, 240, 226, 186),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                          ),
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
                          decoration: const InputDecoration(
                            labelText: 'Online Meeting Link',
                            labelStyle: TextStyle(fontWeight: FontWeight.bold),
                            prefixIcon: Icon(FontAwesomeIcons.link),
                            filled: true,
                            fillColor: Color.fromARGB(255, 240, 226, 186),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                          ),
                          onSaved: (val) => link = val,
                          validator: (val) {
                            if (isOnline && (val == null || val.isEmpty)) {
                              return 'Enter meeting link';
                            }
                            return null;
                          },
                        ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            if (meetingName == null ||
                                meetingName!.isEmpty ||
                                meetingDate == null ||
                                meetingTime == null ||
                                (isOnline && (link == null || link!.isEmpty)) ||
                                (!isOnline &&
                                    (venue == null || venue!.isEmpty))) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Please fill in all required fields.',
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.redAccent,
                                ),
                              );
                              return;
                            }

                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text('Meeting Info'),
                                content: Text(
                                  'Name: $meetingName\n'
                                  'Date: ${getFormattedDate()}\n'
                                  'Time: ${getFormattedTime()}\n'
                                  '${isOnline ? "Link: $link\nOnline Meeting" : "Venue: $venue\nPhysical Meeting"}',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      resetForm();
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
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
                        child: const Text(
                          'Save Meeting',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
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
