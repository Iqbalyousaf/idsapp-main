import 'package:flutter/material.dart';
import 'package:inventor_desgin_studio/theme/constants.dart';

class StatsPanel extends StatelessWidget {
  const StatsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: StatCard(
            title: 'Projects',
            value: '12',
            subtitle: 'Active',
            icon: Icons.auto_awesome_motion,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: StatCard(
            title: 'This week',
            value: '24h',
            subtitle: 'Time spent',
            icon: Icons.timer_outlined,
          ),
        ),
      ],
    );
  }
}

class StatCard extends StatelessWidget {
  final String title, value, subtitle;
  final IconData icon;
  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: kStroke),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: kNeon.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: kNeon, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w800)),
                const SizedBox(height: 2),
                Text(title, style: const TextStyle(color: Colors.white70)),
                Text(subtitle, style: const TextStyle(color: Colors.white38)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}