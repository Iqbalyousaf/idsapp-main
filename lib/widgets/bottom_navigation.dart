import 'package:flutter/material.dart';
import 'package:inventor_desgin_studio/screens/home.dart';
import 'package:inventor_desgin_studio/screens/browse_files_screen.dart';
import 'package:inventor_desgin_studio/screens/message_screen.dart';
import 'package:inventor_desgin_studio/screens/profile_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeDashboard(key: Key('home_dashboard')),
    const BrowseFilesScreen(key: Key('browse_files_screen')),
    const MessageScreen(key: Key('message_screen')),
    const ProfileScreen(key: Key('profile_screen')),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 14),
        decoration: const BoxDecoration(
          color: Color(0xFF1A2029),
          border: Border(top: BorderSide(color: Color(0xFF2A2F38))),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _NavItem(
              icon: Icons.home_filled,
              label: 'Home',
              isSelected: _selectedIndex == 0,
              onTap: () => _onItemTapped(0),
            ),
            _NavItem(
              icon: Icons.design_services,
              label: 'Design',
              isSelected: _selectedIndex == 1,
              onTap: () => _onItemTapped(1),
            ),
            _NavItem(
              icon: Icons.message_outlined,
              label: 'Messages',
              isSelected: _selectedIndex == 2,
              onTap: () => _onItemTapped(2),
            ),
            _NavItem(
              icon: Icons.person_outline,
              label: 'Profile',
              isSelected: _selectedIndex == 3,
              onTap: () => _onItemTapped(3),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0xFFD6FF23) : Colors.white70,
              size: 24,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? const Color(0xFFD6FF23) : Colors.white70,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
