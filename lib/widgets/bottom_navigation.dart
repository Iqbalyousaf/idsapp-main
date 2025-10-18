import 'package:flutter/material.dart';
import 'package:inventor_desgin_studio/screens/home.dart';
import 'package:inventor_desgin_studio/screens/projects_screen.dart';
import 'package:inventor_desgin_studio/screens/analytics_screen.dart';
import 'package:inventor_desgin_studio/screens/profile_tab_screen.dart';
import 'package:inventor_desgin_studio/screens/create_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeDashboard(key: Key('home_dashboard')),
    ProjectsScreen(key: Key('projects_screen')),
    AnalyticsScreen(key: Key('analytics_screen')),
    ProfileTabScreen(key: Key('profile_tab_screen')),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  void _onCreatePressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CreateScreen()),
    );
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
              icon: Icons.folder_copy_outlined,
              label: 'Projects',
              isSelected: _selectedIndex == 1,
              onTap: () => _onItemTapped(1),
            ),
            _CreateButton(onPressed: _onCreatePressed),
            _NavItem(
              icon: Icons.analytics_outlined,
              label: 'Analytics',
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

class _CreateButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _CreateButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 46,
        height: 36,
        decoration: BoxDecoration(
          color: const Color(0xFFD6FF23),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(
          Icons.add,
          color: Colors.black,
          size: 24,
        ),
      ),
    );
  }
}