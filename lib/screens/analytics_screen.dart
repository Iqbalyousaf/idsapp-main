import 'package:flutter/material.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  String selectedTimeRange = '30d'; // Default to last 30 days

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
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
          'Analytics',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                selectedTimeRange = value;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Time range: $value selected'),
                  backgroundColor: const Color(0xFFD6FF23),
                ),
              );
              // Here you would typically refresh the analytics data based on the selected time range
              // For example: _loadAnalyticsData(selectedTimeRange);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: '7d', child: Text('Last 7 days')),
              const PopupMenuItem(value: '30d', child: Text('Last 30 days')),
              const PopupMenuItem(value: '90d', child: Text('Last 90 days')),
              const PopupMenuItem(value: '1y', child: Text('Last year')),
            ],
            icon: const Icon(Icons.calendar_today, color: Colors.white70),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFFD6FF23),
          labelColor: const Color(0xFFD6FF23),
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'Overview'),
            Tab(text: 'Projects'),
            Tab(text: 'Performance'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(),
          _buildProjectsTab(),
          _buildPerformanceTab(),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Key Metrics Cards
          Row(
            children: [
              Expanded(
                child: _MetricCard(
                  title: 'Total Projects',
                  value: '24',
                  change: '+12%',
                  changeColor: Colors.green,
                  icon: Icons.folder_copy,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _MetricCard(
                  title: 'Completed',
                  value: '18',
                  change: '+8%',
                  changeColor: Colors.green,
                  icon: Icons.check_circle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _MetricCard(
                  title: 'In Progress',
                  value: '6',
                  change: '+2%',
                  changeColor: Colors.blue,
                  icon: Icons.timelapse,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _MetricCard(
                  title: 'Avg. Completion',
                  value: '14d',
                  change: '-3d',
                  changeColor: Colors.green,
                  icon: Icons.schedule,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Charts Section
          const Text(
            'Project Status Distribution',
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
            child: const Column(
              children: [
                _ChartItem(
                  label: 'Completed',
                  value: 75,
                  color: Colors.green,
                  percentage: '75%',
                ),
                SizedBox(height: 12),
                _ChartItem(
                  label: 'In Progress',
                  value: 20,
                  color: Colors.blue,
                  percentage: '20%',
                ),
                SizedBox(height: 12),
                _ChartItem(
                  label: 'Planning',
                  value: 5,
                  color: Colors.orange,
                  percentage: '5%',
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
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1A2029),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF2A2F38)),
            ),
            child: const Column(
              children: [
                _ActivityItem(
                  icon: Icons.check_circle,
                  iconColor: Colors.green,
                  title: 'Project "Mobile App UI" completed',
                  time: '2 hours ago',
                ),
                Divider(color: Color(0xFF2A2F38), height: 16),
                _ActivityItem(
                  icon: Icons.add,
                  iconColor: Colors.blue,
                  title: 'New project "Dashboard Design" created',
                  time: '1 day ago',
                ),
                Divider(color: Color(0xFF2A2F38), height: 16),
                _ActivityItem(
                  icon: Icons.group_add,
                  iconColor: Colors.purple,
                  title: '3 new team members added',
                  time: '2 days ago',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Project Performance',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // Project Performance List
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1A2029),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF2A2F38)),
            ),
            child: Column(
              children: [
                _ProjectPerformanceItem(
                  projectName: 'Mobile App UI',
                  progress: 0.95,
                  status: 'Almost Done',
                  dueDate: 'Dec 15',
                  teamSize: 3,
                ),
                const Divider(color: Color(0xFF2A2F38), height: 1),
                _ProjectPerformanceItem(
                  projectName: 'Dashboard Design',
                  progress: 0.7,
                  status: 'On Track',
                  dueDate: 'Dec 20',
                  teamSize: 2,
                ),
                const Divider(color: Color(0xFF2A2F38), height: 1),
                _ProjectPerformanceItem(
                  projectName: 'Brand Identity',
                  progress: 0.85,
                  status: 'Good Progress',
                  dueDate: 'Dec 10',
                  teamSize: 1,
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Time Tracking
          const Text(
            'Time Tracking',
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
                _TimeTrackingItem(
                  day: 'Today',
                  hours: 8.5,
                  projects: 2,
                ),
                const SizedBox(height: 16),
                _TimeTrackingItem(
                  day: 'Yesterday',
                  hours: 7.2,
                  projects: 3,
                ),
                const SizedBox(height: 16),
                _TimeTrackingItem(
                  day: 'This Week',
                  hours: 42.5,
                  projects: 8,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Performance Metrics
          Row(
            children: [
              Expanded(
                child: _PerformanceMetricCard(
                  title: 'Productivity Score',
                  value: '87%',
                  trend: '↑ 5%',
                  trendColor: Colors.green,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _PerformanceMetricCard(
                  title: 'Efficiency Rate',
                  value: '92%',
                  trend: '↑ 3%',
                  trendColor: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _PerformanceMetricCard(
                  title: 'On-time Delivery',
                  value: '94%',
                  trend: '↑ 2%',
                  trendColor: Colors.green,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _PerformanceMetricCard(
                  title: 'Client Satisfaction',
                  value: '4.8/5',
                  trend: '↑ 0.2',
                  trendColor: Colors.green,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Skills & Expertise
          const Text(
            'Skills & Expertise',
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
                _SkillItem(skill: 'UI/UX Design', level: 95, color: Colors.blue),
                const SizedBox(height: 16),
                _SkillItem(skill: 'Mobile Development', level: 88, color: Colors.green),
                const SizedBox(height: 16),
                _SkillItem(skill: 'Brand Design', level: 92, color: Colors.purple),
                const SizedBox(height: 16),
                _SkillItem(skill: 'Web Design', level: 85, color: Colors.orange),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Goals & Targets
          const Text(
            'Goals & Targets',
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
                _GoalItem(
                  goal: 'Complete 25 projects this month',
                  progress: 0.8,
                  target: '25/25',
                ),
                const SizedBox(height: 16),
                _GoalItem(
                  goal: 'Maintain 90% client satisfaction',
                  progress: 0.94,
                  target: '94%',
                ),
                const SizedBox(height: 16),
                _GoalItem(
                  goal: 'Achieve 85% productivity score',
                  progress: 0.87,
                  target: '87%',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String change;
  final Color changeColor;
  final IconData icon;

  const _MetricCard({
    required this.title,
    required this.value,
    required this.change,
    required this.changeColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2029),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF2A2F38)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFFD6FF23).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: const Color(0xFFD6FF23), size: 18),
              ),
              const Spacer(),
              Text(
                change,
                style: TextStyle(
                  color: changeColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _ChartItem extends StatelessWidget {
  final String label;
  final double value;
  final Color color;
  final String percentage;

  const _ChartItem({
    required this.label,
    required this.value,
    required this.color,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(color: Colors.white70),
          ),
        ),
        Text(
          percentage,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: LinearProgressIndicator(
            value: value / 100,
            backgroundColor: const Color(0xFF2A2F38),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }
}

class _ActivityItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String time;

  const _ActivityItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: iconColor, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.white),
              ),
              Text(
                time,
                style: const TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProjectPerformanceItem extends StatelessWidget {
  final String projectName;
  final double progress;
  final String status;
  final String dueDate;
  final int teamSize;

  const _ProjectPerformanceItem({
    required this.projectName,
    required this.progress,
    required this.status,
    required this.dueDate,
    required this.teamSize,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                projectName,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                status,
                style: TextStyle(
                  color: _getStatusColor(status),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: const Color(0xFF2A2F38),
            valueColor: AlwaysStoppedAnimation<Color>(_getStatusColor(status)),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.calendar_today, color: Colors.white54, size: 14),
              const SizedBox(width: 4),
              Text(
                'Due: $dueDate',
                style: const TextStyle(color: Colors.white54, fontSize: 12),
              ),
              const SizedBox(width: 16),
              Icon(Icons.group, color: Colors.white54, size: 14),
              const SizedBox(width: 4),
              Text(
                '$teamSize members',
                style: const TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'almost done':
        return Colors.green;
      case 'on track':
        return Colors.blue;
      case 'good progress':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}

class _TimeTrackingItem extends StatelessWidget {
  final String day;
  final double hours;
  final int projects;

  const _TimeTrackingItem({
    required this.day,
    required this.hours,
    required this.projects,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          day,
          style: const TextStyle(color: Colors.white70),
        ),
        Text(
          '${hours}h on $projects projects',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _PerformanceMetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String trend;
  final Color trendColor;

  const _PerformanceMetricCard({
    required this.title,
    required this.value,
    required this.trend,
    required this.trendColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
          const SizedBox(height: 8),
          Text(
            trend,
            style: TextStyle(
              color: trendColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _SkillItem extends StatelessWidget {
  final String skill;
  final int level;
  final Color color;

  const _SkillItem({
    required this.skill,
    required this.level,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              skill,
              style: const TextStyle(color: Colors.white70),
            ),
            Text(
              '$level%',
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: level / 100,
          backgroundColor: const Color(0xFF2A2F38),
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ],
    );
  }
}

class _GoalItem extends StatelessWidget {
  final String goal;
  final double progress;
  final String target;

  const _GoalItem({
    required this.goal,
    required this.progress,
    required this.target,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                goal,
                style: const TextStyle(color: Colors.white70),
              ),
            ),
            Text(
              target,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: const Color(0xFF2A2F38),
          valueColor: AlwaysStoppedAnimation<Color>(
            progress >= 0.9 ? Colors.green : Colors.blue,
          ),
        ),
      ],
    );
  }
}