import 'package:flutter/material.dart';
import 'package:inventor_desgin_studio/theme/constants.dart';
import 'website_landing_screen.dart';
import 'website_about_screen.dart';
import 'website_services_screen.dart';
import 'website_portfolio_screen.dart';
import 'website_contact_screen.dart';
import 'team_screen.dart';

class WebsiteMainScreen extends StatefulWidget {
  const WebsiteMainScreen({super.key});

  @override
  State<WebsiteMainScreen> createState() => _WebsiteMainScreenState();
}

class _WebsiteMainScreenState extends State<WebsiteMainScreen> {
  int _currentIndex = 0;
  
  final List<Widget> _screens = [
    const WebsiteLandingScreen(),
    const WebsiteAboutScreen(),
    const WebsiteServicesScreen(),
    const WebsitePortfolioScreen(),
    const WebsiteContactScreen(),
    const TeamScreen(),
  ];

  final List<String> _screenTitles = [
    'Home',
    'About',
    'Services',
    'Portfolio',
    'Contact',
    'Team',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: kCard,
          border: Border(
            top: BorderSide(color: kStroke),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_screens.length, (index) {
                final isSelected = _currentIndex == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? kNeon.withValues(alpha: 0.1) : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _getIconForIndex(index),
                          color: isSelected ? kNeon : Colors.white60,
                          size: 20,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _screenTitles[index],
                          style: TextStyle(
                            color: isSelected ? kNeon : Colors.white60,
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  IconData _getIconForIndex(int index) {
    switch (index) {
      case 0:
        return Icons.home;
      case 1:
        return Icons.info;
      case 2:
        return Icons.design_services;
      case 3:
        return Icons.work;
      case 4:
        return Icons.contact_mail;
      case 5:
        return Icons.people;
      default:
        return Icons.home;
    }
  }
}
