import 'package:flutter/material.dart';

class DoNotDisturbScreen extends StatefulWidget {
  const DoNotDisturbScreen({super.key});

  @override
  State<DoNotDisturbScreen> createState() => _DoNotDisturbScreenState();
}

class _DoNotDisturbScreenState extends State<DoNotDisturbScreen> {
  bool _dndEnabled = false;
  TimeOfDay _startTime = const TimeOfDay(hour: 22, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 8, minute: 0);
  bool _allowCalls = false;
  bool _allowMessages = false;
  bool _allowAlarms = true;
  final List<String> _allowedContacts = [];

  final List<String> _daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  final Map<String, bool> _selectedDays = {
    'Monday': true,
    'Tuesday': true,
    'Wednesday': true,
    'Thursday': true,
    'Friday': true,
    'Saturday': false,
    'Sunday': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E131A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Do Not Disturb',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // DND Toggle
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A2029),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF2A2F38)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.do_not_disturb, color: Colors.white70),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Do Not Disturb',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Silence notifications during scheduled hours',
                            style: TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Switch(
                    value: _dndEnabled,
                    onChanged: (value) {
                      setState(() => _dndEnabled = value);
                    },
                    activeColor: const Color(0xFFD6FF23),
                    activeTrackColor: const Color(0xFFD6FF23).withValues(alpha: 0.3),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Schedule Settings
            const Text(
              'Schedule',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1A2029),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF2A2F38)),
              ),
              child: Column(
                children: [
                  // Start Time
                  ListTile(
                    title: const Text(
                      'Start Time',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      _startTime.format(context),
                      style: const TextStyle(color: Colors.white70),
                    ),
                    trailing: const Icon(
                      Icons.access_time,
                      color: Color(0xFFD6FF23),
                    ),
                    onTap: _dndEnabled ? _selectStartTime : null,
                  ),
                  const Divider(color: Color(0xFF2A2F38), height: 1),

                  // End Time
                  ListTile(
                    title: const Text(
                      'End Time',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      _endTime.format(context),
                      style: const TextStyle(color: Colors.white70),
                    ),
                    trailing: const Icon(
                      Icons.access_time,
                      color: Color(0xFFD6FF23),
                    ),
                    onTap: _dndEnabled ? _selectEndTime : null,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Days of Week
            const Text(
              'Active Days',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1A2029),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF2A2F38)),
              ),
              child: Column(
                children: _daysOfWeek.map((day) {
                  return Column(
                    children: [
                      CheckboxListTile(
                        title: Text(
                          day,
                          style: const TextStyle(color: Colors.white),
                        ),
                        value: _selectedDays[day],
                        onChanged: _dndEnabled
                            ? (value) {
                                setState(() => _selectedDays[day] = value ?? false);
                              }
                            : null,
                        activeColor: const Color(0xFFD6FF23),
                        checkColor: Colors.black,
                      ),
                      if (day != _daysOfWeek.last)
                        const Divider(color: Color(0xFF2A2F38), height: 1),
                    ],
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 24),

            // Exceptions
            const Text(
              'Allow Notifications From',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1A2029),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF2A2F38)),
              ),
              child: Column(
                children: [
                  // Allow Calls
                  SwitchListTile(
                    title: const Text(
                      'Phone Calls',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    subtitle: const Text(
                      'Allow incoming calls during DND',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    value: _allowCalls,
                    onChanged: _dndEnabled
                        ? (value) {
                            setState(() => _allowCalls = value);
                          }
                        : null,
                    activeColor: const Color(0xFFD6FF23),
                    activeTrackColor: const Color(0xFFD6FF23).withValues(alpha: 0.3),
                  ),
                  const Divider(color: Color(0xFF2A2F38), height: 1),

                  // Allow Messages
                  SwitchListTile(
                    title: const Text(
                      'Messages',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    subtitle: const Text(
                      'Allow message notifications during DND',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    value: _allowMessages,
                    onChanged: _dndEnabled
                        ? (value) {
                            setState(() => _allowMessages = value);
                          }
                        : null,
                    activeColor: const Color(0xFFD6FF23),
                    activeTrackColor: const Color(0xFFD6FF23).withValues(alpha: 0.3),
                  ),
                  const Divider(color: Color(0xFF2A2F38), height: 1),

                  // Allow Alarms
                  SwitchListTile(
                    title: const Text(
                      'Alarms & Reminders',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    subtitle: const Text(
                      'Always allow alarm notifications',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    value: _allowAlarms,
                    onChanged: _dndEnabled
                        ? (value) {
                            setState(() => _allowAlarms = value);
                          }
                        : null,
                    activeColor: const Color(0xFFD6FF23),
                    activeTrackColor: const Color(0xFFD6FF23).withValues(alpha: 0.3),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Allowed Contacts
            const Text(
              'Allowed Contacts',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A2029),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF2A2F38)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Allow from specific contacts',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.add,
                          color: Color(0xFFD6FF23),
                        ),
                        onPressed: _dndEnabled ? _addAllowedContact : null,
                      ),
                    ],
                  ),
                  if (_allowedContacts.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        'No contacts selected',
                        style: TextStyle(color: Colors.white54),
                      ),
                    )
                  else
                    Column(
                      children: _allowedContacts.map((contact) {
                        return ListTile(
                          title: Text(
                            contact,
                            style: const TextStyle(color: Colors.white),
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.remove_circle,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              setState(() => _allowedContacts.remove(contact));
                            },
                          ),
                        );
                      }).toList(),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Current Status
            if (_dndEnabled)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.info, color: Colors.blue),
                        SizedBox(width: 8),
                        Text(
                          'Do Not Disturb Active',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Active from ${_startTime.format(context)} to ${_endTime.format(context)} on selected days',
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Future<void> _selectStartTime() async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: _startTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFFD6FF23),
              surface: Color(0xFF1A2029),
            ),
          ),
          child: child!,
        );
      },
    );

    if (time != null) {
      setState(() => _startTime = time);
    }
  }

  Future<void> _selectEndTime() async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: _endTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFFD6FF23),
              surface: Color(0xFF1A2029),
            ),
          ),
          child: child!,
        );
      },
    );

    if (time != null) {
      setState(() => _endTime = time);
    }
  }

  void _addAllowedContact() {
    // Note: Implement contact picker functionality
    // For now, just add a placeholder
    setState(() {
      _allowedContacts.add('Contact ${_allowedContacts.length + 1}');
    });
  }
}