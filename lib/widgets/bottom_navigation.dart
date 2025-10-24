import 'package:flutter/material.dart';
import 'package:inventor_desgin_studio/screens/home.dart';
import 'package:inventor_desgin_studio/screens/browse_files_screen.dart';
import 'package:inventor_desgin_studio/screens/message_screen.dart';
import 'package:inventor_desgin_studio/screens/profile_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeDashboard(key: Key('home_dashboard')),
    const BrowseFilesScreen(key: Key('browse_files_screen')),
    const MessageScreen(key: Key('message_screen')),
    const ProfileScreen(key: Key('profile_screen')),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  void _showProjectRequestDialog() {
    showDialog(
      context: context,
      builder: (context) => const _ProjectRequestDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 14),
        decoration: const BoxDecoration(
          color: Color(0xFF1A2029),
          border: Border(top: BorderSide(color: Color(0xFF2A2F38))),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _NavItem(
              icon: Icons.home_filled,
              label: 'Home',
              isSelected: _selectedIndex == 0,
              onTap: () => _onItemTapped(0),
            ),
            _NavItem(
              icon: Icons.folder_open,
              label: 'Files',
              isSelected: _selectedIndex == 1,
              onTap: () => _onItemTapped(1),
            ),
            _NavItem(
              icon: Icons.message_outlined,
              label: 'Messages',
              isSelected: _selectedIndex == 2,
              onTap: () => _onItemTapped(2),
            ),
            _NavItem(
              icon: Icons.person_outline,
              label: 'Profile',
              isSelected: _selectedIndex == 3,
              onTap: () => _onItemTapped(3),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showProjectRequestDialog,
        backgroundColor: const Color(0xFFD6FF23),
        foregroundColor: Colors.black,
        elevation: 8,
        heroTag: 'project_request_fab',
        child: const Icon(Icons.add, size: 28),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0xFFD6FF23) : Colors.white70,
              size: 24,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? const Color(0xFFD6FF23) : Colors.white70,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectRequestDialog extends StatefulWidget {
  const _ProjectRequestDialog();

  @override
  State<_ProjectRequestDialog> createState() => _ProjectRequestDialogState();
}

class _ProjectRequestDialogState extends State<_ProjectRequestDialog> {
  final _formKey = GlobalKey<FormState>();
  final _projectNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _budgetController = TextEditingController();
  final _deadlineController = TextEditingController();
  String _selectedCategory = 'Mobile App';
  String _selectedPriority = 'Medium';

  final List<String> _categories = [
    'Mobile App',
    'Website',
    'Logo Design',
    'Brand Identity',
    'UI/UX Design',
    'Other'
  ];

  final List<String> _priorities = ['Low', 'Medium', 'High', 'Urgent'];

  @override
  void dispose() {
    _projectNameController.dispose();
    _descriptionController.dispose();
    _budgetController.dispose();
    _deadlineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF1A2029),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400, maxHeight: 600),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Request New Project',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                // Project Name
                TextFormField(
                  controller: _projectNameController,
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

                // Category Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  style: const TextStyle(color: Colors.white),
                  dropdownColor: const Color(0xFF1A2029),
                  decoration: InputDecoration(
                    labelText: 'Category',
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
                  items: _categories.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() => _selectedCategory = value!);
                  },
                ),

                const SizedBox(height: 16),

                // Description
                TextFormField(
                  controller: _descriptionController,
                  style: const TextStyle(color: Colors.white),
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Project Description',
                    labelStyle: const TextStyle(color: Colors.white70),
                    hintText: 'Describe your project requirements...',
                    hintStyle: const TextStyle(color: Colors.white38),
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
                      return 'Please describe your project';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Budget and Deadline Row
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _budgetController,
                        style: const TextStyle(color: Colors.white),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Budget (\$)',
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
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _deadlineController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Deadline',
                          labelStyle: const TextStyle(color: Colors.white70),
                          hintText: 'e.g., 2 weeks',
                          hintStyle: const TextStyle(color: Colors.white38),
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
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Priority Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedPriority,
                  style: const TextStyle(color: Colors.white),
                  dropdownColor: const Color(0xFF1A2029),
                  decoration: InputDecoration(
                    labelText: 'Priority',
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
                  items: _priorities.map((priority) {
                    return DropdownMenuItem(
                      value: priority,
                      child: Text(priority),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() => _selectedPriority = value!);
                  },
                ),

                const SizedBox(height: 24),

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
                        onPressed: _submitProjectRequest,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD6FF23),
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Send Request',
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
      ),
    );
  }

  void _submitProjectRequest() {
    if (!_formKey.currentState!.validate()) return;

    // Here you would typically send the request to your backend
    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Project request sent successfully! We\'ll get back to you soon.'),
        backgroundColor: Color(0xFFD6FF23),
      ),
    );
  }
}
