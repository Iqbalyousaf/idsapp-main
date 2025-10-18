import 'package:flutter/material.dart';

class PasswordStrengthScreen extends StatefulWidget {
  const PasswordStrengthScreen({super.key});

  @override
  State<PasswordStrengthScreen> createState() => _PasswordStrengthScreenState();
}

class _PasswordStrengthScreenState extends State<PasswordStrengthScreen> {
  final TextEditingController _passwordController = TextEditingController();
  String _passwordStrength = 'Weak';
  Color _strengthColor = Colors.red;
  double _strengthValue = 0.0;
  bool _obscurePassword = true;

  final List<String> _strengthCriteria = [
    'At least 8 characters',
    'Contains uppercase letter',
    'Contains lowercase letter',
    'Contains number',
    'Contains special character',
  ];

  final Map<String, bool> _criteriaMet = {
    'At least 8 characters': false,
    'Contains uppercase letter': false,
    'Contains lowercase letter': false,
    'Contains number': false,
    'Contains special character': false,
  };

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_checkPasswordStrength);
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _checkPasswordStrength() {
    final password = _passwordController.text;

    // Check criteria
    _criteriaMet['At least 8 characters'] = password.length >= 8;
    _criteriaMet['Contains uppercase letter'] = password.contains(RegExp(r'[A-Z]'));
    _criteriaMet['Contains lowercase letter'] = password.contains(RegExp(r'[a-z]'));
    _criteriaMet['Contains number'] = password.contains(RegExp(r'[0-9]'));
    _criteriaMet['Contains special character'] = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    // Calculate strength
    final metCriteria = _criteriaMet.values.where((met) => met).length;

    if (metCriteria <= 2) {
      _passwordStrength = 'Weak';
      _strengthColor = Colors.red;
      _strengthValue = 0.25;
    } else if (metCriteria <= 3) {
      _passwordStrength = 'Fair';
      _strengthColor = Colors.orange;
      _strengthValue = 0.5;
    } else if (metCriteria <= 4) {
      _passwordStrength = 'Good';
      _strengthColor = Colors.yellow;
      _strengthValue = 0.75;
    } else {
      _passwordStrength = 'Strong';
      _strengthColor = Colors.green;
      _strengthValue = 1.0;
    }

    setState(() {});
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
          'Password Strength',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Password Input
            const Text(
              'Test Password Strength',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Enter password to test',
                hintStyle: const TextStyle(color: Colors.white38),
                filled: true,
                fillColor: const Color(0xFF1A2029),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF2A2F38)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFD6FF23)),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white54,
                  ),
                  onPressed: () {
                    setState(() => _obscurePassword = !_obscurePassword);
                  },
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Strength Indicator
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1A2029),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF2A2F38)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Password Strength',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        _passwordStrength,
                        style: TextStyle(
                          color: _strengthColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: _strengthValue,
                    backgroundColor: const Color(0xFF2A2F38),
                    valueColor: AlwaysStoppedAnimation<Color>(_strengthColor),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _getStrengthDescription(),
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Criteria Checklist
            const Text(
              'Password Requirements',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1A2029),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF2A2F38)),
              ),
              child: Column(
                children: _strengthCriteria.map((criteria) {
                  final isMet = _criteriaMet[criteria]!;
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      border: _strengthCriteria.last != criteria
                          ? const Border(bottom: BorderSide(color: Color(0xFF2A2F38)))
                          : null,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isMet ? Icons.check_circle : Icons.radio_button_unchecked,
                          color: isMet ? Colors.green : Colors.white54,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            criteria,
                            style: TextStyle(
                              color: isMet ? Colors.white : Colors.white70,
                              decoration: isMet ? TextDecoration.lineThrough : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 24),

            // Tips Section
            const Text(
              'Password Tips',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
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
                  _TipItem(
                    icon: Icons.lightbulb,
                    title: 'Use a passphrase',
                    description: 'Combine multiple words for better security',
                  ),
                  const SizedBox(height: 16),
                  _TipItem(
                    icon: Icons.shuffle,
                    title: 'Avoid common patterns',
                    description: 'Don\'t use "123456" or "password"',
                  ),
                  const SizedBox(height: 16),
                  _TipItem(
                    icon: Icons.refresh,
                    title: 'Change regularly',
                    description: 'Update your password every 3-6 months',
                  ),
                  const SizedBox(height: 16),
                  _TipItem(
                    icon: Icons.devices,
                    title: 'Use different passwords',
                    description: 'Don\'t reuse passwords across accounts',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  String _getStrengthDescription() {
    switch (_passwordStrength) {
      case 'Weak':
        return 'This password is easily guessable. Consider adding more characters and variety.';
      case 'Fair':
        return 'This password is decent but could be stronger. Add more complexity.';
      case 'Good':
        return 'This is a good password. You\'re on the right track!';
      case 'Strong':
        return 'Excellent! This password provides strong security.';
      default:
        return '';
    }
  }
}

class _TipItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _TipItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: const Color(0xFFD6FF23).withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, color: const Color(0xFFD6FF23), size: 16),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}