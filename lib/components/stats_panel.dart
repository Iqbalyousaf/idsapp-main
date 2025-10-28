import 'package:flutter/material.dart';
import 'package:inventor_desgin_studio/theme/constants.dart';
import 'package:inventor_desgin_studio/providers/user_provider.dart';
import 'package:inventor_desgin_studio/providers/projects_provider.dart';
import 'package:inventor_desgin_studio/services/api_service.dart';
import 'package:provider/provider.dart';

class StatsPanel extends StatefulWidget {
  const StatsPanel({super.key});

  @override
  State<StatsPanel> createState() => _StatsPanelState();
}

class _StatsPanelState extends State<StatsPanel> {
  int _activeProjects = 0;
  String _timeSpent = '0h';
  bool _isLoadingStats = false;

  @override
  void initState() {
    super.initState();
    // Initialize stats when widget is created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final projectsProvider = Provider.of<ProjectsProvider>(context, listen: false);

      // Only load stats if user is authenticated
      if (userProvider.isAuthenticated) {
        _loadStats(projectsProvider);
      }
    });
  }

  Future<void> _loadStats(ProjectsProvider projectsProvider) async {
    if (_isLoadingStats) return;

    setState(() {
      _isLoadingStats = true;
    });

    try {
      // Count active projects (projects with status 'progress' or 'in_progress')
      final activeCount = projectsProvider.projects
          .where((project) => project.status.toLowerCase() == 'progress' ||
                             project.status.toLowerCase() == 'in_progress')
          .length;

      // Fetch time spent from API
      final apiService = ApiService();
      final statsResponse = await apiService.getUserStats();
      final timeSpentMinutes = statsResponse['time_spent_this_week'] ?? 0;
      final timeSpentHours = (timeSpentMinutes / 60).round();

      setState(() {
        _activeProjects = activeCount;
        _timeSpent = '${timeSpentHours}h';
      });
    } catch (e) {
      // If API fails, keep current values or set to 0
      final activeCount = projectsProvider.projects
          .where((project) => project.status.toLowerCase() == 'progress' ||
                             project.status.toLowerCase() == 'in_progress')
          .length;

      setState(() {
        _activeProjects = activeCount;
        _timeSpent = '0h';
      });
    } finally {
      setState(() {
        _isLoadingStats = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<UserProvider, ProjectsProvider>(
      builder: (context, userProvider, projectsProvider, child) {
        // Update stats when projects change
        if (userProvider.isAuthenticated) {
          _loadStats(projectsProvider);
        }

        return Row(
          children: [
            Expanded(
              child: StatCard(
                title: 'Projects',
                value: userProvider.isAuthenticated ? _activeProjects.toString() : '0',
                subtitle: 'Active',
                icon: Icons.auto_awesome_motion,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StatCard(
                title: 'This week',
                value: userProvider.isAuthenticated ? _timeSpent : '0h',
                subtitle: 'Time spent',
                icon: Icons.timer_outlined,
              ),
            ),
          ],
        );
      },
    );
  }
}

class StatCard extends StatelessWidget {
  final String title, value, subtitle;
  final IconData icon;
  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: kStroke),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: kNeon.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: kNeon, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w800)),
                const SizedBox(height: 2),
                Text(title, style: const TextStyle(color: Colors.white70)),
                Text(subtitle, style: const TextStyle(color: Colors.white38)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}