import 'package:flutter/material.dart';
import 'package:inventor_desgin_studio/theme/constants.dart';

class WebsiteContactScreen extends StatefulWidget {
  const WebsiteContactScreen({super.key});

  @override
  State<WebsiteContactScreen> createState() => _WebsiteContactScreenState();
}

class _WebsiteContactScreenState extends State<WebsiteContactScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

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
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
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
          // Contact Content
          SliverToBoxAdapter(
            child: _buildContactContent(),
          ),
          // Contact Info Section
          SliverToBoxAdapter(
            child: _buildContactInfoSection(),
          ),
          // Map Section
          SliverToBoxAdapter(
            child: _buildMapSection(),
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
                  _buildNavItem('Contact', true),
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
                  'Get In Touch',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'We\'d love to hear from you. Send us a message and we\'ll respond as soon as possible.',
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

  Widget _buildContactContent() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Row(
        children: [
          // Contact Form
          Expanded(
            flex: 2,
            child: _buildContactForm(),
          ),
          const SizedBox(width: 60),
          // Contact Info
          Expanded(
            flex: 1,
            child: _buildContactInfo(),
          ),
        ],
      ),
    );
  }

  Widget _buildContactForm() {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kStroke),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Send us a Message',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 32),
            _buildTextField(
              controller: _nameController,
              label: 'Full Name',
              hint: 'Enter your full name',
              icon: Icons.person,
            ),
            const SizedBox(height: 24),
            _buildTextField(
              controller: _emailController,
              label: 'Email Address',
              hint: 'Enter your email',
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 24),
            _buildTextField(
              controller: _subjectController,
              label: 'Subject',
              hint: 'What\'s this about?',
              icon: Icons.subject,
            ),
            const SizedBox(height: 24),
            _buildTextField(
              controller: _messageController,
              label: 'Message',
              hint: 'Tell us about your project...',
              icon: Icons.message,
              maxLines: 4,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: kNeon,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Send Message',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white38),
            prefixIcon: Icon(icon, color: kNeon),
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.05),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.white30),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.white30),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: kNeon),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Contact Information',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 32),
        _buildContactItem(
          Icons.location_on,
          'Address',
          '123 Design Street\nCreative City, CC 12345',
        ),
        const SizedBox(height: 24),
        _buildContactItem(
          Icons.phone,
          'Phone',
          '+1 (555) 123-4567\n+1 (555) 987-6543',
        ),
        const SizedBox(height: 24),
        _buildContactItem(
          Icons.email,
          'Email',
          'hello@inventerdesign.com\nsupport@inventerdesign.com',
        ),
        const SizedBox(height: 24),
        _buildContactItem(
          Icons.access_time,
          'Business Hours',
          'Mon - Fri: 9:00 AM - 6:00 PM\nSat: 10:00 AM - 4:00 PM',
        ),
        const SizedBox(height: 40),
        const Text(
          'Follow Us',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildSocialIcon(Icons.facebook),
            const SizedBox(width: 16),
            _buildSocialIcon(Icons.alternate_email),
            const SizedBox(width: 16),
            _buildSocialIcon(Icons.business),
            const SizedBox(width: 16),
            _buildSocialIcon(Icons.camera_alt),
          ],
        ),
      ],
    );
  }

  Widget _buildContactItem(IconData icon, String title, String content) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: kNeon.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: kNeon, size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                content,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: kNeon.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kNeon.withValues(alpha: 0.3)),
      ),
      child: Icon(icon, color: kNeon, size: 20),
    );
  }

  Widget _buildContactInfoSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Column(
        children: [
          const Text(
            'Why Choose Us?',
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
                child: _buildInfoCard(
                  Icons.speed,
                  'Fast Response',
                  'We respond to all inquiries within 24 hours',
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildInfoCard(
                  Icons.support_agent,
                  'Expert Support',
                  'Our team is here to help with any questions',
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildInfoCard(
                  Icons.security,
                  'Secure & Reliable',
                  'Your information is safe and protected',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String title, String description) {
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

  Widget _buildMapSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Column(
        children: [
          const Text(
            'Find Us',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 40),
          Container(
            height: 400,
            decoration: BoxDecoration(
              color: kNeon.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: kNeon.withValues(alpha: 0.3)),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.map,
                    size: 60,
                    color: kNeon,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Interactive Map',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '123 Design Street, Creative City',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
