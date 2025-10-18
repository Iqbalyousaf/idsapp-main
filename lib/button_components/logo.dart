import 'package:flutter/material.dart';

class LogoAnimation extends StatefulWidget {
  final double size; // 👈 logo size

  const LogoAnimation({super.key, this.size = 100});

  @override
  State<LogoAnimation> createState() => _LogoAnimationState();
}

class _LogoAnimationState extends State<LogoAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: ScaleTransition(
        scale: _animation,
        child: Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              // shape: BoxShape.circle,
              image: const DecorationImage(
                image: AssetImage("assets/r.png"),

              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.6), // shadow color
                  blurRadius: 20,
                  spreadRadius: 5,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
