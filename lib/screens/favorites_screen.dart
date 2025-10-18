import 'package:flutter/material.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen>
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
          'Favorites',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFFD6FF23),
          labelColor: const Color(0xFFD6FF23),
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'Projects'),
            Tab(text: 'Templates'),
            Tab(text: 'Colors'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildProjectsTab(),
          _buildTemplatesTab(),
          _buildColorsTab(),
        ],
      ),
    );
  }

  Widget _buildProjectsTab() {
    // Mock favorite projects
    final favoriteProjects = [
      {
        'title': 'E-commerce Mobile App',
        'category': 'Mobile Development',
        'rating': 4.9,
        'image': 'assets/project1.jpg',
      },
      {
        'title': 'Brand Identity Design',
        'category': 'Brand Design',
        'rating': 5.0,
        'image': 'assets/project2.jpg',
      },
      {
        'title': 'Dashboard UI/UX',
        'category': 'UI/UX Design',
        'rating': 4.7,
        'image': 'assets/project3.jpg',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: favoriteProjects.length,
      itemBuilder: (context, index) {
        final project = favoriteProjects[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF1A2029),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF2A2F38)),
          ),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFFD6FF23).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.folder_copy,
                  color: Color(0xFFD6FF23),
                  size: 30,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project['title'] as String,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      project['category'] as String,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${project['rating']}',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                onPressed: () {
                  // Remove from favorites
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Removed from favorites'),
                      backgroundColor: Colors.red,
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTemplatesTab() {
    // Mock favorite templates
    final favoriteTemplates = [
      {
        'title': 'E-commerce App Template',
        'category': 'Mobile UI',
        'downloads': '2.3k',
      },
      {
        'title': 'Admin Dashboard',
        'category': 'Web Design',
        'downloads': '1.8k',
      },
      {
        'title': 'Social Media Kit',
        'category': 'Marketing',
        'downloads': '956',
      },
      {
        'title': 'Logo Design Set',
        'category': 'Brand',
        'downloads': '1.2k',
      },
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemCount: favoriteTemplates.length,
      itemBuilder: (context, index) {
        final template = favoriteTemplates[index];
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1A2029),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF2A2F38)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.3),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.image,
                      color: Colors.blue,
                      size: 40,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      template['title'] as String,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      template['category'] as String,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          template['downloads'] as String,
                          style: const TextStyle(
                            color: Color(0xFFD6FF23),
                            fontSize: 12,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 16,
                          ),
                          onPressed: () {
                            // Remove from favorites
                          },
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildColorsTab() {
    // Mock favorite colors
    final favoriteColors = [
      {'name': 'Neon Green', 'hex': '#D6FF23', 'color': const Color(0xFFD6FF23)},
      {'name': 'Ocean Blue', 'hex': '#00B4D8', 'color': const Color(0xFF00B4D8)},
      {'name': 'Sunset Orange', 'hex': '#FF6B35', 'color': const Color(0xFFFF6B35)},
      {'name': 'Royal Purple', 'hex': '#7209B7', 'color': const Color(0xFF7209B7)},
      {'name': 'Forest Green', 'hex': '#2D6A4F', 'color': const Color(0xFF2D6A4F)},
      {'name': 'Coral Pink', 'hex': '#FF758F', 'color': const Color(0xFFFF758F)},
      {'name': 'Golden Yellow', 'hex': '#FFD23F', 'color': const Color(0xFFFFD23F)},
      {'name': 'Midnight Blue', 'hex': '#1A1A2E', 'color': const Color(0xFF1A1A2E)},
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.2,
      ),
      itemCount: favoriteColors.length,
      itemBuilder: (context, index) {
        final colorItem = favoriteColors[index];
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1A2029),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF2A2F38)),
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: colorItem['color'] as Color,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Text(
                      colorItem['name'] as String,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      colorItem['hex'] as String,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    IconButton(
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 16,
                      ),
                      onPressed: () {
                        // Remove from favorites
                      },
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}