import 'package:flutter/material.dart';
import 'package:inventor_desgin_studio/theme/constants.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = true;
  bool _biometricEnabled = false;
  String _selectedLanguage = 'English';
  String _selectedCurrency = 'USD';

  final List<String> _languages = ['English', 'Spanish', 'French', 'German'];
  final List<String> _currencies = ['USD', 'EUR', 'GBP', 'INR'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E131A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Account Settings
            _buildSectionHeader('Account Settings'),
            _buildSettingCard([
              _buildListTile(
                icon: Icons.person,
                title: 'Profile Information',
                subtitle: 'Update your personal details',
                onTap: () => _navigateToProfile(),
              ),
              _buildListTile(
                icon: Icons.security,
                title: 'Security & Privacy',
                subtitle: 'Password, 2FA, data privacy',
                onTap: () => _navigateToSecurity(),
              ),
              _buildListTile(
                icon: Icons.payment,
                title: 'Payment Methods',
                subtitle: 'Manage cards and billing',
                onTap: () => _navigateToPayment(),
              ),
            ]),

            const SizedBox(height: 24),

            // App Preferences
            _buildSectionHeader('App Preferences'),
            _buildSettingCard([
              _buildSwitchTile(
                icon: Icons.notifications,
                title: 'Push Notifications',
                subtitle: 'Receive updates and alerts',
                value: _notificationsEnabled,
                onChanged: (value) => setState(() => _notificationsEnabled = value),
              ),
              _buildSwitchTile(
                icon: Icons.dark_mode,
                title: 'Dark Mode',
                subtitle: 'Toggle dark/light theme',
                value: _darkModeEnabled,
                onChanged: (value) => setState(() => _darkModeEnabled = value),
              ),
              _buildSwitchTile(
                icon: Icons.fingerprint,
                title: 'Biometric Authentication',
                subtitle: 'Use fingerprint/face unlock',
                value: _biometricEnabled,
                onChanged: (value) => setState(() => _biometricEnabled = value),
              ),
              _buildDropdownTile(
                icon: Icons.language,
                title: 'Language',
                subtitle: 'Choose your preferred language',
                value: _selectedLanguage,
                items: _languages,
                onChanged: (value) => setState(() => _selectedLanguage = value!),
              ),
              _buildDropdownTile(
                icon: Icons.currency_exchange,
                title: 'Currency',
                subtitle: 'Display currency for pricing',
                value: _selectedCurrency,
                items: _currencies,
                onChanged: (value) => setState(() => _selectedCurrency = value!),
              ),
            ]),

            const SizedBox(height: 24),

            // Support & Help
            _buildSectionHeader('Support & Help'),
            _buildSettingCard([
              _buildListTile(
                icon: Icons.help,
                title: 'Help Center',
                subtitle: 'FAQs and tutorials',
                onTap: () => _navigateToHelp(),
              ),
              _buildListTile(
                icon: Icons.contact_support,
                title: 'Contact Support',
                subtitle: 'Get help from our team',
                onTap: () => _navigateToSupport(),
              ),
              _buildListTile(
                icon: Icons.feedback,
                title: 'Send Feedback',
                subtitle: 'Help us improve the app',
                onTap: () => _navigateToFeedback(),
              ),
            ]),

            const SizedBox(height: 24),

            // About
            _buildSectionHeader('About'),
            _buildSettingCard([
              _buildListTile(
                icon: Icons.info,
                title: 'App Version',
                subtitle: 'Version 1.0.0',
                onTap: () {},
              ),
              _buildListTile(
                icon: Icons.privacy_tip,
                title: 'Privacy Policy',
                subtitle: 'Read our privacy policy',
                onTap: () => _navigateToPrivacy(),
              ),
              _buildListTile(
                icon: Icons.description,
                title: 'Terms of Service',
                subtitle: 'Read our terms and conditions',
                onTap: () => _navigateToTerms(),
              ),
            ]),

            const SizedBox(height: 24),

            // Sign Out
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1A2029),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF2A2F38)),
              ),
              child: ElevatedButton(
                onPressed: _signOut,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Sign Out',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSettingCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A2029),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF2A2F38)),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: kNeon.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: kNeon),
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: Colors.white54),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16),
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: kNeon.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: kNeon),
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: Colors.white54),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: kNeon,
        activeTrackColor: kNeon.withValues(alpha: 0.3),
      ),
    );
  }

  Widget _buildDropdownTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: kNeon.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: kNeon),
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: Colors.white54),
      ),
      trailing: DropdownButton<String>(
        value: value,
        dropdownColor: const Color(0xFF1A2029),
        style: const TextStyle(color: Colors.white),
        underline: const SizedBox(),
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  void _navigateToProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Navigate to Profile')),
    );
  }

  void _navigateToSecurity() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Navigate to Security')),
    );
  }

  void _navigateToPayment() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Navigate to Payment Methods')),
    );
  }

  void _navigateToHelp() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Navigate to Help Center')),
    );
  }

  void _navigateToSupport() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Navigate to Support')),
    );
  }

  void _navigateToFeedback() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Navigate to Feedback')),
    );
  }

  void _navigateToPrivacy() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Navigate to Privacy Policy')),
    );
  }

  void _navigateToTerms() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Navigate to Terms of Service')),
    );
  }

  void _signOut() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A2029),
        title: const Text(
          'Sign Out',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Are you sure you want to sign out?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white70),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Implement sign out logic
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Signed out successfully')),
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