import 'package:flutter/material.dart';
import 'package:inventor_desgin_studio/screens/browse_files_screen.dart';
import 'package:inventor_desgin_studio/screens/message_screen.dart';

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
                    label: 'New Design',
                    neonBorder: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const BrowseFilesScreen()),
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
                icon: Icons.message_outlined,
                label: 'Support Chat',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const MessageScreen()),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: QuickButton(
                icon: Icons.help_outline,
                label: 'Help Center',
                onTap: () {
                  // Navigate to help center
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Help Center coming soon!')),
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