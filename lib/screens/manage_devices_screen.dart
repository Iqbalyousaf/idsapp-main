import 'package:flutter/material.dart';

class ManageDevicesScreen extends StatefulWidget {
  const ManageDevicesScreen({super.key});

  @override
  State<ManageDevicesScreen> createState() => _ManageDevicesScreenState();
}

class _ManageDevicesScreenState extends State<ManageDevicesScreen> {
  final List<Map<String, dynamic>> _devices = [
    {
      'name': 'iPhone 13 Pro',
      'type': 'Mobile',
      'location': 'San Francisco, CA',
      'lastActive': 'Now',
      'isCurrent': true,
      'icon': Icons.smartphone,
    },
    {
      'name': 'MacBook Pro',
      'type': 'Desktop',
      'location': 'San Francisco, CA',
      'lastActive': '2 hours ago',
      'isCurrent': false,
      'icon': Icons.laptop_mac,
    },
    {
      'name': 'iPad Air',
      'type': 'Tablet',
      'location': 'San Francisco, CA',
      'lastActive': '1 day ago',
      'isCurrent': false,
      'icon': Icons.tablet_mac,
    },
    {
      'name': 'Chrome Browser',
      'type': 'Web',
      'location': 'San Francisco, CA',
      'lastActive': '3 days ago',
      'isCurrent': false,
      'icon': Icons.web,
    },
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
          'Manage Devices',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Info
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
                      const Icon(
                        Icons.devices,
                        color: Color(0xFFD6FF23),
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '${_devices.length} Active Sessions',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Manage which devices have access to your account. You can sign out of devices you no longer use.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Current Device
            const Text(
              'Current Device',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            ..._devices.where((device) => device['isCurrent']).map((device) {
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A2029),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xFFD6FF23).withValues(alpha: 0.5)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD6FF23).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        device['icon'] as IconData,
                        color: const Color(0xFFD6FF23),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                device['name'] as String,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFD6FF23).withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Text(
                                  'Current',
                                  style: TextStyle(
                                    color: Color(0xFFD6FF23),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${device['type']} • ${device['location']}',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Last active: ${device['lastActive']}',
                            style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),

            const SizedBox(height: 24),

            // Other Devices
            const Text(
              'Other Devices',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            ..._devices.where((device) => !device['isCurrent']).map((device) {
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
                        color: const Color(0xFFD6FF23).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        device['icon'] as IconData,
                        color: const Color(0xFFD6FF23),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            device['name'] as String,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${device['type']} • ${device['location']}',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Last active: ${device['lastActive']}',
                            style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuButton<String>(
                      icon: const Icon(
                        Icons.more_vert,
                        color: Colors.white54,
                      ),
                      color: const Color(0xFF1A2029),
                      onSelected: (value) {
                        if (value == 'signout') {
                          _showSignOutDialog(device['name'] as String);
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'signout',
                          child: Text(
                            'Sign Out',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),

            const SizedBox(height: 24),

            // Security Notice
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.warning,
                    color: Colors.orange,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'If you see any unfamiliar devices, sign out immediately and change your password.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
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

  void _showSignOutDialog(String deviceName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A2029),
        title: const Text(
          'Sign Out Device',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'Are you sure you want to sign out of $deviceName?',
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.white70)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _devices.removeWhere((device) => device['name'] == deviceName);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Signed out of $deviceName'),
                  backgroundColor: const Color(0xFFD6FF23),
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