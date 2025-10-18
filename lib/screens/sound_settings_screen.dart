import 'package:flutter/material.dart';

class SoundSettingsScreen extends StatefulWidget {
  const SoundSettingsScreen({super.key});

  @override
  State<SoundSettingsScreen> createState() => _SoundSettingsScreenState();
}

class _SoundSettingsScreenState extends State<SoundSettingsScreen> {
  String _selectedSound = 'Default';
  double _volume = 0.8;
  bool _soundEnabled = true;

  final List<String> _soundOptions = [
    'Default',
    'Chime',
    'Bell',
    'Ping',
    'Pop',
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
          'Sound Settings',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sound Toggle
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
                      Icon(Icons.volume_up, color: Colors.white70),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Notification Sound',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Enable/disable notification sounds',
                            style: TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Switch(
                    value: _soundEnabled,
                    onChanged: (value) {
                      setState(() => _soundEnabled = value);
                    },
                    activeColor: const Color(0xFFD6FF23),
                    activeTrackColor: const Color(0xFFD6FF23).withValues(alpha: 0.3),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Sound Selection
            const Text(
              'Notification Sound',
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
                children: _soundOptions.map((sound) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text(
                          sound,
                          style: const TextStyle(color: Colors.white),
                        ),
                        trailing: _selectedSound == sound
                            ? const Icon(
                                Icons.check,
                                color: Color(0xFFD6FF23),
                              )
                            : null,
                        onTap: () {
                          setState(() => _selectedSound = sound);
                          // Play sound preview
                          _playSoundPreview(sound);
                        },
                      ),
                      if (sound != _soundOptions.last)
                        const Divider(color: Color(0xFF2A2F38), height: 1),
                    ],
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 24),

            // Volume Control
            const Text(
              'Volume',
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
                        'Notification Volume',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${(_volume * 100).round()}%',
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
                    value: _volume,
                    onChanged: _soundEnabled
                        ? (value) {
                            setState(() => _volume = value);
                          }
                        : null,
                    activeColor: const Color(0xFFD6FF23),
                    inactiveColor: const Color(0xFF2A2F38),
                    min: 0.0,
                    max: 1.0,
                    divisions: 10,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Low',
                        style: TextStyle(color: Colors.white54, fontSize: 12),
                      ),
                      const Text(
                        'High',
                        style: TextStyle(color: Colors.white54, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Test Sound
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: _soundEnabled
                    ? () {
                        // Test the selected sound
                        _playSoundPreview(_selectedSound);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Playing notification sound...'),
                            backgroundColor: Color(0xFFD6FF23),
                          ),
                        );
                      }
                    : null,
                icon: const Icon(Icons.play_arrow, color: Colors.black),
                label: const Text(
                  'Test Sound',
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
                    icon: Icons.repeat,
                    title: 'Repeat Notifications',
                    subtitle: 'Repeat sound for urgent notifications',
                    trailing: Switch(
                      value: true,
                      onChanged: (value) {
                        // Handle repeat setting
                      },
                      activeColor: const Color(0xFFD6FF23),
                      activeTrackColor: const Color(0xFFD6FF23).withValues(alpha: 0.3),
                    ),
                  ),
                  const Divider(color: Color(0xFF2A2F38), height: 1),
                  _SettingsTile(
                    icon: Icons.access_time,
                    title: 'Sound Duration',
                    subtitle: 'How long the sound plays',
                    trailing: const Text(
                      '5 sec',
                      style: TextStyle(color: Colors.white70),
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

  void _playSoundPreview(String sound) {
    // Note: Implement actual sound preview functionality
    // This would use a sound library to play the selected notification sound
    // For now, just show feedback
    // print('Playing sound: $sound');
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