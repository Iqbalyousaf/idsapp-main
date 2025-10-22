import 'package:flutter/material.dart';
import 'package:inventor_desgin_studio/theme/constants.dart';

class WebsitePortfolioScreen extends StatefulWidget {
  const WebsitePortfolioScreen({super.key});

  @override
  State<WebsitePortfolioScreen> createState() => _WebsitePortfolioScreenState();
}

class _WebsitePortfolioScreenState extends State<WebsitePortfolioScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  String selectedCategory = 'All';

  final List<String> categories = ['All', 'Web Design', 'Mobile Apps', 'Branding', 'UI/UX'];
  
  final List<PortfolioItem> portfolioItems = [
    PortfolioItem(
      title: 'E-commerce Website',
      category: 'Web Design',
      description: 'Modern e-commerce platform with advanced features',
      image: 'assets/portfolio1.jpg',
      tags: ['E-commerce', 'React', 'Node.js'],
    ),
    PortfolioItem(
      title: 'Mobile Banking App',
      category: 'Mobile Apps',
      description: 'Secure banking application for iOS and Android',
      image: 'assets/portfolio2.jpg',
      tags: ['Mobile', 'Flutter', 'Security'],
    ),
    PortfolioItem(
      title: 'Brand Identity',
      category: 'Branding',
      description: 'Complete brand identity for tech startup',
      image: 'assets/portfolio3.jpg',
      tags: ['Branding', 'Logo', 'Guidelines'],
    ),
    PortfolioItem(
      title: 'SaaS Dashboard',
      category: 'UI/UX',
      description: 'User-friendly dashboard for SaaS platform',
      image: 'assets/portfolio4.jpg',
      tags: ['Dashboard', 'UX', 'Analytics'],
    ),
    PortfolioItem(
      title: 'Restaurant Website',
      category: 'Web Design',
      description: 'Beautiful website for local restaurant',
      image: 'assets/portfolio5.jpg',
      tags: ['Restaurant', 'WordPress', 'SEO'],
    ),
    PortfolioItem(
      title: 'Fitness App',
      category: 'Mobile Apps',
      description: 'Health and fitness tracking application',
      image: 'assets/portfolio6.jpg',
      tags: ['Fitness', 'Health', 'Tracking'],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),
      body: CustomScrollView(
        slivers: [
          // Header Section
          SliverToBoxAdapter(
            child: _buildHeader(),
          ),
          // Filter Section
          SliverToBoxAdapter(
            child: _buildFilterSection(),
          ),
          // Portfolio Grid
          SliverToBoxAdapter(
            child: _buildPortfolioGrid(),
          ),
          // Testimonials Section
          SliverToBoxAdapter(
            child: _buildTestimonialsSection(),
          ),
          // CTA Section
          SliverToBoxAdapter(
            child: _buildCTASection(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Navigation Bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: kNeon,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.design_services,
                      color: Colors.black,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Inventer Design Studio',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              // Navigation Menu
              Row(
                children: [
                  _buildNavItem('Home'),
                  _buildNavItem('About'),
                  _buildNavItem('Services'),
                  _buildNavItem('Portfolio', true),
                  _buildNavItem('Contact'),
                ],
              ),
            ],
          ),
          const Spacer(),
          // Header Content
          FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Our Portfolio',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Showcasing our best work and creative solutions',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildNavItem(String text, [bool isActive = false]) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        text,
        style: TextStyle(
          color: isActive ? kNeon : Colors.white70,
          fontSize: 16,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: categories.map((category) {
          final isSelected = selectedCategory == category;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedCategory = category;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? kNeon : Colors.transparent,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: isSelected ? kNeon : Colors.white30,
                  ),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    color: isSelected ? Colors.black : Colors.white70,
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPortfolioGrid() {
    final filteredItems = selectedCategory == 'All' 
        ? portfolioItems 
        : portfolioItems.where((item) => item.category == selectedCategory).toList();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildPortfolioCard(filteredItems[0]),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildPortfolioCard(filteredItems[1]),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _buildPortfolioCard(filteredItems[2]),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildPortfolioCard(filteredItems[3]),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _buildPortfolioCard(filteredItems[4]),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildPortfolioCard(filteredItems[5]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPortfolioCard(PortfolioItem item) {
    return Container(
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kStroke),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image placeholder
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: kNeon.withValues(alpha: 0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.image,
                size: 60,
                color: kNeon,
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: kNeon.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        item.category,
                        style: const TextStyle(
                          color: kNeon,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item.description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: item.tags.map((tag) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      tag,
                      style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 10,
                      ),
                    ),
                  )).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialsSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Column(
        children: [
          const Text(
            'What Our Clients Say',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 60),
          Row(
            children: [
              Expanded(
                child: _buildTestimonialCard(
                  'Sarah Johnson',
                  'CEO, TechCorp',
                  'Inventer Design Studio delivered exceptional results. Their attention to detail and creative approach exceeded our expectations.',
                  Icons.star,
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildTestimonialCard(
                  'Mike Chen',
                  'Founder, StartupXYZ',
                  'Working with this team was a game-changer. They transformed our vision into a stunning reality.',
                  Icons.star,
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildTestimonialCard(
                  'Emily Davis',
                  'Marketing Director',
                  'Professional, creative, and reliable. We couldn\'t be happier with the results.',
                  Icons.star,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialCard(String name, String title, String quote, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kStroke),
      ),
      child: Column(
        children: [
          Row(
            children: List.generate(5, (index) => const Icon(
              Icons.star,
              color: kNeon,
              size: 16,
            )),
          ),
          const SizedBox(height: 20),
          Text(
            quote,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70,
              height: 1.5,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: kNeon.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.person,
                  color: kNeon,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white60,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCTASection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Container(
        padding: const EdgeInsets.all(48),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [kNeon.withValues(alpha: 0.1), Colors.transparent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: kNeon.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            const Text(
              'Ready to Start Your Project?',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'Let\'s create something amazing together',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              decoration: BoxDecoration(
                color: kNeon,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Get Started Today',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PortfolioItem {
  final String title;
  final String category;
  final String description;
  final String image;
  final List<String> tags;

  PortfolioItem({
    required this.title,
    required this.category,
    required this.description,
    required this.image,
    required this.tags,
  });
}
