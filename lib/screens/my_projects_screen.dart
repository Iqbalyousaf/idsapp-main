import 'package:flutter/material.dart';

class MyProjectsScreen extends StatefulWidget {
  const MyProjectsScreen({super.key});

  @override
  State<MyProjectsScreen> createState() => _MyProjectsScreenState();
}

class _MyProjectsScreenState extends State<MyProjectsScreen>
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
          'My Projects',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFFD6FF23),
          labelColor: const Color(0xFFD6FF23),
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Active'),
            Tab(text: 'Completed'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildProjectsList('all'),
          _buildProjectsList('active'),
          _buildProjectsList('completed'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to create project screen
        },
        backgroundColor: const Color(0xFFD6FF23),
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }

  Widget _buildProjectsList(String filter) {
    // Mock data - replace with actual data
    final projects = [
      {
        'title': 'E-commerce Mobile App',
        'description': 'Complete mobile application for online shopping',
        'status': 'Active',
        'progress': 75,
        'deadline': 'Dec 15, 2024',
        'category': 'Mobile Development',
      },
      {
        'title': 'Brand Identity Design',
        'description': 'Logo and brand guidelines for tech startup',
        'status': 'Completed',
        'progress': 100,
        'deadline': 'Nov 30, 2024',
        'category': 'Brand Design',
      },
      {
        'title': 'Dashboard UI/UX',
        'description': 'Admin dashboard for analytics platform',
        'status': 'Active',
        'progress': 45,
        'deadline': 'Jan 10, 2025',
        'category': 'UI/UX Design',
      },
      {
        'title': 'Social Media Kit',
        'description': 'Complete social media templates and assets',
        'status': 'Active',
        'progress': 90,
        'deadline': 'Dec 5, 2024',
        'category': 'Marketing',
      },
    ];

    final filteredProjects = filter == 'all'
        ? projects
        : projects.where((p) => (p['status'] as String).toLowerCase() == filter).toList();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredProjects.length,
      itemBuilder: (context, index) {
        final project = filteredProjects[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      project['title'] as String,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: project['status'] == 'Completed'
                          ? Colors.green.withValues(alpha: 0.2)
                          : const Color(0xFFD6FF23).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      project['status'] as String,
                      style: TextStyle(
                        color: project['status'] == 'Completed'
                            ? Colors.green
                            : const Color(0xFFD6FF23),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                project['description'] as String,
                style: const TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.category, color: Colors.white54, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    project['category'] as String,
                    style: const TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                  const SizedBox(width: 16),
                  const Icon(Icons.calendar_today, color: Colors.white54, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    project['deadline'] as String,
                    style: const TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (project['status'] != 'Completed') ...[
                Row(
                  children: [
                    Expanded(
                      child: LinearProgressIndicator(
                        value: (project['progress'] as int) / 100,
                        backgroundColor: const Color(0xFF2A2F38),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFFD6FF23),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '${project['progress']}%',
                      style: const TextStyle(
                        color: Color(0xFFD6FF23),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      // Navigate to project details
                    },
                    icon: const Icon(Icons.visibility, size: 16),
                    label: const Text('View'),
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFFD6FF23),
                    ),
                  ),
                  const SizedBox(width: 8),
                  TextButton.icon(
                    onPressed: () {
                      // Edit project
                    },
                    icon: const Icon(Icons.edit, size: 16),
                    label: const Text('Edit'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white70,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}