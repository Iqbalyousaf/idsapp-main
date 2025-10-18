import 'package:flutter/material.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String _selectedLanguage = 'English';

  final List<Map<String, String>> _languages = [
    {'code': 'en', 'name': 'English', 'native': 'English'},
    {'code': 'es', 'name': 'Spanish', 'native': 'Español'},
    {'code': 'fr', 'name': 'French', 'native': 'Français'},
    {'code': 'de', 'name': 'German', 'native': 'Deutsch'},
    {'code': 'it', 'name': 'Italian', 'native': 'Italiano'},
    {'code': 'pt', 'name': 'Portuguese', 'native': 'Português'},
    {'code': 'ru', 'name': 'Russian', 'native': 'Русский'},
    {'code': 'ja', 'name': 'Japanese', 'native': '日本語'},
    {'code': 'ko', 'name': 'Korean', 'native': '한국어'},
    {'code': 'zh', 'name': 'Chinese', 'native': '中文'},
    {'code': 'ar', 'name': 'Arabic', 'native': 'العربية'},
    {'code': 'hi', 'name': 'Hindi', 'native': 'हिन्दी'},
  ];

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
          'Language',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Save language preference
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Language changed to $_selectedLanguage'),
                  backgroundColor: const Color(0xFFD6FF23),
                ),
              );
            },
            child: const Text(
              'Save',
              style: TextStyle(
                color: Color(0xFFD6FF23),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Text(
              'Choose your language',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Select the language you prefer for the app interface.',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 24),

            // Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A2029),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF2A2F38)),
              ),
              child: const TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search languages...',
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                  icon: Icon(Icons.search, color: Colors.white54),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Language List
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1A2029),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF2A2F38)),
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _languages.length,
                separatorBuilder: (context, index) => const Divider(
                  color: Color(0xFF2A2F38),
                  height: 1,
                ),
                itemBuilder: (context, index) {
                  final language = _languages[index];
                  final isSelected = language['name'] == _selectedLanguage;

                  return ListTile(
                    title: Text(
                      language['name']!,
                      style: TextStyle(
                        color: isSelected ? const Color(0xFFD6FF23) : Colors.white,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                    subtitle: Text(
                      language['native']!,
                      style: TextStyle(
                        color: isSelected ? const Color(0xFFD6FF23).withValues(alpha: 0.7) : Colors.white70,
                      ),
                    ),
                    trailing: isSelected
                        ? const Icon(
                            Icons.check_circle,
                            color: Color(0xFFD6FF23),
                          )
                        : null,
                    onTap: () {
                      setState(() => _selectedLanguage = language['name']!);
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // System Default Option
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1A2029),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF2A2F38)),
              ),
              child: ListTile(
                title: const Text(
                  'System Default',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: const Text(
                  'Use device language',
                  style: TextStyle(color: Colors.white70),
                ),
                trailing: _selectedLanguage == 'System Default'
                    ? const Icon(
                        Icons.check_circle,
                        color: Color(0xFFD6FF23),
                      )
                    : null,
                onTap: () {
                  setState(() => _selectedLanguage = 'System Default');
                },
              ),
            ),

            const SizedBox(height: 24),

            // Info Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFD6FF23).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFD6FF23).withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: Color(0xFFD6FF23),
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Language Support',
                          style: TextStyle(
                            color: Color(0xFFD6FF23),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Some features may not be fully translated. We\'re working on expanding our language support.',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}