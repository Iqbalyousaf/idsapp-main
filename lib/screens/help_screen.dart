import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

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

            // Quick Help
            const Text(
              'Quick Help',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: [
                _HelpCard(
                  icon: Icons.create,
                  title: 'Getting Started',
                  description: 'Learn the basics',
                  onTap: () {
                    // Navigate to getting started guide
                  },
                ),
                _HelpCard(
                  icon: Icons.design_services,
                  title: 'Design Tools',
                  description: 'How to use design tools',
                  onTap: () {
                    // Navigate to design tools help
                  },
                ),
                _HelpCard(
                  icon: Icons.folder,
                  title: 'Projects',
                  description: 'Manage your projects',
                  onTap: () {
                    // Navigate to projects help
                  },
                ),
                _HelpCard(
                  icon: Icons.group,
                  title: 'Collaboration',
                  description: 'Work with your team',
                  onTap: () {
                    // Navigate to collaboration help
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Frequently Asked Questions
            const Text(
              'Frequently Asked Questions',
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
                  _FAQItem(
                    question: 'How do I create a new project?',
                    answer: 'Tap the "+" button in the bottom navigation, then select "Project" and fill in the details.',
                    onTap: () {
                      // Expand/collapse answer
                    },
                  ),
                  const Divider(color: Color(0xFF2A2F38), height: 1),
                  _FAQItem(
                    question: 'How do I invite team members?',
                    answer: 'Go to your project, tap the team tab, and use the invite button to add members.',
                    onTap: () {
                      // Expand/collapse answer
                    },
                  ),
                  const Divider(color: Color(0xFF2A2F38), height: 1),
                  _FAQItem(
                    question: 'How do I export my designs?',
                    answer: 'Open your design, tap the export button, and choose your preferred format.',
                    onTap: () {
                      // Expand/collapse answer
                    },
                  ),
                  const Divider(color: Color(0xFF2A2F38), height: 1),
                  _FAQItem(
                    question: 'How do I backup my data?',
                    answer: 'Go to Settings > Data & Storage > Backup & Restore to manage your backups.',
                    onTap: () {
                      // Expand/collapse answer
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Contact Support
            const Text(
              'Contact Support',
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
                  _ContactTile(
                    icon: Icons.email,
                    title: 'Email Support',
                    subtitle: 'support@inventordesign.com',
                    onTap: () {
                      // Open email client
                    },
                  ),
                  const Divider(color: Color(0xFF2A2F38), height: 1),
                  _ContactTile(
                    icon: Icons.chat,
                    title: 'Live Chat',
                    subtitle: 'Chat with our support team',
                    onTap: () {
                      // Open live chat
                    },
                  ),
                  const Divider(color: Color(0xFF2A2F38), height: 1),
                  _ContactTile(
                    icon: Icons.phone,
                    title: 'Phone Support',
                    subtitle: '+1 (555) 123-4567',
                    onTap: () {
                      // Make phone call
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // User Guide
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFD6FF23).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFD6FF23).withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.menu_book,
                    color: Color(0xFFD6FF23),
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'User Guide',
                          style: TextStyle(
                            color: Color(0xFFD6FF23),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Download our comprehensive user guide for detailed instructions.',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
                            // Download user guide
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD6FF23),
                            foregroundColor: Colors.black,
                            minimumSize: const Size(80, 32),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                          ),
                          child: const Text(
                            'Download',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
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
}

class _HelpCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  const _HelpCard({
    required this.icon,
    required this.title,
    required this.description,
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFFD6FF23).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: const Color(0xFFD6FF23),
                size: 24,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              description,
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

class _FAQItem extends StatelessWidget {
  final String question;
  final String answer;
  final VoidCallback onTap;

  const _FAQItem({
    required this.question,
    required this.answer,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        question,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
      iconColor: const Color(0xFFD6FF23),
      collapsedIconColor: Colors.white54,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            answer,
            style: const TextStyle(color: Colors.white70),
          ),
        ),
      ],
    );
  }
}

class _ContactTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ContactTile({
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