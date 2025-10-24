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
  bool _isLoading = false;

  final List<String> _roles = ['Designer', 'Developer', 'Manager', 'Client'];

  final List<Map<String, dynamic>> _pendingInvites = [
    {
      'email': 'alice@example.com',
      'role': 'Designer',
      'status': 'Pending',
      'sentDate': '2024-01-15',
    },
    {
      'email': 'bob@example.com',
      'role': 'Developer',
      'status': 'Pending',
      'sentDate': '2024-01-14',
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
          'Team Invites',
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
            // Invite Form
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
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFF2A2F38)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFFD6FF23)),
                      ),
                      filled: true,
                      fillColor: const Color(0xFF0E131A),
                      prefixIcon: const Icon(Icons.email, color: Colors.white54),
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
                      labelText: 'Role',
                      labelStyle: const TextStyle(color: Colors.white70),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFF2A2F38)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFFD6FF23)),
                      ),
                      filled: true,
                      fillColor: const Color(0xFF0E131A),
                      prefixIcon: const Icon(Icons.work, color: Colors.white54),
                    ),
                    items: _roles.map((role) {
                      return DropdownMenuItem(
                        value: role,
                        child: Text(role),
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
                      hintText: 'Add a personal message to the invitation...',
                      hintStyle: const TextStyle(color: Colors.white38),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFF2A2F38)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFFD6FF23)),
                      ),
                      filled: true,
                      fillColor: const Color(0xFF0E131A),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Send Invite Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _sendInvite,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kNeon,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.black,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'Send Invitation',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Pending Invites
            const Text(
              'Pending Invitations',
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
              itemCount: _pendingInvites.length,
              itemBuilder: (context, index) {
                final invite = _pendingInvites[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
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
                          color: kNeon.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.person_add,
                          color: kNeon,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              invite['email'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '${invite['role']} • Sent ${invite['sentDate']}',
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
                          color: Colors.orange.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.orange.withValues(alpha: 0.5)),
                        ),
                        child: const Text(
                          'Pending',
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.more_vert, color: Colors.white54),
                        onPressed: () => _showInviteOptions(context, invite),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 24),

            // Team Members Section
            const Text(
              'Current Team Members',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Placeholder for team members
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0xFF1A2029),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF2A2F38)),
              ),
              child: const Center(
                child: Text(
                  'Team members will be displayed here',
                  style: TextStyle(color: Colors.white54),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendInvite() async {
    if (_emailController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter an email address'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isLoading = false);

    // Add to pending invites
    setState(() {
      _pendingInvites.add({
        'email': _emailController.text.trim(),
        'role': _selectedRole,
        'status': 'Pending',
        'sentDate': DateTime.now().toString().split(' ')[0],
      });
    });

    // Clear form
    _emailController.clear();
    _messageController.clear();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invitation sent successfully!'),
          backgroundColor: Color(0xFFD6FF23),
        ),
      );
    }
  }

  void _showInviteOptions(BuildContext context, Map<String, dynamic> invite) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A2029),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.email, color: Colors.white70),
              title: const Text('Resend Invitation', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                _resendInvite(invite);
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit, color: Colors.white70),
              title: const Text('Edit Invitation', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                _editInvite(invite);
              },
            ),
            ListTile(
              leading: const Icon(Icons.cancel, color: Colors.red),
              title: const Text('Cancel Invitation', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                _cancelInvite(invite);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _resendInvite(Map<String, dynamic> invite) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Resending invitation to ${invite['email']}'),
        backgroundColor: kNeon,
      ),
    );
  }

  void _editInvite(Map<String, dynamic> invite) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Editing invitation for ${invite['email']}'),
        backgroundColor: kNeon,
      ),
    );
  }

  void _cancelInvite(Map<String, dynamic> invite) {
    setState(() {
      _pendingInvites.remove(invite);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Cancelled invitation to ${invite['email']}'),
        backgroundColor: Colors.red,
      ),
    );
  }
}