import 'package:flutter/material.dart';
import 'package:inventor_desgin_studio/theme/constants.dart';
import 'package:inventor_desgin_studio/screens/browse_files_screen.dart';

class RecentProjects extends StatelessWidget {
  const RecentProjects({super.key});

  @override
  Widget build(BuildContext context) {
    const items = [
      ProjectTile(
        title: 'Mobile App UI',
        subtitle: 'E-commerce application design',
        chip: StatusChip(text: 'Progress', color: Color(0xFF63E6FF)),
        timeAgo: '2 days ago',
        icon: Icons.chat_bubble_outline,
        iconColor: Color(0xFF63E6FF),
      ),
      ProjectTile(
        title: 'Dashboard Design',
        subtitle: 'Analytics dashboard for SaaS',
        chip: StatusChip(text: 'Completed', color: Color(0xFF4ADE80)),
        timeAgo: '5 days ago',
        icon: Icons.dashboard_outlined,
        iconColor: Color(0xFF4ADE80),
      ),
      ProjectTile(
        title: 'Brand Identity',
        subtitle: 'Logo and brand guidelines',
        chip: StatusChip(text: 'Review', color: Color(0xFFFFC857)),
        timeAgo: '1 week ago',
        icon: Icons.brush_outlined,
        iconColor: Color(0xFFFFC857),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('Recent Designs',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
            const Spacer(),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const BrowseFilesScreen()),
              ),
              child: const Text('View All', style: TextStyle(color: kNeon)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: items[index],
            );
          },
        ),
      ],
    );
  }
}

class ProjectTile extends StatelessWidget {
  final String title, subtitle, timeAgo;
  final IconData icon;
  final Color iconColor;
  final StatusChip chip;

  const ProjectTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.timeAgo,
    required this.icon,
    required this.iconColor,
    required this.chip,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: kStroke),
      ),
      child: ListTile(
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        visualDensity: VisualDensity.compact,
        isThreeLine: true,
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: .18),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              subtitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 6),
            Wrap(
              spacing: 10,
              runSpacing: 6,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                chip,
                Text(timeAgo, style: const TextStyle(color: Colors.white54)),
              ],
            ),
          ],
        ),
        trailing: IconButton(
          constraints: const BoxConstraints.tightFor(width: 36, height: 36),
          padding: EdgeInsets.zero,
          onPressed: () {
            // Navigate to design details or edit screen
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Opening $title')),
            );
          },
          icon: const Icon(Icons.more_horiz, color: Colors.white54),
        ),
      ),
    );
  }
}

class StatusChip extends StatelessWidget {
  final String text;
  final Color color;
  const StatusChip({super.key, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .15),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: .5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              width: 6,
              height: 6,
              decoration:
              BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 6),
          Text(text,
              style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}