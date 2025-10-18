import 'package:flutter/material.dart';

class StorageDetailsScreen extends StatelessWidget {
  const StorageDetailsScreen({super.key});

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
          'Storage Details',
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
                children: [
                  const Text(
                    'Storage Used',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Stack(
                    children: [
                      Container(
                        height: 20,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2A2F38),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Container(
                        height: 20,
                        width: MediaQuery.of(context).size.width * 0.65,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD6FF23),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '6.5 GB used',
                        style: TextStyle(color: Colors.white70),
                      ),
                      Text(
                        '10 GB total',
                        style: TextStyle(color: Colors.white70),
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
            const SizedBox(height: 16),

            _StorageItem(
              icon: Icons.folder,
              title: 'Projects',
              subtitle: 'Design files and assets',
              size: '3.2 GB',
              color: const Color(0xFFD6FF23),
              percentage: 32,
            ),
            _StorageItem(
              icon: Icons.image,
              title: 'Images',
              subtitle: 'Photos and graphics',
              size: '1.8 GB',
              color: Colors.blue,
              percentage: 18,
            ),
            _StorageItem(
              icon: Icons.video_file,
              title: 'Videos',
              subtitle: 'Video files and animations',
              size: '950 MB',
              color: Colors.red,
              percentage: 10,
            ),
            _StorageItem(
              icon: Icons.description,
              title: 'Documents',
              subtitle: 'PDFs and text files',
              size: '420 MB',
              color: Colors.orange,
              percentage: 4,
            ),
            _StorageItem(
              icon: Icons.archive,
              title: 'Archives',
              subtitle: 'ZIP and compressed files',
              size: '180 MB',
              color: Colors.purple,
              percentage: 2,
            ),

            const SizedBox(height: 24),

            // Quick Actions
            const Text(
              'Quick Actions',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: _ActionButton(
                    icon: Icons.cleaning_services,
                    title: 'Clear Cache',
                    subtitle: 'Free up space',
                    onTap: () {
                      // Clear cache
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _ActionButton(
                    icon: Icons.delete_sweep,
                    title: 'Delete Old Files',
                    subtitle: 'Remove unused items',
                    onTap: () {
                      // Delete old files
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: _ActionButton(
                    icon: Icons.cloud_upload,
                    title: 'Backup Files',
                    subtitle: 'Save to cloud',
                    onTap: () {
                      // Backup files
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _ActionButton(
                    icon: Icons.storage,
                    title: 'Manage Storage',
                    subtitle: 'Storage settings',
                    onTap: () {
                      // Manage storage
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _StorageItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String size;
  final Color color;
  final int percentage;

  const _StorageItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.size,
    required this.color,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2029),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF2A2F38)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                size,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '$percentage%',
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1A2029),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF2A2F38)),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFD6FF23).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: const Color(0xFFD6FF23)),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}