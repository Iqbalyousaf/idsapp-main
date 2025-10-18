import 'package:flutter/material.dart';
import 'package:inventor_desgin_studio/screens/change_password_screen.dart';
import 'package:inventor_desgin_studio/screens/password_strength_screen.dart';
import 'package:inventor_desgin_studio/screens/manage_devices_screen.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  bool _biometricEnabled = false;
  bool _twoFactorEnabled = false;

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
          'Security',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Password Section
            const Text(
              'Password',
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
                  _SecurityTile(
                    icon: Icons.lock_outline,
                    title: 'Change Password',
                    subtitle: 'Update your account password',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ChangePasswordScreen()),
                      );
                    },
                  ),
                  const Divider(color: Color(0xFF2A2F38), height: 1),
                  _SecurityTile(
                    icon: Icons.password,
                    title: 'Password Strength',
                    subtitle: 'Check password security level',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const PasswordStrengthScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Authentication Section
            const Text(
              'Authentication',
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
                  _SecuritySwitchTile(
                    icon: Icons.fingerprint,
                    title: 'Biometric Authentication',
                    subtitle: 'Use fingerprint or face unlock',
                    value: _biometricEnabled,
                    onChanged: (value) {
                      setState(() => _biometricEnabled = value);
                    },
                  ),
                  const Divider(color: Color(0xFF2A2F38), height: 1),
                  _SecuritySwitchTile(
                    icon: Icons.security,
                    title: 'Two-Factor Authentication',
                    subtitle: 'Add extra security layer',
                    value: _twoFactorEnabled,
                    onChanged: (value) {
                      setState(() => _twoFactorEnabled = value);
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Sessions Section
            const Text(
              'Active Sessions',
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
                  _SecurityTile(
                    icon: Icons.devices,
                    title: 'Manage Devices',
                    subtitle: 'View and manage active sessions',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ManageDevicesScreen()),
                      );
                    },
                  ),
                  const Divider(color: Color(0xFF2A2F38), height: 1),
                  _SecurityTile(
                    icon: Icons.logout,
                    title: 'Sign Out All Devices',
                    subtitle: 'Sign out from all other devices',
                    onTap: () {
                      _showSignOutAllDialog();
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

  void _showSignOutAllDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A2029),
        title: const Text(
          'Sign Out All Devices',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'This will sign you out from all devices except this one. Are you sure?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.white70)),
          ),
          TextButton(
            onPressed: () {
              // Sign out all devices logic
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Signed out from all devices'),
                  backgroundColor: Color(0xFFD6FF23),
                ),
              );
            },
            child: const Text(
              'Sign Out',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

class _SecurityTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SecurityTile({
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

class _SecuritySwitchTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SecuritySwitchTile({
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