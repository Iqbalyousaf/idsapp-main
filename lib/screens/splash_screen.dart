import 'dart:async';
import 'package:flutter/material.dart';
import 'package:inventor_desgin_studio/button_components/logo.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int _currentIndex = 0;
  late Timer _timer;

  final List<String> _titles = [
    "Inventor",
    "Inventor",
    "Inventor",
  ];

  final List<String> _subTitles = [
    "Design Studio",
    "Design Studio",
    "Design Studio",
  ];

  final List<String> _tagLines = [
    "Unleash Your Creative Potential",
    "Unleash Your Creative Potential",
    "Unleash Your Creative Potential",
  ];

  @override
  void initState() {
    super.initState();

    // slider change every 2 sec
    _timer = Timer.periodic(const Duration(seconds:1), (t) {
      if (!mounted) return;
      setState(() {
        _currentIndex = (_currentIndex + 1) % 3;
      });
    });

    // navigate to login after 6 sec
    Future.delayed(const Duration(seconds:4), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const neon = Color(0xFFD6FF23);

    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ===== Logo box =====
            const LogoAnimation(),

            const SizedBox(height: 5),

            // ===== Title =====
            Text(
              _titles[_currentIndex],
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            // ===== Subtitle =====
            Text(
              _subTitles[_currentIndex],
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: neon,
              ),
            ),
            const SizedBox(height: 12),

            // ===== Tagline =====
            Text(
              _tagLines[_currentIndex],
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 40),

            // ===== Dots Indicator =====
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: index == _currentIndex ? 24 : 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: index == _currentIndex ? neon : Colors.green,
                    borderRadius: BorderRadius.circular(5),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
