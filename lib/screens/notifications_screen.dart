import 'package:flutter/material.dart';
import 'package:inventor_desgin_studio/screens/sound_settings_screen.dart';
import 'package:inventor_desgin_studio/screens/vibration_settings_screen.dart';
import 'package:inventor_desgin_studio/screens/do_not_disturb_screen.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _projectUpdates = true;
  bool _teamInvites = true;
  bool _comments = true;
  bool _deadlines = true;
  bool _marketing = false;
  bool _systemUpdates = true;

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
          'Notifications',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Push Notifications
            const Text(
              'Push Notifications',
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
                  _NotificationSwitchTile(
                    icon: Icons.folder_shared,
                    title: 'Project Updates',
                    subtitle: 'Updates on your projects',
                    value: _projectUpdates,
                    onChanged: (value) {
                      setState(() => _projectUpdates = value);
                    },
                  ),
                  const Divider(color: Color(0xFF2A2F38), height: 1),
                  _NotificationSwitchTile(
                    icon: Icons.group_add,
                    title: 'Team Invites',
                    subtitle: 'New team invitations',
                    value: _teamInvites,
                    onChanged: (value) {
                      setState(() => _teamInvites = value);
                    },
                  ),
                  const Divider(color: Color(0xFF2A2F38), height: 1),
                  _NotificationSwitchTile(
                    icon: Icons.comment,
                    title: 'Comments',
                    subtitle: 'Replies to your comments',
                    value: _comments,
                    onChanged: (value) {
                      setState(() => _comments = value);
                    },
                  ),
                  const Divider(color: Color(0xFF2A2F38), height: 1),
                  _NotificationSwitchTile(
                    icon: Icons.schedule,
                    title: 'Deadlines',
                    subtitle: 'Project deadline reminders',
                    value: _deadlines,
                    onChanged: (value) {
                      setState(() => _deadlines = value);
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Email Notifications
            const Text(
              'Email Notifications',
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
                  _NotificationSwitchTile(
                    icon: Icons.email,
                    title: 'Weekly Summary',
                    subtitle: 'Weekly project summary',
                    value: _systemUpdates,
                    onChanged: (value) {
                      setState(() => _systemUpdates = value);
                    },
                  ),
                  const Divider(color: Color(0xFF2A2F38), height: 1),
                  _NotificationSwitchTile(
                    icon: Icons.campaign,
                    title: 'Marketing',
                    subtitle: 'Product updates and tips',
                    value: _marketing,
                    onChanged: (value) {
                      setState(() => _marketing = value);
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Notification Settings
            const Text(
              'Settings',
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
                  _NotificationTile(
                    icon: Icons.notifications_active,
                    title: 'Sound',
                    subtitle: 'Notification sound settings',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SoundSettingsScreen()),
                      );
                    },
                  ),
                  const Divider(color: Color(0xFF2A2F38), height: 1),
                  _NotificationTile(
                    icon: Icons.vibration,
                    title: 'Vibration',
                    subtitle: 'Vibration settings',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const VibrationSettingsScreen()),
                      );
                    },
                  ),
                  const Divider(color: Color(0xFF2A2F38), height: 1),
                  _NotificationTile(
                    icon: Icons.do_not_disturb,
                    title: 'Do Not Disturb',
                    subtitle: 'Quiet hours settings',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const DoNotDisturbScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _NotificationTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
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
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.white54,
        size: 16,
      ),
      onTap: onTap,
    );
  }
}

class _NotificationSwitchTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _NotificationSwitchTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
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
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: const Color(0xFFD6FF23),
        activeTrackColor: const Color(0xFFD6FF23).withValues(alpha: 0.3),
      ),
    );
  }
}