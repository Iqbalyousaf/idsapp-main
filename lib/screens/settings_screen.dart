import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:inventor_desgin_studio/providers/auth_provider.dart';
import 'package:inventor_desgin_studio/screens/profile_screen.dart';
import 'package:inventor_desgin_studio/screens/security_screen.dart';
import 'package:inventor_desgin_studio/screens/notifications_screen.dart';
import 'package:inventor_desgin_studio/screens/storage_screen.dart';
import 'package:inventor_desgin_studio/screens/backup_screen.dart';
import 'package:inventor_desgin_studio/screens/help_screen.dart';
import 'package:inventor_desgin_studio/screens/language_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _biometricEnabled = false;
  bool _darkModeEnabled = true;
  String _selectedLanguage = 'English';

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
          'Settings',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Account Section
            const Text(
              'Account',
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
                    icon: Icons.person_outline,
                    title: 'Profile',
                    subtitle: 'Update your personal information',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ProfileScreen()),
                      );
                    },
                  ),
                  const Divider(color: Color(0xFF2A2F38), height: 1),
                  _SettingsTile(
                    icon: Icons.security,
                    title: 'Security',
                    subtitle: 'Password, biometric, 2FA',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SecurityScreen()),
                      );
                    },
                  ),
                  const Divider(color: Color(0xFF2A2F38), height: 1),
                  _SettingsTile(
                    icon: Icons.notifications_none,
                    title: 'Notifications',
                    subtitle: 'Manage notification preferences',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const NotificationsScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Preferences Section
            const Text(
              'Preferences',
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
                  _SettingsSwitchTile(
                    icon: Icons.dark_mode,
                    title: 'Dark Mode',
                    subtitle: 'Toggle between light and dark themes',
                    value: _darkModeEnabled,
                    onChanged: (value) {
                      setState(() => _darkModeEnabled = value);
                    },
                  ),
                  const Divider(color: Color(0xFF2A2F38), height: 1),
                  _SettingsTile(
                    icon: Icons.language,
                    title: 'Language',
                    subtitle: _selectedLanguage,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const LanguageScreen()),
                      ).then((result) {
                        if (result != null) {
                          setState(() => _selectedLanguage = result);
                        }
                      });
                    },
                  ),
                  const Divider(color: Color(0xFF2A2F38), height: 1),
                  _SettingsSwitchTile(
                    icon: Icons.notifications_active,
                    title: 'Push Notifications',
                    subtitle: 'Receive notifications about projects',
                    value: _notificationsEnabled,
                    onChanged: (value) {
                      setState(() => _notificationsEnabled = value);
                    },
                  ),
                  const Divider(color: Color(0xFF2A2F38), height: 1),
                  _SettingsSwitchTile(
                    icon: Icons.fingerprint,
                    title: 'Biometric Authentication',
                    subtitle: 'Use fingerprint or face unlock',
                    value: _biometricEnabled,
                    onChanged: (value) {
                      setState(() => _biometricEnabled = value);
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Data & Storage Section
            const Text(
              'Data & Storage',
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
                    icon: Icons.storage,
                    title: 'Storage Usage',
                    subtitle: 'Manage app storage and cache',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const StorageScreen()),
                      );
                    },
                  ),
                  const Divider(color: Color(0xFF2A2F38), height: 1),
                  _SettingsTile(
                    icon: Icons.backup,
                    title: 'Backup & Restore',
                    subtitle: 'Backup your projects and data',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const BackupScreen()),
                      );
                    },
                  ),
                  const Divider(color: Color(0xFF2A2F38), height: 1),
                  _SettingsTile(
                    icon: Icons.delete_outline,
                    title: 'Clear Cache',
                    subtitle: 'Free up storage space',
                    onTap: () {
                      _showClearCacheDialog();
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Support Section
            const Text(
              'Support',
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
                    icon: Icons.help_outline,
                    title: 'Help & Support',
                    subtitle: 'Get help and contact support',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const HelpScreen()),
                      );
                    },
                  ),
                  const Divider(color: Color(0xFF2A2F38), height: 1),
                  _SettingsTile(
                    icon: Icons.info_outline,
                    title: 'About',
                    subtitle: 'App version and information',
                    onTap: () {
                      _showAboutDialog();
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Logout Button
            Consumer<AuthProvider>(
              builder: (context, authProvider, child) {
                return SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: authProvider.isLoading ? null : _logout,
                    icon: const Icon(Icons.logout, color: Colors.white),
                    label: const Text(
                      'Logout',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.withValues(alpha: 0.2),
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }


  void _showClearCacheDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A2029),
        title: const Text(
          'Clear Cache',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'This will clear all cached data. This action cannot be undone.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.white70)),
          ),
          TextButton(
            onPressed: () {
              // Clear cache logic here
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Cache cleared successfully'),
                  backgroundColor: Color(0xFFD6FF23),
                ),
              );
            },
            child: const Text(
              'Clear',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A2029),
        title: const Text(
          'About Inventor Design Studio',
          style: TextStyle(color: Colors.white),
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Version: 1.0.0',
              style: TextStyle(color: Colors.white70),
            ),
            SizedBox(height: 8),
            Text(
              'A powerful mobile design tool for creating stunning designs and collaborating with your team.',
              style: TextStyle(color: Colors.white70),
            ),
            SizedBox(height: 16),
            Text(
              '© 2024 Inventor Design Studio',
              style: TextStyle(color: Colors.white54, fontSize: 12),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Close',
              style: TextStyle(color: Color(0xFFD6FF23)),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _logout() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.logout();
    if (mounted) {
      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
    }
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SettingsTile({
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

class _SettingsSwitchTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SettingsSwitchTile({
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
