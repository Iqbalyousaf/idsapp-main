import 'package:flutter/material.dart';

class ProfileHelpScreen extends StatelessWidget {
  const ProfileHelpScreen({super.key});

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
          'Help & Support',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A2029),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF2A2F38)),
              ),
              child: const TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search help topics...',
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                  icon: Icon(Icons.search, color: Colors.white54),
                ),
              ),
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
                  child: _QuickActionCard(
                    icon: Icons.chat_bubble_outline,
                    title: 'Live Chat',
                    subtitle: 'Get instant help',
                    onTap: () {
                      // Open live chat
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _QuickActionCard(
                    icon: Icons.phone_outlined,
                    title: 'Call Support',
                    subtitle: 'Speak to an expert',
                    onTap: () {
                      // Open phone dialer
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // FAQ Section
            const Text(
              'Frequently Asked Questions',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _FAQItem(
              question: 'How do I create a new project?',
              answer: 'Tap the "+" button on the home screen, then select "Create New" and choose your project type.',
            ),
            _FAQItem(
              question: 'How do I save my designs?',
              answer: 'Use the save button in the design tools or go to Settings > Backup to enable automatic saving.',
            ),
            _FAQItem(
              question: 'Can I collaborate with team members?',
              answer: 'Yes! Create a team project and invite members through the project settings.',
            ),
            _FAQItem(
              question: 'How do I change my password?',
              answer: 'Go to Settings > Security > Change Password to update your credentials.',
            ),

            const SizedBox(height: 24),

            // Contact Information
            const Text(
              'Contact Information',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1A2029),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF2A2F38)),
              ),
              child: Column(
                children: [
                  _ContactItem(
                    icon: Icons.email_outlined,
                    title: 'Email Support',
                    subtitle: 'support@inventordesign.com',
                    onTap: () {
                      // Open email client
                    },
                  ),
                  const Divider(color: Color(0xFF2A2F38), height: 20),
                  _ContactItem(
                    icon: Icons.phone_outlined,
                    title: 'Phone Support',
                    subtitle: '+1 (555) 123-4567',
                    onTap: () {
                      // Open phone dialer
                    },
                  ),
                  const Divider(color: Color(0xFF2A2F38), height: 20),
                  _ContactItem(
                    icon: Icons.language,
                    title: 'Website',
                    subtitle: 'www.inventordesign.com/support',
                    onTap: () {
                      // Open website
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // User Guide
            const Text(
              'User Guide',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1A2029),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF2A2F38)),
              ),
              child: Column(
                children: [
                  _GuideItem(
                    icon: Icons.play_circle_outline,
                    title: 'Getting Started Tutorial',
                    duration: '5 min',
                    onTap: () {
                      // Play tutorial
                    },
                  ),
                  const Divider(color: Color(0xFF2A2F38), height: 16),
                  _GuideItem(
                    icon: Icons.design_services,
                    title: 'Design Tools Guide',
                    duration: '8 min',
                    onTap: () {
                      // Open design guide
                    },
                  ),
                  const Divider(color: Color(0xFF2A2F38), height: 16),
                  _GuideItem(
                    icon: Icons.group_work,
                    title: 'Team Collaboration',
                    duration: '6 min',
                    onTap: () {
                      // Open collaboration guide
                    },
                  ),
                  const Divider(color: Color(0xFF2A2F38), height: 16),
                  _GuideItem(
                    icon: Icons.settings,
                    title: 'Settings & Preferences',
                    duration: '4 min',
                    onTap: () {
                      // Open settings guide
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Report Issue
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Open bug report form
                },
                icon: const Icon(Icons.bug_report, color: Colors.white),
                label: const Text(
                  'Report an Issue',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.withValues(alpha: 0.2),
                  side: const BorderSide(color: Colors.orange),
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

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _QuickActionCard({
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
                fontWeight: FontWeight.bold,
              ),
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

class _FAQItem extends StatefulWidget {
  final String question;
  final String answer;

  const _FAQItem({
    required this.question,
    required this.answer,
  });

  @override
  State<_FAQItem> createState() => _FAQItemState();
}

class _FAQItemState extends State<_FAQItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2029),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF2A2F38)),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() => _isExpanded = !_isExpanded);
            },
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.question,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Icon(
                    _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: Colors.white70,
                  ),
                ],
              ),
            ),
          ),
          if (_isExpanded)
            Container(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                widget.answer,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ContactItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
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
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.white54,
            size: 16,
          ),
        ],
      ),
    );
  }
}

class _GuideItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String duration;
  final VoidCallback onTap;

  const _GuideItem({
    required this.icon,
    required this.title,
    required this.duration,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFD6FF23).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              duration,
              style: const TextStyle(
                color: Color(0xFFD6FF23),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}