import 'package:flutter/material.dart';
import 'package:inventor_desgin_studio/screens/create_screen.dart';
import 'package:inventor_desgin_studio/screens/browse_files_screen.dart';
import 'package:inventor_desgin_studio/screens/team_invite_screen.dart';
import 'package:inventor_desgin_studio/screens/settings_screen.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: QuickButton(
                    icon: Icons.add,
                    label: 'New Project',
                    neonBorder: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CreateScreen()),
                      );
                    })),
            const SizedBox(width: 12),
            Expanded(
                child: QuickButton(
                    icon: Icons.folder_open,
                    label: 'Browse Files',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const BrowseFilesScreen()),
                      );
                    })),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: QuickButton(
                icon: Icons.group_add,
                label: 'Team Invite',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const TeamInviteScreen()),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: QuickButton(
                icon: Icons.settings,
                label: 'Settings',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SettingsScreen()),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class QuickButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool neonBorder;
  final VoidCallback? onTap;

  const QuickButton({
    super.key,
    required this.icon,
    required this.label,
    this.neonBorder = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76,
      decoration: BoxDecoration(
        color: const Color(0xFF1A2029),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: neonBorder ? const Color(0xFFD6FF23) : const Color(0xFF2A2F38)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap ?? () {},
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: neonBorder ? const Color(0xFFD6FF23) : Colors.white70),
              const SizedBox(width: 8),
              Text(label,
                  style: TextStyle(
                      color: neonBorder ? const Color(0xFFD6FF23) : Colors.white,
                      fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}