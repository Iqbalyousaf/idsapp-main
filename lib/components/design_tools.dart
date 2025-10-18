import 'package:flutter/material.dart';
import 'package:inventor_desgin_studio/theme/constants.dart';

class DesignTools extends StatelessWidget {
  const DesignTools({super.key});

  @override
  Widget build(BuildContext context) {
    final tools = [
      Tool(icon: Icons.edit, label: 'Draw', color: const Color(0xFF60A5FA)),
      Tool(icon: Icons.rectangle_outlined, label: 'Shapes', color: const Color(0xFFF87171)),
      Tool(icon: Icons.text_fields, label: 'Text', color: const Color(0xFF34D399)),
      Tool(icon: Icons.layers_outlined, label: 'Layers', color: const Color(0xFF9F7AEA)),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Design Tools',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: tools.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1.2,
          ),
          itemBuilder: (_, i) => ToolButton(tool: tools[i]),
        ),
      ],
    );
  }
}

class Tool {
  final IconData icon;
  final String label;
  final Color color;
  const Tool({required this.icon, required this.label, required this.color});
}

class ToolButton extends StatelessWidget {
  final Tool tool;
  const ToolButton({super.key, required this.tool});

  void _openDesignTool(BuildContext context, Tool tool) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${tool.label} tool opened!'),
        backgroundColor: tool.color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(14),

        border: Border.all(color: kStroke),
      ),

      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          _openDesignTool(context, tool);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 34,
              height: 24,
              decoration: BoxDecoration(
                color: tool.color.withValues(alpha: .28),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(tool.icon, color: tool.color, size: 20),
            ),
            const SizedBox(height: 2),
            Text(tool.label,
                style: const TextStyle(fontSize: 12, color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}
