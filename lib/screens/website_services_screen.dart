import 'package:flutter/material.dart';
import 'package:inventor_desgin_studio/theme/constants.dart';

class WebsiteServicesScreen extends StatefulWidget {
  const WebsiteServicesScreen({super.key});

  @override
  State<WebsiteServicesScreen> createState() => _WebsiteServicesScreenState();
}

class _WebsiteServicesScreenState extends State<WebsiteServicesScreen>
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
          // Services Grid
          SliverToBoxAdapter(
            child: _buildServicesGrid(),
          ),
          // Process Section
          SliverToBoxAdapter(
            child: _buildProcessSection(),
          ),
          // Pricing Section
          SliverToBoxAdapter(
            child: _buildPricingSection(),
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
                  _buildNavItem('Services', true),
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
                  'Our Services',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Comprehensive design solutions tailored to your needs',
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

  Widget _buildServicesGrid() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildServiceCard(
                  'Web Design',
                  'Custom websites that convert visitors into customers',
                  Icons.web,
                  [
                    'Responsive Design',
                    'SEO Optimization',
                    'Fast Loading',
                    'Mobile Friendly',
                  ],
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildServiceCard(
                  'Mobile Apps',
                  'Native and cross-platform mobile applications',
                  Icons.phone_android,
                  [
                    'iOS Development',
                    'Android Development',
                    'Cross-Platform',
                    'App Store Optimization',
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _buildServiceCard(
                  'Branding',
                  'Complete brand identity and visual guidelines',
                  Icons.business,
                  [
                    'Logo Design',
                    'Brand Guidelines',
                    'Business Cards',
                    'Marketing Materials',
                  ],
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildServiceCard(
                  'UI/UX Design',
                  'User-centered design for exceptional experiences',
                  Icons.design_services,
                  [
                    'User Research',
                    'Wireframing',
                    'Prototyping',
                    'Usability Testing',
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _buildServiceCard(
                  'E-commerce',
                  'Online stores that drive sales and growth',
                  Icons.shopping_cart,
                  [
                    'Shopify Development',
                    'WooCommerce',
                    'Payment Integration',
                    'Inventory Management',
                  ],
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildServiceCard(
                  'Consulting',
                  'Strategic guidance for your digital presence',
                  Icons.lightbulb,
                  [
                    'Digital Strategy',
                    'Technology Consulting',
                    'Performance Analysis',
                    'Growth Planning',
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(String title, String description, IconData icon, List<String> features) {
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
          Row(
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
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          ...features.map((feature) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: kNeon,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  feature,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white60,
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildProcessSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Column(
        children: [
          const Text(
            'Our Process',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'How we bring your ideas to life',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 60),
          Row(
            children: [
              Expanded(
                child: _buildProcessStep(
                  '01',
                  'Discovery',
                  'We start by understanding your goals, target audience, and requirements.',
                  Icons.search,
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildProcessStep(
                  '02',
                  'Design',
                  'Our team creates wireframes, mockups, and prototypes.',
                  Icons.palette,
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildProcessStep(
                  '03',
                  'Development',
                  'We build your project using the latest technologies.',
                  Icons.code,
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildProcessStep(
                  '04',
                  'Launch',
                  'We deploy and optimize your project for success.',
                  Icons.rocket_launch,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProcessStep(String number, String title, String description, IconData icon) {
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
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: kNeon.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(icon, color: kNeon, size: 30),
          ),
          const SizedBox(height: 16),
          Text(
            number,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: kNeon,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
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

  Widget _buildPricingSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Column(
        children: [
          const Text(
            'Pricing Plans',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Choose the plan that fits your needs',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 60),
          Row(
            children: [
              Expanded(
                child: _buildPricingCard(
                  'Basic',
                  '\$999',
                  'Perfect for small projects',
                  [
                    'Up to 5 pages',
                    'Responsive design',
                    'Basic SEO',
                    '1 month support',
                  ],
                  false,
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildPricingCard(
                  'Professional',
                  '\$2,499',
                  'Most popular choice',
                  [
                    'Up to 15 pages',
                    'Advanced features',
                    'SEO optimization',
                    '3 months support',
                    'Content management',
                  ],
                  true,
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildPricingCard(
                  'Enterprise',
                  'Custom',
                  'For large organizations',
                  [
                    'Unlimited pages',
                    'Custom development',
                    'Priority support',
                    'Dedicated team',
                    'Ongoing maintenance',
                  ],
                  false,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPricingCard(String title, String price, String description, List<String> features, bool isPopular) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: isPopular ? kNeon.withValues(alpha: 0.1) : kCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isPopular ? kNeon : kStroke,
          width: isPopular ? 2 : 1,
        ),
      ),
      child: Column(
        children: [
          if (isPopular)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: kNeon,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Most Popular',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          if (isPopular) const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            price,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: kNeon,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 24),
          ...features.map((feature) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                const Icon(
                  Icons.check,
                  color: kNeon,
                  size: 16,
                ),
                const SizedBox(width: 12),
                Text(
                  feature,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          )),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: isPopular ? kNeon : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: isPopular ? null : Border.all(color: Colors.white30),
            ),
            child: Text(
              'Get Started',
              style: TextStyle(
                color: isPopular ? Colors.black : Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
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
              'Let\'s discuss your requirements and create something amazing together',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  decoration: BoxDecoration(
                    color: kNeon,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Get Free Quote',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white30),
                  ),
                  child: const Text(
                    'View Portfolio',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
