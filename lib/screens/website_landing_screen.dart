import 'package:flutter/material.dart';
import 'package:inventor_desgin_studio/theme/constants.dart';

class WebsiteLandingScreen extends StatefulWidget {
  const WebsiteLandingScreen({super.key});

  @override
  State<WebsiteLandingScreen> createState() => _WebsiteLandingScreenState();
}

class _WebsiteLandingScreenState extends State<WebsiteLandingScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic));

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),
      body: CustomScrollView(
        slivers: [
          // Hero Section
          SliverToBoxAdapter(
            child: _buildHeroSection(),
          ),
          // Features Section
          SliverToBoxAdapter(
            child: _buildFeaturesSection(),
          ),
          // Services Section
          SliverToBoxAdapter(
            child: _buildServicesSection(),
          ),
          // CTA Section
          SliverToBoxAdapter(
            child: _buildCTASection(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
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
                  _buildNavItem('Home', true),
                  _buildNavItem('About'),
                  _buildNavItem('Services'),
                  _buildNavItem('Portfolio'),
                  _buildNavItem('Contact'),
                ],
              ),
            ],
          ),
          const Spacer(),
          // Hero Content
          FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: kNeon.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: kNeon.withValues(alpha: 0.3)),
                    ),
                    child: const Text(
                      'Creative Design Solutions',
                      style: TextStyle(
                        color: kNeon,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Transform Your Ideas\nInto Stunning Designs',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'We create exceptional digital experiences that captivate your audience and drive results. From concept to completion, we bring your vision to life.',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      _buildButton('Get Started', true),
                      const SizedBox(width: 16),
                      _buildButton('View Portfolio', false),
                    ],
                  ),
                ],
              ),
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

  Widget _buildButton(String text, bool isPrimary) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      decoration: BoxDecoration(
        color: isPrimary ? kNeon : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: isPrimary ? null : Border.all(color: Colors.white30),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isPrimary ? Colors.black : Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildFeaturesSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Column(
        children: [
          const Text(
            'Why Choose Us',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'We deliver exceptional results through innovative design and cutting-edge technology',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),
          Row(
            children: [
              Expanded(
                child: _buildFeatureCard(
                  Icons.palette,
                  'Creative Design',
                  'Unique and innovative designs that stand out from the competition',
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildFeatureCard(
                  Icons.speed,
                  'Fast Delivery',
                  'Quick turnaround times without compromising on quality',
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildFeatureCard(
                  Icons.support_agent,
                  '24/7 Support',
                  'Round-the-clock assistance to help you succeed',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(IconData icon, String title, String description) {
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

  Widget _buildServicesSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Column(
        children: [
          const Text(
            'Our Services',
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
                child: _buildServiceCard(
                  'Web Design',
                  'Custom websites that convert visitors into customers',
                  Icons.web,
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildServiceCard(
                  'Mobile Apps',
                  'Native and cross-platform mobile applications',
                  Icons.phone_android,
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildServiceCard(
                  'Branding',
                  'Complete brand identity and visual guidelines',
                  Icons.business,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(String title, String description, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kStroke),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: kNeon.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: kNeon, size: 24),
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
              'Let\'s work together to create something amazing',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            _buildButton('Contact Us Today', true),
          ],
        ),
      ),
    );
  }
}
