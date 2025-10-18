// lib/button_components/button.dart
import 'package:flutter/material.dart';

class NeonButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool loading; // <-- yeh add kiya

  const NeonButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.loading = false, // <-- default false
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: loading ? null : onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFD6FF23), Color(0xFFFFFF00)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFD6FF23).withValues(alpha: 0.6),
              blurRadius: 18,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: loading
            ? const SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            strokeWidth: 2,
          ),
        )
            : Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
