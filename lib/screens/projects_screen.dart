import 'package:flutter/material.dart';
import 'package:inventor_desgin_studio/theme/constants.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  final List<Map<String, dynamic>> _projects = [
    {
      'name': 'Mobile App UI',
      'description': 'E-commerce application design',
      'status': 'In Progress',
      'progress': 0.75,
      'dueDate': '2024-02-15',
      'team': ['Alice', 'Bob'],
      'color': Colors.blue,
    },
    {
      'name': 'Dashboard Design',
      'description': 'Analytics dashboard for SaaS',
      'status': 'Completed',
      'progress': 1.0,
      'dueDate': '2024-01-30',
      'team': ['Charlie', 'Diana'],
      'color': Colors.green,
    },
    {
      'name': 'Brand Identity',
      'description': 'Logo and brand guidelines',
      'status': 'Review',
      'progress': 0.9,
      'dueDate': '2024-02-10',
      'team': ['Eve', 'Frank'],
      'color': Colors.orange,
    },
    {
      'name': 'Website Redesign',
      'description': 'Complete website overhaul',
      'status': 'Planning',
      'progress': 0.2,
      'dueDate': '2024-03-01',
      'team': ['Grace', 'Henry'],
      'color': Colors.purple,
    },
  ];

  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    final filteredProjects = _selectedFilter == 'All'
        ? _projects
        : _projects.where((project) => project['status'] == _selectedFilter).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF0E131A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Projects',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.white),
            onPressed: () => _showFilterDialog(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Chips
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: ['All', 'Planning', 'In Progress', 'Review', 'Completed']
                  .map((filter) => Container(
                        margin: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(filter),
                          selected: _selectedFilter == filter,
                          onSelected: (selected) {
                            setState(() => _selectedFilter = filter);
                          },
                          backgroundColor: const Color(0xFF1A2029),
                          selectedColor: kNeon.withValues(alpha: 0.2),
                          checkmarkColor: kNeon,
                          labelStyle: TextStyle(
                            color: _selectedFilter == filter ? kNeon : Colors.white70,
                            fontWeight: _selectedFilter == filter ? FontWeight.w600 : FontWeight.normal,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),

          // Projects List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredProjects.length,
              itemBuilder: (context, index) {
                final project = filteredProjects[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A2029),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFF2A2F38)),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: Text(
                      project['name'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          project['description'],
                          style: const TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            _StatusChip(status: project['status']),
                            const SizedBox(width: 8),
                            Text(
                              'Due: ${project['dueDate']}',
                              style: const TextStyle(color: Colors.white54, fontSize: 12),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: project['progress'],
                          backgroundColor: const Color(0xFF2A2F38),
                          valueColor: AlwaysStoppedAnimation<Color>(project['color']),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${(project['progress'] * 100).toInt()}% Complete',
                          style: const TextStyle(color: Colors.white54, fontSize: 12),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.people, color: Colors.white54, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              project['team'].join(', '),
                              style: const TextStyle(color: Colors.white54, fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.more_vert, color: Colors.white54),
                      onPressed: () => _showProjectOptions(context, project),
                    ),
                    onTap: () => _openProjectDetails(project),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createNewProject(),
        backgroundColor: kNeon,
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A2029),
        title: const Text('Filter Projects', style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ['All', 'Planning', 'In Progress', 'Review', 'Completed']
              .map((filter) => ListTile(
                    title: Text(filter, style: const TextStyle(color: Colors.white)),
                    onTap: () {
                      setState(() => _selectedFilter = filter);
                      Navigator.pop(context);
                    },
                  ))
              .toList(),
        ),
      ),
    );
  }

  void _showProjectOptions(BuildContext context, Map<String, dynamic> project) {
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
            ListTile(
              leading: const Icon(Icons.edit, color: Colors.white70),
              title: const Text('Edit Project', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                _editProject(project);
              },
            ),
            ListTile(
              leading: const Icon(Icons.share, color: Colors.white70),
              title: const Text('Share Project', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                _shareProject(project);
              },
            ),
            ListTile(
              leading: const Icon(Icons.archive, color: Colors.white70),
              title: const Text('Archive Project', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                _archiveProject(project);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Delete Project', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                _deleteProject(project);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _openProjectDetails(Map<String, dynamic> project) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening ${project['name']}'),
        backgroundColor: kNeon,
      ),
    );
  }

  void _createNewProject() {
    showDialog(
      context: context,
      builder: (context) => const _CreateProjectDialog(),
    );
  }

  void _editProject(Map<String, dynamic> project) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Editing ${project['name']}'),
        backgroundColor: kNeon,
      ),
    );
  }

  void _shareProject(Map<String, dynamic> project) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sharing ${project['name']}'),
        backgroundColor: kNeon,
      ),
    );
  }

  void _archiveProject(Map<String, dynamic> project) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Archiving ${project['name']}'),
        backgroundColor: kNeon,
      ),
    );
  }

  void _deleteProject(Map<String, dynamic> project) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Deleting ${project['name']}'),
        backgroundColor: kNeon,
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String status;

  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (status) {
      case 'Completed':
        color = Colors.green;
        break;
      case 'In Progress':
        color = Colors.blue;
        break;
      case 'Review':
        color = Colors.orange;
        break;
      case 'Planning':
        color = Colors.purple;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _CreateProjectDialog extends StatefulWidget {
  const _CreateProjectDialog();

  @override
  State<_CreateProjectDialog> createState() => _CreateProjectDialogState();
}

class _CreateProjectDialogState extends State<_CreateProjectDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedStatus = 'Planning';

  final List<String> _statuses = ['Planning', 'In Progress', 'Review', 'Completed'];

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF1A2029),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(20),
        constraints: const BoxConstraints(maxWidth: 400),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Create New Project',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Project Name
              TextFormField(
                controller: _nameController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Project Name',
                  labelStyle: const TextStyle(color: Colors.white70),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF2A2F38)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFD6FF23)),
                  ),
                  filled: true,
                  fillColor: const Color(0xFF0E131A),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a project name';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Description
              TextFormField(
                controller: _descriptionController,
                style: const TextStyle(color: Colors.white),
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: const TextStyle(color: Colors.white70),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF2A2F38)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFD6FF23)),
                  ),
                  filled: true,
                  fillColor: const Color(0xFF0E131A),
                ),
              ),

              const SizedBox(height: 16),

              // Status Dropdown
              DropdownButtonFormField<String>(
                value: _selectedStatus,
                style: const TextStyle(color: Colors.white),
                dropdownColor: const Color(0xFF1A2029),
                decoration: InputDecoration(
                  labelText: 'Status',
                  labelStyle: const TextStyle(color: Colors.white70),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF2A2F38)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFD6FF23)),
                  ),
                  filled: true,
                  fillColor: const Color(0xFF0E131A),
                ),
                items: _statuses.map((status) {
                  return DropdownMenuItem(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => _selectedStatus = value!);
                },
              ),

              const SizedBox(height: 20),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _createProject,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kNeon,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Create',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _createProject() {
    if (!_formKey.currentState!.validate()) return;

    // In a real implementation, you'd update the parent widget's state
    // For now, we'll just show a success message
    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Project "${_nameController.text}" created successfully!'),
        backgroundColor: kNeon,
      ),
    );
  }
}