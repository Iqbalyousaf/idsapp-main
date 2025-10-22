import 'package:flutter/material.dart';
import 'package:inventor_desgin_studio/theme/constants.dart';
import 'team_screen.dart';

class WebsiteAboutScreen extends StatefulWidget {
  const WebsiteAboutScreen({super.key});

  @override
  State<WebsiteAboutScreen> createState() => _WebsiteAboutScreenState();
}

class _WebsiteAboutScreenState extends State<WebsiteAboutScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

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
          // About Content
          SliverToBoxAdapter(
            child: _buildAboutContent(),
          ),
          // Team Section
          SliverToBoxAdapter(
            child: _buildTeamSection(),
          ),
          // Values Section
          SliverToBoxAdapter(
            child: _buildValuesSection(),
          ),
          // Stats Section
          SliverToBoxAdapter(
            child: _buildStatsSection(),
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
                  _buildNavItem('About', true),
                  _buildNavItem('Services'),
                  _buildNavItem('Portfolio'),
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
                  'About Us',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'We are passionate designers creating exceptional digital experiences',
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

  Widget _buildAboutContent() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Our Story',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Founded in 2020, Inventer Design Studio has been at the forefront of digital innovation. We started with a simple mission: to create beautiful, functional designs that make a difference.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Today, we\'re proud to have worked with over 200+ clients worldwide, delivering projects that range from simple websites to complex enterprise applications. Our team of talented designers and developers work tirelessly to bring your vision to life.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    _buildStatItem('200+', 'Projects Completed'),
                    const SizedBox(width: 48),
                    _buildStatItem('50+', 'Happy Clients'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 60),
          Expanded(
            flex: 1,
            child: Container(
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [kNeon.withValues(alpha: 0.1), Colors.transparent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(color: kNeon.withValues(alpha: 0.3)),
              ),
              child: const Center(
                child: Icon(
                  Icons.image,
                  size: 80,
                  color: kNeon,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: kNeon,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildTeamSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Column(
        children: [
          const Text(
            'Meet Our Team',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'The creative minds behind our success',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 60),
          Row(
            children: [
              Expanded(
                child: _buildTeamMember(
                  'Sarah Johnson',
                  'Creative Director',
                  'Leading our design vision with 8+ years of experience in digital design.',
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildTeamMember(
                  'Mike Chen',
                  'Lead Developer',
                  'Full-stack developer passionate about creating scalable solutions.',
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildTeamMember(
                  'Emily Davis',
                  'UX Designer',
                  'Focused on creating intuitive and user-friendly experiences.',
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TeamScreen()),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                decoration: BoxDecoration(
                  color: kNeon,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Meet Our Full Team',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamMember(String name, String role, String description) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kStroke),
      ),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: kNeon.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(40),
            ),
            child: const Icon(
              Icons.person,
              size: 40,
              color: kNeon,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            role,
            style: const TextStyle(
              fontSize: 14,
              color: kNeon,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white70,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildValuesSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Column(
        children: [
          const Text(
            'Our Values',
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
                child: _buildValueCard(
                  Icons.lightbulb,
                  'Innovation',
                  'We constantly push boundaries and explore new creative possibilities.',
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildValueCard(
                  Icons.people,
                  'Collaboration',
                  'We believe in the power of teamwork and client partnership.',
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildValueCard(
                  Icons.star,
                  'Excellence',
                  'We strive for perfection in every project we undertake.',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildValueCard(IconData icon, String title, String description) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kStroke),
      ),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: kNeon.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: kNeon, size: 32),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
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
        child: Row(
          children: [
            Expanded(
              child: _buildStatCard('200+', 'Projects'),
            ),
            Expanded(
              child: _buildStatCard('50+', 'Clients'),
            ),
            Expanded(
              child: _buildStatCard('5+', 'Years'),
            ),
            Expanded(
              child: _buildStatCard('99%', 'Satisfaction'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: kNeon,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}
