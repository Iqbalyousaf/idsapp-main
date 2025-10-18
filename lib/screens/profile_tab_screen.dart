import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:inventor_desgin_studio/providers/auth_provider.dart';
import 'package:inventor_desgin_studio/providers/user_provider.dart';
import 'package:inventor_desgin_studio/screens/settings_screen.dart';
import 'package:inventor_desgin_studio/screens/profile_screen.dart';
import 'package:inventor_desgin_studio/screens/my_projects_screen.dart';
import 'package:inventor_desgin_studio/screens/profile_analytics_screen.dart';
import 'package:inventor_desgin_studio/screens/favorites_screen.dart';
import 'package:inventor_desgin_studio/screens/profile_help_screen.dart';

class ProfileTabScreen extends StatelessWidget {
  const ProfileTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        return Scaffold(
          backgroundColor: const Color(0xFF0E131A),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Profile Header
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A2029),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFF2A2F38)),
                    ),
                    child: Column(
                      children: [
                        // Profile Picture
                        Stack(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFFD6FF23).withValues(alpha: 0.2),
                                border: Border.all(
                                  color: const Color(0xFFD6FF23),
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  userProvider.initials,
                                  style: const TextStyle(
                                    color: Color(0xFFD6FF23),
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFD6FF23),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(0xFF0E131A),
                                    width: 2,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                  size: 12,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Name and Role
                        Text(
                          userProvider.fullName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          userProvider.role.toUpperCase(),
                          style: const TextStyle(
                            color: Color(0xFFD6FF23),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Quick Stats
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _QuickStat(label: 'Projects', value: '24'),
                            _QuickStat(label: 'Completed', value: '18'),
                            _QuickStat(label: 'Rating', value: '4.8'),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Menu Items
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A2029),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFF2A2F38)),
                    ),
                    child: Column(
                      children: [
                        _ProfileMenuItem(
                          icon: Icons.person_outline,
                          title: 'Edit Profile',
                          subtitle: 'Update personal information',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ProfileScreen(),
                              ),
                            );
                          },
                        ),
                        const Divider(color: Color(0xFF2A2F38), height: 1),
                        _ProfileMenuItem(
                          icon: Icons.folder_copy,
                          title: 'My Projects',
                          subtitle: 'View all your projects',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const MyProjectsScreen(),
                              ),
                            );
                          },
                        ),
                        const Divider(color: Color(0xFF2A2F38), height: 1),
                        _ProfileMenuItem(
                          icon: Icons.analytics,
                          title: 'Analytics',
                          subtitle: 'View your performance',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ProfileAnalyticsScreen(),
                              ),
                            );
                          },
                        ),
                        const Divider(color: Color(0xFF2A2F38), height: 1),
                        _ProfileMenuItem(
                          icon: Icons.favorite_border,
                          title: 'Favorites',
                          subtitle: 'Your saved items',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const FavoritesScreen(),
                              ),
                            );
                          },
                        ),
                        const Divider(color: Color(0xFF2A2F38), height: 1),
                        _ProfileMenuItem(
                          icon: Icons.settings,
                          title: 'Settings',
                          subtitle: 'App preferences and configuration',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SettingsScreen(),
                              ),
                            );
                          },
                        ),
                        const Divider(color: Color(0xFF2A2F38), height: 1),
                        _ProfileMenuItem(
                          icon: Icons.help_outline,
                          title: 'Help & Support',
                          subtitle: 'Get help and contact support',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ProfileHelpScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Account Status
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A2029),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFF2A2F38)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Account Status',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: userProvider.emailVerified ? Colors.green : Colors.orange,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              userProvider.emailVerified ? 'Email Verified' : 'Email Not Verified',
                              style: const TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Account Active',
                              style: TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Sign Out Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        final authProvider = Provider.of<AuthProvider>(context, listen: false);
                        await authProvider.logout();
                        if (context.mounted) {
                          Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                        }
                      },
                      icon: const Icon(Icons.logout, color: Colors.white),
                      label: const Text(
                        'Sign Out',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.withValues(alpha: 0.2),
                        side: const BorderSide(color: Colors.red),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _QuickStat extends StatelessWidget {
  final String label;
  final String value;

  const _QuickStat({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ProfileMenuItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: const Color(0xFFD6FF23).withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: const Color(0xFFD6FF23)),
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: Colors.white70),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.white54,
        size: 16,
      ),
      onTap: onTap,
    );
  }
}