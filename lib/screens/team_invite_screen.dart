import 'package:flutter/material.dart';
import 'package:inventor_desgin_studio/theme/constants.dart';

class TeamInviteScreen extends StatefulWidget {
  const TeamInviteScreen({super.key});

  @override
  State<TeamInviteScreen> createState() => _TeamInviteScreenState();
}

class _TeamInviteScreenState extends State<TeamInviteScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  String _selectedRole = 'Designer';
  final List<String> _roles = ['Designer', 'Developer', 'Manager', 'Client', 'Lead Designer', 'Project Manager'];

  final List<Map<String, dynamic>> _teamMembers = [
    {
      'name': 'Sarah Johnson',
      'email': 'sarah.j@example.com',
      'role': 'Lead Designer',
      'status': 'Active',
      'avatar': 'SJ',
      'joinDate': '2024-01-15',
    },
    {
      'name': 'Mike Chen',
      'email': 'mike.c@example.com',
      'role': 'Developer',
      'status': 'Active',
      'avatar': 'MC',
      'joinDate': '2024-01-10',
    },
    {
      'name': 'Emma Wilson',
      'email': 'emma.w@example.com',
      'role': 'Project Manager',
      'status': 'Pending',
      'avatar': 'EW',
      'joinDate': '2024-01-20',
    },
  ];

  @override
  void dispose() {
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E131A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Team Management',
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
            // Invite Section
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
                    'Invite Team Member',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Email Field
                  TextField(
                    controller: _emailController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      labelStyle: const TextStyle(color: Colors.white70),
                      prefixIcon: const Icon(Icons.email, color: Colors.white54),
                      filled: true,
                      fillColor: const Color(0xFF0E131A),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 16),

                  // Role Dropdown
                  DropdownButtonFormField<String>(
                    value: _selectedRole,
                    style: const TextStyle(color: Colors.white),
                    dropdownColor: const Color(0xFF1A2029),
                    decoration: InputDecoration(
                      // labelText: 'Role',
                      labelStyle: const TextStyle(color: Colors.white70),
                      prefixIcon: const Icon(Icons.work, color: Colors.white54),
                      filled: true,
                      fillColor: const Color(0xFF0E131A),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                    items: _roles.map((role) {
                      return DropdownMenuItem(
                        value: role,
                        child: Text(role, style: const TextStyle(color: Colors.white)),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() => _selectedRole = value!);
                    },
                  ),

                  const SizedBox(height: 16),

                  // Message Field
                  TextField(
                    controller: _messageController,
                    style: const TextStyle(color: Colors.white),
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Personal Message (Optional)',
                      labelStyle: const TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: const Color(0xFF0E131A),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Invite Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _sendInvite,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kNeon,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Send Invitation',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Team Members Section
            const Text(
              'Team Members',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

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
                      // Avatar
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: kNeon.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            member['avatar'],
                            style: const TextStyle(
                              color: kNeon,
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 16),

                      // Member Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              member['name'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              member['email'],
                              style: const TextStyle(color: Colors.white54),
                            ),
                            Row(
                              children: [
                                Text(
                                  member['role'],
                                  style: const TextStyle(color: Colors.white70),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: member['status'] == 'Active'
                                        ? Colors.green.withValues(alpha: 0.2)
                                        : Colors.orange.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    member['status'],
                                    style: TextStyle(
                                      color: member['status'] == 'Active'
                                          ? Colors.green
                                          : Colors.orange,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Actions
                      PopupMenuButton<String>(
                        onSelected: (value) => _handleMemberAction(value, member),
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'edit',
                            child: Text('Edit Role'),
                          ),
                          const PopupMenuItem(
                            value: 'remove',
                            child: Text('Remove Member'),
                          ),
                        ],
                        icon: const Icon(Icons.more_vert, color: Colors.white54),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _sendInvite() {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter an email address'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Simulate sending invite
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Invitation sent to $email as $_selectedRole'),
        backgroundColor: kNeon,
      ),
    );

    // Clear form
    _emailController.clear();
    _messageController.clear();
    setState(() => _selectedRole = 'Designer');
  }

  void _handleMemberAction(String action, Map<String, dynamic> member) {
    switch (action) {
      case 'edit':
        _showEditRoleDialog(member);
        break;
      case 'remove':
        _showRemoveMemberDialog(member);
        break;
    }
  }

  void _showEditRoleDialog(Map<String, dynamic> member) {
    String newRole = member['role'];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A2029),
        title: Text(
          'Edit Role for ${member['name']}',
          style: const TextStyle(color: Colors.white),
        ),
        content: DropdownButtonFormField<String>(
          value: newRole,
          style: const TextStyle(color: Colors.white),
          dropdownColor: const Color(0xFF1A2029),
          decoration: const InputDecoration(
            filled: true,
            fillColor: Color(0xFF0E131A),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
          items: _roles.map((role) {
            return DropdownMenuItem(
              value: role,
              child: Text(role, style: const TextStyle(color: Colors.white)),
            );
          }).toList(),
          onChanged: (value) => newRole = value!,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.white70)),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() => member['role'] = newRole);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Role updated to $newRole'),
                  backgroundColor: kNeon,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: kNeon,
              foregroundColor: Colors.black,
            ),
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _showRemoveMemberDialog(Map<String, dynamic> member) {
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
          ElevatedButton(
            onPressed: () {
              setState(() => _teamMembers.remove(member));
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${member['name']} removed from team'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }
}