import 'package:flutter/material.dart';
import 'package:inventor_desgin_studio/theme/constants.dart';

class TeamScreen extends StatefulWidget {
  const TeamScreen({super.key});

  @override
  State<TeamScreen> createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen>
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
          // Team Members
          SliverToBoxAdapter(
            child: _buildTeamMembers(),
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
                  _buildNavItem('Portfolio'),
                  _buildNavItem('Contact'),
                  _buildNavItem('Team', true),
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
                  'Our Team',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Meet the creative minds behind our success',
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

  Widget _buildTeamMembers() {
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
          Wrap(
            spacing: 24,
            runSpacing: 24,
            children: [
              _buildTeamMember(
                'Sarah Johnson',
                'Creative Director',
                'Leading our design vision with 8+ years of experience in digital design.',
              ),
              _buildTeamMember(
                'Mike Chen',
                'Lead Developer',
                'Full-stack developer passionate about creating scalable solutions.',
              ),
              _buildTeamMember(
                'Emily Davis',
                'UX Designer',
                'Focused on creating intuitive and user-friendly experiences.',
              ),
              _buildTeamMember(
                'Alex Rodriguez',
                'Project Manager',
                'Ensuring projects are delivered on time and exceed expectations.',
              ),
              _buildTeamMember(
                'Lisa Wang',
                'Graphic Designer',
                'Specializing in branding and visual identity design.',
              ),
              _buildTeamMember(
                'David Kim',
                'Mobile Developer',
                'Expert in cross-platform mobile app development.',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTeamMember(String name, String role, String description) {
    return Container(
      width: 300,
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
}