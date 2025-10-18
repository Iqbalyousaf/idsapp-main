import 'package:flutter/material.dart';
import 'package:inventor_desgin_studio/screens/project_details_screen.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  String _selectedSort = 'Newest';
  String _selectedFilter = 'All Categories';
  bool _showCompleted = true;
  bool _showArchived = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
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
          'Projects',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.white70),
            onPressed: () {
              _showFilterOptions();
            },
          ),
          IconButton(
            icon: const Icon(Icons.sort, color: Colors.white70),
            onPressed: () {
              _showSortOptions();
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          indicatorColor: const Color(0xFFD6FF23),
          labelColor: const Color(0xFFD6FF23),
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Active'),
            Tab(text: 'Completed'),
            Tab(text: 'Archived'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search projects...',
                hintStyle: const TextStyle(color: Colors.white54),
                prefixIcon: const Icon(Icons.search, color: Colors.white54),
                filled: true,
                fillColor: const Color(0xFF1A2029),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
              onChanged: (value) {
                // Implement search functionality
              },
            ),
          ),

          // Projects Grid/List
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildProjectsList('all'),
                _buildProjectsList('active'),
                _buildProjectsList('completed'),
                _buildProjectsList('archived'),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreateProjectDialog();
        },
        backgroundColor: const Color(0xFFD6FF23),
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }

  Widget _buildProjectsList(String filter) {
    // Mock project data - replace with real data from provider
    final projects = [
      _ProjectItem(
        title: 'Mobile App UI',
        subtitle: 'E-commerce application design',
        status: 'In Progress',
        statusColor: const Color(0xFF63E6FF),
        progress: 0.75,
        dueDate: 'Dec 15, 2024',
        teamCount: 3,
      ),
      _ProjectItem(
        title: 'Dashboard Design',
        subtitle: 'Analytics dashboard for SaaS',
        status: 'Completed',
        statusColor: const Color(0xFF4ADE80),
        progress: 1.0,
        dueDate: 'Nov 30, 2024',
        teamCount: 2,
      ),
      _ProjectItem(
        title: 'Brand Identity',
        subtitle: 'Logo and brand guidelines',
        status: 'Review',
        statusColor: const Color(0xFFFFC857),
        progress: 0.9,
        dueDate: 'Dec 10, 2024',
        teamCount: 1,
      ),
      _ProjectItem(
        title: 'Website Redesign',
        subtitle: 'Corporate website overhaul',
        status: 'Planning',
        statusColor: const Color(0xFF8B5CF6),
        progress: 0.2,
        dueDate: 'Jan 15, 2025',
        teamCount: 4,
      ),
    ];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: projects.length,
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: false,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _ProjectCard(project: projects[index]),
        );
      },
    );
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A2029),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: SizedBox(
            height: (MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom) * 0.8,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                  'Filter Projects',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                // Category Filter
                const Text(
                  'Category',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _FilterChip(
                      label: 'All Categories',
                      isSelected: _selectedFilter == 'All Categories',
                      onTap: () {
                        setState(() => _selectedFilter = 'All Categories');
                      },
                    ),
                    _FilterChip(
                      label: 'UI/UX Design',
                      isSelected: _selectedFilter == 'UI/UX Design',
                      onTap: () {
                        setState(() => _selectedFilter = 'UI/UX Design');
                      },
                    ),
                    _FilterChip(
                      label: 'Mobile Development',
                      isSelected: _selectedFilter == 'Mobile Development',
                      onTap: () {
                        setState(() => _selectedFilter = 'Mobile Development');
                      },
                    ),
                    _FilterChip(
                      label: 'Web Development',
                      isSelected: _selectedFilter == 'Web Development',
                      onTap: () {
                        setState(() => _selectedFilter = 'Web Development');
                      },
                    ),
                    _FilterChip(
                      label: 'Brand Design',
                      isSelected: _selectedFilter == 'Brand Design',
                      onTap: () {
                        setState(() => _selectedFilter = 'Brand Design');
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Status Filters
                const Text(
                  'Status',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),

                SwitchListTile(
                  title: const Text(
                    'Show Completed Projects',
                    style: TextStyle(color: Colors.white),
                  ),
                  value: _showCompleted,
                  onChanged: (value) {
                    setState(() => _showCompleted = value);
                  },
                  activeColor: const Color(0xFFD6FF23),
                  activeTrackColor: const Color(0xFFD6FF23).withValues(alpha: 0.3),
                ),

                SwitchListTile(
                  title: const Text(
                    'Show Archived Projects',
                    style: TextStyle(color: Colors.white),
                  ),
                  value: _showArchived,
                  onChanged: (value) {
                    setState(() => _showArchived = value);
                  },
                  activeColor: const Color(0xFFD6FF23),
                  activeTrackColor: const Color(0xFFD6FF23).withValues(alpha: 0.3),
                ),

                const SizedBox(height: 24),

                // Apply Button
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(

                          content: Text('Filters applied'),
                          backgroundColor: Color(0xFFD6FF23),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD6FF23),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      'Apply Filters',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A2029),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              const Text(
                'Sort Projects',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Sort Options
              _SortOption(
                title: 'Newest First',
                subtitle: 'Most recently created',
                isSelected: _selectedSort == 'Newest',
                onTap: () {
                  setState(() => _selectedSort = 'Newest');
                },
              ),
              const Divider(color: Color(0xFF2A2F38), height: 1),
              _SortOption(
                title: 'Oldest First',
                subtitle: 'Oldest projects first',
                isSelected: _selectedSort == 'Oldest',
                onTap: () {
                  setState(() => _selectedSort = 'Oldest');
                },
              ),
              const Divider(color: Color(0xFF2A2F38), height: 1),
              _SortOption(
                title: 'Name (A-Z)',
                subtitle: 'Alphabetical order',
                isSelected: _selectedSort == 'Name A-Z',
                onTap: () {
                  setState(() => _selectedSort = 'Name A-Z');
                },
              ),
              const Divider(color: Color(0xFF2A2F38), height: 1),
              _SortOption(
                title: 'Name (Z-A)',
                subtitle: 'Reverse alphabetical',
                isSelected: _selectedSort == 'Name Z-A',
                onTap: () {
                  setState(() => _selectedSort = 'Name Z-A');
                },
              ),
              const Divider(color: Color(0xFF2A2F38), height: 1),
              _SortOption(
                title: 'Due Date',
                subtitle: 'Closest deadline first',
                isSelected: _selectedSort == 'Due Date',
                onTap: () {
                  setState(() => _selectedSort = 'Due Date');
                },
              ),
              const Divider(color: Color(0xFF2A2F38), height: 1),
              _SortOption(
                title: 'Progress',
                subtitle: 'Highest progress first',
                isSelected: _selectedSort == 'Progress',
                onTap: () {
                  setState(() => _selectedSort = 'Progress');
                },
              ),

              const SizedBox(height: 24),

              // Apply Button
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Sorted by $_selectedSort'),
                        backgroundColor: const Color(0xFFD6FF23),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD6FF23),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    'Apply Sort',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showCreateProjectDialog() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A2029),
        title: const Text(
          'Create New Project',
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Project Title',
                labelStyle: TextStyle(color: Colors.white70),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFD6FF23)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              style: const TextStyle(color: Colors.white),
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(color: Colors.white70),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFD6FF23)),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.white70)),
          ),
          ElevatedButton(
            onPressed: () {
              // Create project logic here
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Project created successfully!'),
                  backgroundColor: Color(0xFFD6FF23),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD6FF23),
              foregroundColor: Colors.black,
            ),
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFD6FF23) : const Color(0xFF2A2F38),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFFD6FF23) : const Color(0xFF2A2F38),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
} 

class _SortOption extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const _SortOption({
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: Colors.white70, fontSize: 12),
      ),
      trailing: isSelected
          ? const Icon(
              Icons.check,
              color: Color(0xFFD6FF23),
            )
          : null,
      onTap: onTap,
    );
  }
}

class _ProjectItem {
  final String title;
  final String subtitle;
  final String status;
  final Color statusColor;
  final double progress;
  final String dueDate;
  final int teamCount;

  _ProjectItem({
    required this.title,
    required this.subtitle,
    required this.status,
    required this.statusColor,
    required this.progress,
    required this.dueDate,
    required this.teamCount,
  });
}

class _ProjectCard extends StatelessWidget {
  final _ProjectItem project;

  const _ProjectCard({required this.project});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A2029),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF2A2F38)),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProjectDetailsScreen(
                projectTitle: project.title,
                projectSubtitle: project.subtitle,
                status: project.status,
                statusColor: project.statusColor,
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      project.title,
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
                      color: project.statusColor.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: project.statusColor.withValues(alpha: 0.5)),
                    ),
                    child: Text(
                      project.status,
                      style: TextStyle(
                        color: project.statusColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                project.subtitle,
                style: const TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 16),
              // Progress Bar
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Progress',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                      Text(
                        '${(project.progress * 100).toInt()}%',
                        style: const TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: project.progress,
                    backgroundColor: const Color(0xFF2A2F38),
                    valueColor: AlwaysStoppedAnimation<Color>(project.statusColor),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.calendar_today, color: Colors.white54, size: 16),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          'Due: ${project.dueDate}',
                          style: const TextStyle(color: Colors.white54, fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.group, color: Colors.white54, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '${project.teamCount} members',
                        style: const TextStyle(color: Colors.white54, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}