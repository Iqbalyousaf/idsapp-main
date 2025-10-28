import 'package:flutter/material.dart';
import 'package:inventor_desgin_studio/theme/constants.dart';
import 'package:inventor_desgin_studio/screens/browse_files_screen.dart';
import 'package:inventor_desgin_studio/providers/projects_provider.dart';
import 'package:inventor_desgin_studio/providers/user_provider.dart';
import 'package:provider/provider.dart';

class RecentProjects extends StatefulWidget {
  const RecentProjects({super.key});

  @override
  State<RecentProjects> createState() => _RecentProjectsState();
}

class _RecentProjectsState extends State<RecentProjects> {
  @override
  void initState() {
    super.initState();
    // Initialize projects when widget is created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final projectsProvider = Provider.of<ProjectsProvider>(context, listen: false);

      // Only load projects if user is authenticated
      if (userProvider.isAuthenticated) {
        projectsProvider.initializeProjects();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<UserProvider, ProjectsProvider>(
      builder: (context, userProvider, projectsProvider, child) {
        // Show empty state if user is not authenticated
        if (!userProvider.isAuthenticated) {
          return const _EmptyProjectsState();
        }

        // Show loading state
        if (projectsProvider.isLoading && projectsProvider.projects.isEmpty) {
          return const _LoadingProjectsState();
        }

        // Show empty state if no projects
        if (!projectsProvider.hasProjects) {
          return const _EmptyProjectsState();
        }

        // Show projects list
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
              itemCount: projectsProvider.projects.length,
              itemBuilder: (context, index) {
                final project = projectsProvider.projects[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ProjectTile(
                    title: project.title,
                    subtitle: project.description ?? 'No description',
                    chip: StatusChip(text: project.status, color: project.getStatusColor()),
                    timeAgo: project.getTimeAgo(),
                    icon: project.getStatusIcon(),
                    iconColor: project.getStatusColor(),
                  ),
                );
              },
            ),
          ],
        );
      },
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

// Loading state widget
class _LoadingProjectsState extends StatelessWidget {
  const _LoadingProjectsState();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('Recent Designs',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
            const Spacer(),
            TextButton(
              onPressed: () {},
              child: const Text('View All', style: TextStyle(color: kNeon)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }
}

// Empty state widget
class _EmptyProjectsState extends StatelessWidget {
  const _EmptyProjectsState();

  @override
  Widget build(BuildContext context) {
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
        Container(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          decoration: BoxDecoration(
            color: kCard,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: kStroke),
          ),
          child: const Center(
            child: Column(
              children: [
                Icon(Icons.folder_open, size: 48, color: Colors.white38),
                SizedBox(height: 16),
                Text(
                  'Nothing here yet',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Your projects will appear here',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white54,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}