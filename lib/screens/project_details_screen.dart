import 'package:flutter/material.dart';
import 'package:inventor_desgin_studio/screens/chat_screen.dart';
import 'package:inventor_desgin_studio/screens/edit_project_screen.dart';
import 'package:inventor_desgin_studio/screens/team_management_screen.dart';

class ProjectDetailsScreen extends StatefulWidget {
  final String projectTitle;
  final String projectSubtitle;
  final String status;
  final Color statusColor;

  const ProjectDetailsScreen({
    super.key,
    required this.projectTitle,
    required this.projectSubtitle,
    required this.status,
    required this.statusColor,
  });

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  void _showShareOptions() {
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
            const Text(
              'Share Project',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ShareOption(
                  icon: Icons.link,
                  label: 'Copy Link',
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Project link copied to clipboard'),
                        backgroundColor: Color(0xFFD6FF23),
                      ),
                    );
                  },
                ),
                _ShareOption(
                  icon: Icons.email,
                  label: 'Email',
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Opening email client...'),
                        backgroundColor: Color(0xFFD6FF23),
                      ),
                    );
                  },
                ),
                _ShareOption(
                  icon: Icons.message,
                  label: 'Message',
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Opening messaging app...'),
                        backgroundColor: Color(0xFFD6FF23),
                      ),
                    );
                  },
                ),
                _ShareOption(
                  icon: Icons.share,
                  label: 'More',
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Opening share menu...'),
                        backgroundColor: Color(0xFFD6FF23),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showMoreOptions() {
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
            const Text(
              'Project Options',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _OptionTile(
              icon: Icons.edit,
              title: 'Edit Project',
              subtitle: 'Modify project details',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditProjectScreen(
                      projectTitle: widget.projectTitle,
                      projectSubtitle: widget.projectSubtitle,
                      status: widget.status,
                      statusColor: widget.statusColor,
                    ),
                  ),
                );
              },
            ),
            const Divider(color: Color(0xFF2A2F38), height: 1),
            _OptionTile(
              icon: Icons.people,
              title: 'Manage Team',
              subtitle: 'Add or remove team members',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TeamManagementScreen(
                      projectTitle: widget.projectTitle,
                    ),
                  ),
                );
              },
            ),
            const Divider(color: Color(0xFF2A2F38), height: 1),
            _OptionTile(
              icon: Icons.archive,
              title: 'Archive Project',
              subtitle: 'Move to archived projects',
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Project archived'),
                    backgroundColor: Color(0xFFD6FF23),
                  ),
                );
              },
            ),
            const Divider(color: Color(0xFF2A2F38), height: 1),
            _OptionTile(
              icon: Icons.delete,
              title: 'Delete Project',
              subtitle: 'Permanently delete this project',
              textColor: Colors.red,
              onTap: () {
                Navigator.pop(context);
                _showDeleteConfirmation();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A2029),
        title: const Text(
          'Delete Project',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Are you sure you want to delete this project? This action cannot be undone.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.white70)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Go back to projects list
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Project deleted successfully'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            child: const Text(
              'Delete',
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
        title: Text(
          widget.projectTitle,
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white70),
            onPressed: () {
              _showShareOptions();
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white70),
            onPressed: () {
              _showMoreOptions();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project Header
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
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: widget.statusColor.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: widget.statusColor.withValues(alpha: 0.5)),
                        ),
                        child: Text(
                          widget.status,
                          style: TextStyle(
                            color: widget.statusColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.projectTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.projectSubtitle,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Row(
                       children: [
                         const Icon(Icons.calendar_today, color: Colors.white54, size: 16),
                         const SizedBox(width: 8),
                         Flexible(
                           child: Text(
                             'Created 2 days ago',
                             style: const TextStyle(color: Colors.white54, fontSize: 14),
                             overflow: TextOverflow.ellipsis,
                           ),
                         ),
                       ],
                     ),
                     const SizedBox(height: 6),
                     Row(
                       children: [
                         const Icon(Icons.access_time, color: Colors.white54, size: 16),
                         const SizedBox(width: 8),
                         Flexible(
                           child: Text(
                             'Last updated today',
                             style: const TextStyle(color: Colors.white54, fontSize: 14),
                             overflow: TextOverflow.ellipsis,
                           ),
                         ),
                       ],
                     ),
                   ],
                 ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Progress Section
            const Text(
              'Progress',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Overall Progress',
                        style: TextStyle(color: Colors.white70),
                      ),
                      Text(
                        '75%',
                        style: TextStyle(
                          color: const Color(0xFFD6FF23),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  LinearProgressIndicator(
                    value: 0.75,
                    backgroundColor: const Color(0xFF2A2F38),
                    valueColor: AlwaysStoppedAnimation<Color>(const Color(0xFFD6FF23)),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _ProgressItem(label: 'Design', value: '100%', color: Colors.green),
                      _ProgressItem(label: 'Development', value: '80%', color: const Color(0xFFD6FF23)),
                      _ProgressItem(label: 'Testing', value: '50%', color: Colors.orange),
                    ],
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
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A2029),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF2A2F38)),
              ),
              child: Column(
                children: [
                  _TeamMember(
                    name: 'John Doe',
                    role: 'UI/UX Designer',
                    avatar: 'https://i.pravatar.cc/150?img=1',
                  ),
                  const Divider(color: Color(0xFF2A2F38), height: 16),
                  _TeamMember(
                    name: 'Jane Smith',
                    role: 'Developer',
                    avatar: 'https://i.pravatar.cc/150?img=2',
                  ),
                  const Divider(color: Color(0xFF2A2F38), height: 16),
                  _TeamMember(
                    name: 'Mike Johnson',
                    role: 'Project Manager',
                    avatar: 'https://i.pravatar.cc/150?img=3',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Recent Activity
            const Text(
              'Recent Activity',
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
                  _ActivityItem(
                    user: 'John Doe',
                    action: 'Updated design mockups',
                    time: '2 hours ago',
                    avatar: 'https://i.pravatar.cc/150?img=1',
                  ),
                  const Divider(color: Color(0xFF2A2F38), height: 16),
                  _ActivityItem(
                    user: 'Jane Smith',
                    action: 'Completed API integration',
                    time: '4 hours ago',
                    avatar: 'https://i.pravatar.cc/150?img=2',
                  ),
                  const Divider(color: Color(0xFF2A2F38), height: 16),
                  _ActivityItem(
                    user: 'Mike Johnson',
                    action: 'Reviewed project progress',
                    time: '1 day ago',
                    avatar: 'https://i.pravatar.cc/150?img=3',
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

class _ShareOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ShareOption({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 70,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF0E131A),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF2A2F38)),
        ),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFFD6FF23), size: 24),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
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

class _OptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color? textColor;
  final VoidCallback onTap;

  const _OptionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.textColor,
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
        style: TextStyle(
          color: textColor ?? Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: textColor?.withValues(alpha: 0.7) ?? Colors.white70,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: textColor?.withValues(alpha: 0.5) ?? Colors.white54,
        size: 16,
      ),
      onTap: onTap,
    );
  }
}

class _ProgressItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _ProgressItem({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _TeamMember extends StatelessWidget {
  final String name;
  final String role;
  final String avatar;

  const _TeamMember({
    required this.name,
    required this.role,
    required this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(avatar),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                role,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.message, color: Colors.white54, size: 20),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChatScreen(
                  memberName: name,
                  memberRole: role,
                  memberAvatar: avatar,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _ActivityItem extends StatelessWidget {
  final String user;
  final String action;
  final String time;
  final String avatar;

  const _ActivityItem({
    required this.user,
    required this.action,
    required this.time,
    required this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundImage: NetworkImage(avatar),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: user,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: ' $action',
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
              Text(
                time,
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}