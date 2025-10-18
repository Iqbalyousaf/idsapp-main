import 'package:flutter/material.dart';
import 'package:inventor_desgin_studio/screens/sketch_tool_screen.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController budgetController;
  String selectedCategory = 'UI/UX Design';
  String selectedPriority = 'Medium';
  DateTime? selectedDeadline;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    budgetController = TextEditingController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    titleController.dispose();
    descriptionController.dispose();
    budgetController.dispose();
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
          'Create New',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        bottom: TabBar(

          controller: _tabController,
          tabAlignment: TabAlignment.start,
          isScrollable: true,
          indicatorColor: const Color(0xFFD6FF23),
          labelColor: const Color(0xFFD6FF23),
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'Project'),
            Tab(text: 'Design'),
            Tab(text: 'Team'),
            Tab(text: 'Template'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildProjectCreator(),
          _buildDesignCreator(),
          _buildTeamCreator(),
          _buildTemplateSelector(),
        ],
      ),
    );
  }

  Widget _buildProjectCreator() {

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Create New Project',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Start a new project and bring your ideas to life',
            style: TextStyle(color: Colors.white70),
          ),

          const SizedBox(height: 32),

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
                // Project Title
                const Text(
                  'Project Title',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: titleController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Enter project title',
                    hintStyle: const TextStyle(color: Colors.white54),
                    filled: true,
                    fillColor: const Color(0xFF0E131A),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),

                const SizedBox(height: 20),

                // Description
                const Text(
                  'Description',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: descriptionController,
                  maxLines: 4,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Describe your project...',
                    hintStyle: const TextStyle(color: Colors.white54),
                    filled: true,
                    fillColor: const Color(0xFF0E131A),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),

                const SizedBox(height: 20),

                // Category and Priority
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Category',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF0E131A),
                              borderRadius: const BorderRadius.all(Radius.circular(12)),
                              border: Border.all(color: const Color(0xFF2A2F38)),
                            ),
                            child: DropdownButton<String>(
                              value: selectedCategory,
                              isExpanded: true,
                              dropdownColor: const Color(0xFF1A2029),
                              style: const TextStyle(color: Colors.white),
                              underline: const SizedBox(),
                              items: [
                                'UI/UX Design',
                                'Mobile Development',
                                'Web Development',
                                'Brand Design',
                                'Marketing',
                                'Other',
                              ].map((category) {
                                return DropdownMenuItem(
                                  value: category,
                                  child: Text(category),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) setState(() => selectedCategory = value);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Priority',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF0E131A),
                              borderRadius: const BorderRadius.all(Radius.circular(12)),
                              border: Border.all(color: const Color(0xFF2A2F38)),
                            ),
                            child: DropdownButton<String>(
                              value: selectedPriority,
                              isExpanded: true,
                              dropdownColor: const Color(0xFF1A2029),
                              style: const TextStyle(color: Colors.white),
                              underline: const SizedBox(),
                              items: ['Low', 'Medium', 'High', 'Urgent'].map((priority) {
                                return DropdownMenuItem(
                                  value: priority,
                                  child: Text(priority),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) setState(() => selectedPriority = value);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Budget and Deadline
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Budget (Optional)',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: budgetController,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: '\$0.00',
                              hintStyle: const TextStyle(color: Colors.white54),
                              filled: true,
                              fillColor: const Color(0xFF0E131A),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Deadline',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          InkWell(
                            onTap: () async {
                              final date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now().add(const Duration(days: 30)),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now().add(const Duration(days: 365)),
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: const ColorScheme.dark(
                                        primary: Color(0xFFD6FF23),
                                        surface: Color(0xFF1A2029),
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );
                              if (date != null) {
                                setState(() => selectedDeadline = date);
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                              decoration: BoxDecoration(
                                color: const Color(0xFF0E131A),
                                borderRadius: const BorderRadius.all(Radius.circular(12)),
                                border: Border.all(color: const Color(0xFF2A2F38)),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      selectedDeadline != null
                                          ? '${selectedDeadline!.day}/${selectedDeadline!.month}/${selectedDeadline!.year}'
                                          : 'Select date',
                                      style: TextStyle(
                                        color: selectedDeadline != null ? Colors.white : Colors.white54,
                                      ),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.calendar_today,
                                    color: Colors.white54,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Create Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Create project logic
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
                      shape: RoundedRectangleBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    child: const Text(
                      'Create Project',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesignCreator() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Create New Design',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Start designing with our powerful tools',
            style: TextStyle(color: Colors.white70),
          ),

          const SizedBox(height: 32),

          // Design Tools Grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: [
              _DesignToolCard(
                icon: Icons.edit,
                title: 'Sketch',
                description: 'Free-form drawing',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SketchToolScreen()),
                  );
                },
              ),
              _DesignToolCard(
                icon: Icons.rectangle_outlined,
                title: 'Shapes',
                description: 'Geometric shapes',
                onTap: () {
                  // Navigate to shapes tool
                },
              ),
              _DesignToolCard(
                icon: Icons.text_fields,
                title: 'Text',
                description: 'Typography tools',
                onTap: () {
                  // Navigate to text tool
                },
              ),
              _DesignToolCard(
                icon: Icons.color_lens,
                title: 'Colors',
                description: 'Color palette',
                onTap: () {
                  // Navigate to color tool
                },
              ),
              _DesignToolCard(
                icon: Icons.image,
                title: 'Images',
                description: 'Import & edit',
                onTap: () {
                  // Navigate to image tool
                },
              ),
              _DesignToolCard(
                icon: Icons.layers,
                title: 'Layers',
                description: 'Layer management',
                onTap: () {
                  // Navigate to layers tool
                },
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Recent Designs
          const Text(
            'Recent Designs',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: const Color(0xFF1A2029),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF2A2F38)),
            ),
            child: const Center(
              child: Text(
                'No recent designs',
                style: TextStyle(color: Colors.white54),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamCreator() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Create New Team',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Build your dream team for projects',
            style: TextStyle(color: Colors.white70),
          ),

          const SizedBox(height: 32),

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
                  'Team Name',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Enter team name',
                    hintStyle: TextStyle(color: Colors.white54),
                    filled: true,
                    fillColor: Color(0xFF0E131A),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Team Description',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  maxLines: 3,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Describe your team...',
                    hintStyle: TextStyle(color: Colors.white54),
                    filled: true,
                    fillColor: Color(0xFF0E131A),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),

                const SizedBox(height: 32),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Create team logic
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Team created successfully!'),
                          backgroundColor: Color(0xFFD6FF23),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD6FF23),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    child: const Text(
                      'Create Team',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTemplateSelector() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Choose Template',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Start with a pre-designed template',
            style: TextStyle(color: Colors.white70),
          ),

          const SizedBox(height: 32),

          // Template Categories
          const Text(
            'Categories',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _TemplateCategoryChip(label: 'All', isSelected: true),
                _TemplateCategoryChip(label: 'Mobile UI'),
                _TemplateCategoryChip(label: 'Web Design'),
                _TemplateCategoryChip(label: 'Brand'),
                _TemplateCategoryChip(label: 'Marketing'),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Template Grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: [
              _TemplateCard(
                title: 'E-commerce App',
                category: 'Mobile UI',
                previewColor: Colors.blue,
                onTap: () {
                  // Use template
                },
              ),
              _TemplateCard(
                title: 'Dashboard',
                category: 'Web Design',
                previewColor: Colors.green,
                onTap: () {
                  // Use template
                },
              ),
              _TemplateCard(
                title: 'Logo Design',
                category: 'Brand',
                previewColor: Colors.purple,
                onTap: () {
                  // Use template
                },
              ),
              _TemplateCard(
                title: 'Social Media Kit',
                category: 'Marketing',
                previewColor: Colors.orange,
                onTap: () {
                  // Use template
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DesignToolCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  const _DesignToolCard({
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
            const SizedBox(height: 3),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
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

class _TemplateCategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;

  const _TemplateCategoryChip({
    required this.label,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFD6FF23) : const Color(0xFF1A2029),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? const Color(0xFFD6FF23) : const Color(0xFF2A2F38),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.black : Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _TemplateCard extends StatelessWidget {
  final String title;
  final String category;
  final Color previewColor;
  final VoidCallback onTap;

  const _TemplateCard({
    required this.title,
    required this.category,
    required this.previewColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF1A2029),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF2A2F38)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: previewColor.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Icon(
                  Icons.image,
                  color: previewColor,
                  size: 24,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              category,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 11,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}