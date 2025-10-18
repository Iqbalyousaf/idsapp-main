import 'package:flutter/material.dart';

class StorageScreen extends StatefulWidget {
  const StorageScreen({super.key});

  @override
  State<StorageScreen> createState() => _StorageScreenState();
}

class _StorageScreenState extends State<StorageScreen> {
  final double _usedStorage = 2.4; // GB
  final double _totalStorage = 5.0; // GB

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
          'Storage',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Storage Overview
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
                  const Text(
                    'Storage Overview',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: _usedStorage / _totalStorage,
                    backgroundColor: const Color(0xFF2A2F38),
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFD6FF23)),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${_usedStorage.toStringAsFixed(1)} GB used',
                        style: const TextStyle(color: Colors.white70),
                      ),
                      Text(
                        '${(_totalStorage - _usedStorage).toStringAsFixed(1)} GB free',
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Storage Breakdown
            const Text(
              'Storage Breakdown',
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
                  _StorageItem(
                    icon: Icons.folder,
                    title: 'Projects',
                    size: '1.2 GB',
                    color: Colors.blue,
                    onTap: () {
                      // Navigate to projects storage
                    },
                  ),
                  const Divider(color: Color(0xFF2A2F38), height: 1),
                  _StorageItem(
                    icon: Icons.image,
                    title: 'Images',
                    size: '0.8 GB',
                    color: Colors.green,
                    onTap: () {
                      // Navigate to images storage
                    },
                  ),
                  const Divider(color: Color(0xFF2A2F38), height: 1),
                  _StorageItem(
                    icon: Icons.video_file,
                    title: 'Videos',
                    size: '0.3 GB',
                    color: Colors.orange,
                    onTap: () {
                      // Navigate to videos storage
                    },
                  ),
                  const Divider(color: Color(0xFF2A2F38), height: 1),
                  _StorageItem(
                    icon: Icons.insert_drive_file,
                    title: 'Documents',
                    size: '0.1 GB',
                    color: Colors.purple,
                    onTap: () {
                      // Navigate to documents storage
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Storage Management
            const Text(
              'Storage Management',
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
                  _StorageTile(
                    icon: Icons.cleaning_services,
                    title: 'Clear Cache',
                    subtitle: 'Free up storage space',
                    onTap: () {
                      _showClearCacheDialog();
                    },
                  ),
                  const Divider(color: Color(0xFF2A2F38), height: 1),
                  _StorageTile(
                    icon: Icons.delete_sweep,
                    title: 'Delete Old Files',
                    subtitle: 'Remove unused files',
                    onTap: () {
                      // Navigate to delete old files
                    },
                  ),
                  const Divider(color: Color(0xFF2A2F38), height: 1),
                  _StorageTile(
                    icon: Icons.cloud_upload,
                    title: 'Move to Cloud',
                    subtitle: 'Store files in the cloud',
                    onTap: () {
                      // Navigate to cloud storage
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Storage Tips
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFD6FF23).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFD6FF23).withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.lightbulb,
                    color: Color(0xFFD6FF23),
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Storage Tip',
                          style: TextStyle(
                            color: Color(0xFFD6FF23),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Regularly clear your cache and delete unused files to keep your storage optimized.',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
          'This will clear all cached data. You can redownload content as needed. Continue?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.white70)),
          ),
          TextButton(
            onPressed: () {
              // Clear cache logic
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
              style: TextStyle(color: Color(0xFFD6FF23)),
            ),
          ),
        ],
      ),
    );
  }
}

class _StorageItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String size;
  final Color color;
  final VoidCallback onTap;

  const _StorageItem({
    required this.icon,
    required this.title,
    required this.size,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: color),
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        size,
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

class _StorageTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _StorageTile({
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