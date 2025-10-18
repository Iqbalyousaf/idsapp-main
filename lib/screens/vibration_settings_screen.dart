import 'package:flutter/material.dart';

class VibrationSettingsScreen extends StatefulWidget {
  const VibrationSettingsScreen({super.key});

  @override
  State<VibrationSettingsScreen> createState() => _VibrationSettingsScreenState();
}

class _VibrationSettingsScreenState extends State<VibrationSettingsScreen> {
  String _selectedPattern = 'Default';
  int _vibrationIntensity = 5;
  bool _vibrationEnabled = true;

  final List<String> _vibrationPatterns = [
    'Default',
    'Short Pulse',
    'Long Pulse',
    'Double Pulse',
    'Triple Pulse',
    'Heartbeat',
    'Wave',
    'None',
  ];

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
          'Vibration Settings',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Vibration Toggle
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
                      Icon(Icons.vibration, color: Colors.white70),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Vibration',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Enable/disable vibration',
                            style: TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Switch(
                    value: _vibrationEnabled,
                    onChanged: (value) {
                      setState(() => _vibrationEnabled = value);
                    },
                    activeColor: const Color(0xFFD6FF23),
                    activeTrackColor: const Color(0xFFD6FF23).withValues(alpha: 0.3),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Vibration Pattern
            const Text(
              'Vibration Pattern',
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
                children: _vibrationPatterns.map((pattern) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text(
                          pattern,
                          style: const TextStyle(color: Colors.white),
                        ),
                        trailing: _selectedPattern == pattern
                            ? const Icon(
                                Icons.check,
                                color: Color(0xFFD6FF23),
                              )
                            : null,
                        onTap: () {
                          setState(() => _selectedPattern = pattern);
                          // Trigger vibration preview
                          _vibratePreview(pattern);
                        },
                      ),
                      if (pattern != _vibrationPatterns.last)
                        const Divider(color: Color(0xFF2A2F38), height: 1),
                    ],
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 24),

            // Vibration Intensity
            const Text(
              'Vibration Intensity',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(20),
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
                        'Intensity Level',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '$_vibrationIntensity/10',
                        style: const TextStyle(
                          color: Color(0xFFD6FF23),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Slider(
                    value: _vibrationIntensity.toDouble(),
                    onChanged: _vibrationEnabled
                        ? (value) {
                            setState(() => _vibrationIntensity = value.round());
                          }
                        : null,
                    activeColor: const Color(0xFFD6FF23),
                    inactiveColor: const Color(0xFF2A2F38),
                    min: 1.0,
                    max: 10.0,
                    divisions: 9,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Gentle',
                        style: TextStyle(color: Colors.white54, fontSize: 12),
                      ),
                      const Text(
                        'Strong',
                        style: TextStyle(color: Colors.white54, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Test Vibration
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: _vibrationEnabled
                    ? () {
                        // Test the selected vibration
                        _vibratePreview(_selectedPattern);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Testing vibration...'),
                            backgroundColor: Color(0xFFD6FF23),
                          ),
                        );
                      }
                    : null,
                icon: const Icon(Icons.vibration, color: Colors.black),
                label: const Text(
                  'Test Vibration',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD6FF23),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Additional Settings
            const Text(
              'Additional Settings',
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
                  _SettingsTile(
                    icon: Icons.notifications_active,
                    title: 'Vibrate for Calls',
                    subtitle: 'Vibrate when receiving calls',
                    trailing: Switch(
                      value: true,
                      onChanged: (value) {
                        // Handle call vibration setting
                      },
                      activeColor: const Color(0xFFD6FF23),
                      activeTrackColor: const Color(0xFFD6FF23).withValues(alpha: 0.3),
                    ),
                  ),
                  const Divider(color: Color(0xFF2A2F38), height: 1),
                  _SettingsTile(
                    icon: Icons.alarm,
                    title: 'Vibrate for Alarms',
                    subtitle: 'Vibrate for alarm notifications',
                    trailing: Switch(
                      value: true,
                      onChanged: (value) {
                        // Handle alarm vibration setting
                      },
                      activeColor: const Color(0xFFD6FF23),
                      activeTrackColor: const Color(0xFFD6FF23).withValues(alpha: 0.3),
                    ),
                  ),
                  const Divider(color: Color(0xFF2A2F38), height: 1),
                  _SettingsTile(
                    icon: Icons.battery_alert,
                    title: 'Vibrate on Low Battery',
                    subtitle: 'Vibrate when battery is low',
                    trailing: Switch(
                      value: false,
                      onChanged: (value) {
                        // Handle low battery vibration setting
                      },
                      activeColor: const Color(0xFFD6FF23),
                      activeTrackColor: const Color(0xFFD6FF23).withValues(alpha: 0.3),
                    ),
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

  void _vibratePreview(String pattern) {
    // Note: Implement actual vibration functionality
    // This would use vibration library to trigger device vibration
    // For now, just show feedback
    // print('Vibrating with pattern: $pattern');
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget trailing;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: const Color(0xFFD6FF23).withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: const Color(0xFFD6FF23)),
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: Colors.white70),
      ),
      trailing: trailing,
    );
  }
}