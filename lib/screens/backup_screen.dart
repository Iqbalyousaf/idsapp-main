import 'package:flutter/material.dart';

class BackupScreen extends StatefulWidget {
  const BackupScreen({super.key});

  @override
  State<BackupScreen> createState() => _BackupScreenState();
}

class _BackupScreenState extends State<BackupScreen> {
  bool _autoBackup = true;
  final String _lastBackup = '2 hours ago';
  String _backupFrequency = 'Daily';

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
          'Backup & Restore',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Backup Status
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1A2029),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF2A2F38)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD6FF23).withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.backup,
                          color: Color(0xFFD6FF23),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Last Backup',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'All data is backed up',
                              style: TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Synced',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Last backup: $_lastBackup',
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Backup Settings
            const Text(
              'Backup Settings',
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
                  _BackupSwitchTile(
                    icon: Icons.autorenew,
                    title: 'Auto Backup',
                    subtitle: 'Automatically backup your data',
                    value: _autoBackup,
                    onChanged: (value) {
                      setState(() => _autoBackup = value);
                    },
                  ),
                  const Divider(color: Color(0xFF2A2F38), height: 1),
                  _BackupTile(
                    icon: Icons.schedule,
                    title: 'Backup Frequency',
                    subtitle: _backupFrequency,
                    onTap: () {
                      _showFrequencyDialog();
                    },
                  ),
                  const Divider(color: Color(0xFF2A2F38), height: 1),
                  _BackupTile(
                    icon: Icons.cloud_upload,
                    title: 'Backup Location',
                    subtitle: 'Google Drive',
                    onTap: () {
                      // Navigate to backup location settings
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Manual Backup
            const Text(
              'Manual Backup',
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
                  _BackupTile(
                    icon: Icons.backup,
                    title: 'Create Backup Now',
                    subtitle: 'Backup all your data manually',
                    onTap: () {
                      _showBackupDialog();
                    },
                  ),
                  const Divider(color: Color(0xFF2A2F38), height: 1),
                  _BackupTile(
                    icon: Icons.restore,
                    title: 'Restore from Backup',
                    subtitle: 'Restore data from a previous backup',
                    onTap: () {
                      _showRestoreDialog();
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Backup History
            const Text(
              'Backup History',
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
                  _BackupHistoryItem(
                    date: 'Today, 2:30 PM',
                    size: '2.4 GB',
                    status: 'Successful',
                    onTap: () {
                      // View backup details
                    },
                  ),
                  const Divider(color: Color(0xFF2A2F38), height: 1),
                  _BackupHistoryItem(
                    date: 'Yesterday, 2:30 PM',
                    size: '2.3 GB',
                    status: 'Successful',
                    onTap: () {
                      // View backup details
                    },
                  ),
                  const Divider(color: Color(0xFF2A2F38), height: 1),
                  _BackupHistoryItem(
                    date: '2 days ago, 2:30 PM',
                    size: '2.2 GB',
                    status: 'Successful',
                    onTap: () {
                      // View backup details
                    },
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

  void _showFrequencyDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A2029),
        title: const Text(
          'Backup Frequency',
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _FrequencyOption(
              frequency: 'Daily',
              isSelected: _backupFrequency == 'Daily',
              onTap: () {
                setState(() => _backupFrequency = 'Daily');
                Navigator.pop(context);
              },
            ),
            _FrequencyOption(
              frequency: 'Weekly',
              isSelected: _backupFrequency == 'Weekly',
              onTap: () {
                setState(() => _backupFrequency = 'Weekly');
                Navigator.pop(context);
              },
            ),
            _FrequencyOption(
              frequency: 'Monthly',
              isSelected: _backupFrequency == 'Monthly',
              onTap: () {
                setState(() => _backupFrequency = 'Monthly');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showBackupDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A2029),
        title: const Text(
          'Create Backup',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'This will create a backup of all your projects and data. Continue?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.white70)),
          ),
          TextButton(
            onPressed: () {
              // Create backup logic
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Backup created successfully'),
                  backgroundColor: Color(0xFFD6FF23),
                ),
              );
            },
            child: const Text(
              'Create',
              style: TextStyle(color: Color(0xFFD6FF23)),
            ),
          ),
        ],
      ),
    );
  }

  void _showRestoreDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A2029),
        title: const Text(
          'Restore from Backup',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'This will restore your data from the selected backup. Current data may be overwritten. Continue?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.white70)),
          ),
          TextButton(
            onPressed: () {
              // Restore logic
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Data restored successfully'),
                  backgroundColor: Color(0xFFD6FF23),
                ),
              );
            },
            child: const Text(
              'Restore',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

class _BackupTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _BackupTile({
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

class _BackupSwitchTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _BackupSwitchTile({
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

class _BackupHistoryItem extends StatelessWidget {
  final String date;
  final String size;
  final String status;
  final VoidCallback onTap;

  const _BackupHistoryItem({
    required this.date,
    required this.size,
    required this.status,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.green.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(Icons.check_circle, color: Colors.green),
      ),
      title: Text(
        date,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        '$size • $status',
        style: const TextStyle(color: Colors.white70),
      ),
      trailing: const Icon(
        Icons.more_vert,
        color: Colors.white54,
      ),
      onTap: onTap,
    );
  }
}

class _FrequencyOption extends StatelessWidget {
  final String frequency;
  final bool isSelected;
  final VoidCallback onTap;

  const _FrequencyOption({
    required this.frequency,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        frequency,
        style: TextStyle(
          color: isSelected ? const Color(0xFFD6FF23) : Colors.white,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing: isSelected
          ? const Icon(Icons.check, color: Color(0xFFD6FF23))
          : null,
      onTap: onTap,
    );
  }
}