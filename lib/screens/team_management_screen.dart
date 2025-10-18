import 'package:flutter/material.dart';

class TeamManagementScreen extends StatefulWidget {
  final String projectTitle;

  const TeamManagementScreen({
    super.key,
    required this.projectTitle,
  });

  @override
  State<TeamManagementScreen> createState() => _TeamManagementScreenState();
}

class _TeamManagementScreenState extends State<TeamManagementScreen> {
  final List<Map<String, dynamic>> _teamMembers = [
    {
      'name': 'John Doe',
      'role': 'UI/UX Designer',
      'avatar': 'https://i.pravatar.cc/150?img=1',
      'email': 'john.doe@example.com',
      'status': 'Active',
    },
    {
      'name': 'Jane Smith',
      'role': 'Developer',
      'avatar': 'https://i.pravatar.cc/150?img=2',
      'email': 'jane.smith@example.com',
      'status': 'Active',
    },
    {
      'name': 'Mike Johnson',
      'role': 'Project Manager',
      'avatar': 'https://i.pravatar.cc/150?img=3',
      'email': 'mike.johnson@example.com',
      'status': 'Active',
    },
  ];

  void _addTeamMember() {
    // Show dialog to add new member
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A2029),
        title: const Text(
          'Add Team Member',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Team member invitation feature coming soon',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK', style: TextStyle(color: Color(0xFFD6FF23))),
          ),
        ],
      ),
    );
  }

  void _removeTeamMember(int index) {
    final member = _teamMembers[index];
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A2029),
        title: const Text(
          'Remove Team Member',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'Are you sure you want to remove ${member['name']} from the team?',
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.white70)),
          ),
          TextButton(
            onPressed: () {
              setState(() => _teamMembers.removeAt(index));
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${member['name']} removed from team'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            child: const Text(
              'Remove',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

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
          'Team Management',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add, color: Color(0xFFD6FF23)),
            onPressed: _addTeamMember,
            tooltip: 'Add Member',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project Info
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
                  Text(
                    widget.projectTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${_teamMembers.length} team members',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Team Members
            const Text(
              'Team Members',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _teamMembers.length,
              itemBuilder: (context, index) {
                final member = _teamMembers[index];
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
                      CircleAvatar(
                        radius: 24,
                        backgroundImage: NetworkImage(member['avatar']),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              member['name'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              member['role'],
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              member['email'],
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.green.withValues(alpha: 0.5)),
                        ),
                        child: const Text(
                          'Active',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      PopupMenuButton<String>(
                        icon: const Icon(
                          Icons.more_vert,
                          color: Colors.white54,
                        ),
                        color: const Color(0xFF1A2029),
                        onSelected: (value) {
                          switch (value) {
                            case 'message':
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Opening chat with ${member['name']}'),
                                  backgroundColor: const Color(0xFFD6FF23),
                                ),
                              );
                              break;
                            case 'change_role':
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Change role feature coming soon'),
                                  backgroundColor: Color(0xFFD6FF23),
                                ),
                              );
                              break;
                            case 'remove':
                              _removeTeamMember(index);
                              break;
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'message',
                            child: Text('Send Message', style: TextStyle(color: Colors.white)),
                          ),
                          const PopupMenuItem(
                            value: 'change_role',
                            child: Text('Change Role', style: TextStyle(color: Colors.white)),
                          ),
                          const PopupMenuItem(
                            value: 'remove',
                            child: Text('Remove Member', style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 24),

            // Team Statistics
            const Text(
              'Team Statistics',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A2029),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF2A2F38)),
              ),
              child: Column(
                children: [
                  _StatItem(
                    icon: Icons.group,
                    title: 'Total Members',
                    value: '${_teamMembers.length}',
                    color: const Color(0xFFD6FF23),
                  ),
                  const Divider(color: Color(0xFF2A2F38), height: 16),
                  _StatItem(
                    icon: Icons.design_services,
                    title: 'Designers',
                    value: '${_teamMembers.where((m) => m['role'].contains('Designer')).length}',
                    color: Colors.blue,
                  ),
                  const Divider(color: Color(0xFF2A2F38), height: 16),
                  _StatItem(
                    icon: Icons.code,
                    title: 'Developers',
                    value: '${_teamMembers.where((m) => m['role'].contains('Developer')).length}',
                    color: Colors.green,
                  ),
                  const Divider(color: Color(0xFF2A2F38), height: 16),
                  _StatItem(
                    icon: Icons.manage_accounts,
                    title: 'Project Managers',
                    value: '${_teamMembers.where((m) => m['role'].contains('Manager')).length}',
                    color: Colors.orange,
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
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const _StatItem({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}