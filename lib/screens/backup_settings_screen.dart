import 'package:flutter/material.dart';

class BackupSettingsScreen extends StatefulWidget {
  const BackupSettingsScreen({super.key});

  @override
  State<BackupSettingsScreen> createState() => _BackupSettingsScreenState();
}

class _BackupSettingsScreenState extends State<BackupSettingsScreen> {
  bool _autoBackup = true;
  bool _wifiOnly = true;
  bool _includeImages = true;
  bool _includeVideos = false;
  String _backupFrequency = 'Daily';
  final String _lastBackup = '2 hours ago';

  final List<String> _frequencies = ['Daily', 'Weekly', 'Monthly', 'Manual'];

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
          'Backup Settings',
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Backup Status',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Active',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.access_time, color: Colors.white70, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        'Last backup: $_lastBackup',
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.storage, color: Colors.white70, size: 16),
                      const SizedBox(width: 8),
                      const Text(
                        'Backup size: 2.3 GB',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
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
            const SizedBox(height: 16),

            // Auto Backup
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
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Automatic Backup',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Backup your data automatically',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                  Switch(
                    value: _autoBackup,
                    onChanged: (value) {
                      setState(() => _autoBackup = value);
                    },
                    activeColor: const Color(0xFFD6FF23),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Backup Frequency
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A2029),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF2A2F38)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Backup Frequency',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _frequencies.map((frequency) {
                      return ChoiceChip(
                        label: Text(frequency),
                        selected: _backupFrequency == frequency,
                        onSelected: (selected) {
                          if (selected) {
                            setState(() => _backupFrequency = frequency);
                          }
                        },
                        selectedColor: const Color(0xFFD6FF23).withValues(alpha: 0.2),
                        backgroundColor: const Color(0xFF2A2F38),
                        labelStyle: TextStyle(
                          color: _backupFrequency == frequency
                              ? Colors.black
                              : Colors.white,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // WiFi Only
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
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'WiFi Only',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Backup only when connected to WiFi',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                  Switch(
                    value: _wifiOnly,
                    onChanged: (value) {
                      setState(() => _wifiOnly = value);
                    },
                    activeColor: const Color(0xFFD6FF23),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // What to Backup
            const Text(
              'What to Backup',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Include Images
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
                      Icon(Icons.image, color: Colors.white70),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Images',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Photos and graphics',
                            style: TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Checkbox(
                    value: _includeImages,
                    onChanged: (value) {
                      setState(() => _includeImages = value ?? false);
                    },
                    activeColor: const Color(0xFFD6FF23),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Include Videos
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
                      Icon(Icons.video_file, color: Colors.white70),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Videos',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Video files and animations',
                            style: TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Checkbox(
                    value: _includeVideos,
                    onChanged: (value) {
                      setState(() => _includeVideos = value ?? false);
                    },
                    activeColor: const Color(0xFFD6FF23),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Manual Backup
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Perform manual backup
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Manual backup started...'),
                      backgroundColor: Color(0xFFD6FF23),
                    ),
                  );
                },
                icon: const Icon(Icons.backup, color: Colors.black),
                label: const Text(
                  'Backup Now',
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

            const SizedBox(height: 16),

            // Restore Backup
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                onPressed: () {
                  // Show restore options
                },
                icon: const Icon(Icons.restore, color: Color(0xFFD6FF23)),
                label: const Text(
                  'Restore from Backup',
                  style: TextStyle(color: Color(0xFFD6FF23), fontSize: 16),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFD6FF23)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}