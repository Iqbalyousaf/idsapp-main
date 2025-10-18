import 'package:flutter/material.dart';

class ProfileAnalyticsScreen extends StatefulWidget {
  const ProfileAnalyticsScreen({super.key});

  @override
  State<ProfileAnalyticsScreen> createState() => _ProfileAnalyticsScreenState();
}

class _ProfileAnalyticsScreenState extends State<ProfileAnalyticsScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Analytics',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
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
                  icon: Icons.folder_copy,
                  color: const Color(0xFFD6FF23),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _MetricCard(
                  title: 'Completed',
                  value: '18',
                  icon: Icons.check_circle,
                  color: Colors.green,
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
                  value: '4',
                  icon: Icons.work,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _MetricCard(
                  title: 'Avg. Rating',
                  value: '4.8',
                  icon: Icons.star,
                  color: Colors.amber,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Monthly Progress Chart
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
                  'Monthly Progress',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      final months = ['Aug', 'Sep', 'Oct', 'Nov', 'Dec', 'Jan'];
                      final values = [3, 5, 4, 7, 6, 8];
                      return Container(
                        width: 50,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 30,
                              height: (values[index] / 10) * 150,
                              decoration: BoxDecoration(
                                color: const Color(0xFFD6FF23),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              months[index],
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
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
          _ActivityItem(
            icon: Icons.check_circle,
            title: 'Completed "E-commerce App" project',
            subtitle: '2 hours ago',
            color: Colors.green,
          ),
          _ActivityItem(
            icon: Icons.edit,
            title: 'Updated project requirements',
            subtitle: '5 hours ago',
            color: const Color(0xFFD6FF23),
          ),
          _ActivityItem(
            icon: Icons.star,
            title: 'Received 5-star rating',
            subtitle: '1 day ago',
            color: Colors.amber,
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
            'Project Statistics',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // Project Categories
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF1A2029),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF2A2F38)),
            ),
            child: Column(
              children: [
                _CategoryStat(
                  category: 'UI/UX Design',
                  count: 12,
                  percentage: 50,
                  color: const Color(0xFFD6FF23),
                ),
                const SizedBox(height: 16),
                _CategoryStat(
                  category: 'Mobile Development',
                  count: 6,
                  percentage: 25,
                  color: Colors.blue,
                ),
                const SizedBox(height: 16),
                _CategoryStat(
                  category: 'Brand Design',
                  count: 4,
                  percentage: 17,
                  color: Colors.purple,
                ),
                const SizedBox(height: 16),
                _CategoryStat(
                  category: 'Marketing',
                  count: 2,
                  percentage: 8,
                  color: Colors.orange,
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Project Timeline
          const Text(
            'Project Timeline',
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
                _TimelineItem(
                  title: 'E-commerce App',
                  status: 'In Progress',
                  date: 'Due Dec 15',
                  progress: 75,
                ),
                const SizedBox(height: 16),
                _TimelineItem(
                  title: 'Brand Identity',
                  status: 'Completed',
                  date: 'Nov 30',
                  progress: 100,
                ),
                const SizedBox(height: 16),
                _TimelineItem(
                  title: 'Dashboard UI',
                  status: 'In Progress',
                  date: 'Due Jan 10',
                  progress: 45,
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
                child: _PerformanceCard(
                  title: 'Client Satisfaction',
                  value: '4.8/5',
                  icon: Icons.thumb_up,
                  trend: '+0.2',
                  trendUp: true,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _PerformanceCard(
                  title: 'On-time Delivery',
                  value: '92%',
                  icon: Icons.schedule,
                  trend: '+5%',
                  trendUp: true,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: _PerformanceCard(
                  title: 'Response Time',
                  value: '2.3h',
                  icon: Icons.access_time,
                  trend: '-0.5h',
                  trendUp: true,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _PerformanceCard(
                  title: 'Projects/Month',
                  value: '3.2',
                  icon: Icons.trending_up,
                  trend: '+0.8',
                  trendUp: true,
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
                _SkillItem(skill: 'UI/UX Design', level: 95),
                const SizedBox(height: 16),
                _SkillItem(skill: 'Mobile Development', level: 88),
                const SizedBox(height: 16),
                _SkillItem(skill: 'Brand Design', level: 82),
                const SizedBox(height: 16),
                _SkillItem(skill: 'Marketing Design', level: 75),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Achievements
          const Text(
            'Achievements',
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
                _AchievementItem(
                  icon: Icons.emoji_events,
                  title: 'Top Performer',
                  description: 'Highest rated designer this month',
                  date: 'December 2024',
                ),
                const SizedBox(height: 16),
                _AchievementItem(
                  icon: Icons.workspace_premium,
                  title: 'Expert Level',
                  description: 'Completed 50+ projects successfully',
                  date: 'November 2024',
                ),
                const SizedBox(height: 16),
                _AchievementItem(
                  icon: Icons.local_fire_department,
                  title: 'Streak Master',
                  description: '30-day delivery streak',
                  date: 'October 2024',
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
  final IconData icon;
  final Color color;

  const _MetricCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
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
          const SizedBox(height: 8),
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
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _ActivityItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  const _ActivityItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2029),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF2A2F38)),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryStat extends StatelessWidget {
  final String category;
  final int count;
  final int percentage;
  final Color color;

  const _CategoryStat({
    required this.category,
    required this.count,
    required this.percentage,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            category,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        Text(
          '$count ($percentage%)',
          style: const TextStyle(color: Colors.white70),
        ),
      ],
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final String title;
  final String status;
  final String date;
  final int progress;

  const _TimelineItem({
    required this.title,
    required this.status,
    required this.date,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    status,
                    style: TextStyle(
                      color: status == 'Completed' ? Colors.green : Colors.orange,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    date,
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: progress / 100,
                backgroundColor: const Color(0xFF2A2F38),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFFD6FF23),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PerformanceCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final String trend;
  final bool trendUp;

  const _PerformanceCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.trend,
    required this.trendUp,
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFFD6FF23).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(icon, color: const Color(0xFFD6FF23), size: 16),
              ),
              Text(
                trend,
                style: TextStyle(
                  color: trendUp ? Colors.green : Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
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
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _SkillItem extends StatelessWidget {
  final String skill;
  final int level;

  const _SkillItem({
    required this.skill,
    required this.level,
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
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              '$level%',
              style: const TextStyle(
                color: Color(0xFFD6FF23),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: level / 100,
          backgroundColor: const Color(0xFF2A2F38),
          valueColor: const AlwaysStoppedAnimation<Color>(
            Color(0xFFD6FF23),
          ),
        ),
      ],
    );
  }
}

class _AchievementItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String date;

  const _AchievementItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
              Text(
                date,
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}