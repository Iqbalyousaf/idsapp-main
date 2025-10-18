// lib/screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:inventor_desgin_studio/button_components/button.dart';
import 'package:inventor_desgin_studio/button_components/logo.dart';
import 'package:inventor_desgin_studio/screens/sign_up.dart' show SignUpScreen; // NeonButton
import 'package:inventor_desgin_studio/widgets/bottom_navigation.dart';
import 'package:inventor_desgin_studio/providers/auth_provider.dart';
import 'package:inventor_desgin_studio/providers/user_provider.dart';
import 'package:inventor_desgin_studio/screens/forget_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _remember = false;
  bool _obscure = true; // for eye icon toggle

  static const _bg = Colors.black;
  static const _field = Color(0xFF1E1E1E);
  static const _hint = Colors.grey;
  static const _neon = Color(0xFFD6FF23);

  @override
  void initState() {
    super.initState();
    _initializeAuth();
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  // Initialize authentication service
  Future<void> _initializeAuth() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    // Check if user is already authenticated
    if (authProvider.isAuthenticated) {
      _navigateToHome();
    }
  }

  // Navigate to home screen
  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const MainNavigation(),
      ),
    );
  }


  // Handle login
  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    final success = await authProvider.login(_emailCtrl.text.trim(), _passCtrl.text);

    if (success) {
      // Set user in user provider
      if (authProvider.user != null) {
        userProvider.setUser(authProvider.user!);
      }
      // Navigate to home screen
      _navigateToHome();
    }
    // Error handling is done by AuthProvider
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Logo
                const LogoAnimation(),

                const SizedBox(height: 8),

                // Error Message from Provider
                Consumer<AuthProvider>(
                  builder: (context, authProvider, child) {
                    if (authProvider.errorMessage != null) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red.withValues(alpha: 0.1),
                          border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          authProvider.errorMessage!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),

                // Welcome Back
                const Text(
                "Welcome Back",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 3),
              const Text(
                "Inventor Design Studio",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 28),

              // Email Field
              TextFormField(
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: _field,
                  hintText: "Email address",
                  hintStyle: const TextStyle(color: _hint),
                  prefixIcon: const Icon(Icons.email, color: _hint),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 14),

              // Password Field + Eye Toggle (clickable)
              TextFormField(
                controller: _passCtrl,
                obscureText: _obscure,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _handleLogin(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: _field,
                  hintText: "Password",
                  hintStyle: const TextStyle(color: _hint),
                  prefixIcon: const Icon(Icons.lock_outline, color: _hint),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscure ? Icons.visibility : Icons.visibility_off,
                      color: _hint,
                    ),
                    onPressed: () => setState(() => _obscure = !_obscure),
                    tooltip: _obscure ? "Show" : "Hide",
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 8),

              // Remember Me + Forgot Password (both clickable)
              Row(
                children: [
                  Checkbox(
                    value: _remember,
                    onChanged: (v) => setState(() => _remember = v ?? false),
                    activeColor: _neon,
                  ),
                  const Text("Remember me",
                      style: TextStyle(color: Colors.grey)),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ForgetPasswordScreen()),
                      );
                    },
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Color(0xFFD6FF23),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Sign In Button (your reusable component) — clickable
              Consumer<AuthProvider>(
                builder: (context, authProvider, child) {
                  return NeonButton(
                    label: "Sign In",
                    loading: authProvider.isLoading,
                    onPressed: _handleLogin,
                  );
                },
              ),

              const SizedBox(height: 16),

              // Sign Up link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Color(0xFFD6FF23), // replace with _neon if defined
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18), // 👈 Row ke baahar rakho


              // Divider "Or continue with"
              Row(
                children: const [
                  Expanded(child: Divider(color: Colors.white12)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Or continue with",
                      style: TextStyle(color: Colors.white60),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.white12)),
                ],
              ),
              const SizedBox(height: 12),

              // Social Buttons (clickable)
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Google sign in coming soon!'),
                            backgroundColor: Color(0xFFD6FF23),
                          ),
                        );
                      },
                      icon: const Icon(Icons.g_mobiledata, color: Colors.white),
                      label: const Text("Google",
                          style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _field,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Apple sign in coming soon!'),
                            backgroundColor: Color(0xFFD6FF23),
                          ),
                        );
                      },
                      icon: const Icon(Icons.apple, color: Colors.white),
                      label: const Text("Apple",
                          style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _field,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        ),
      ),
    );
  }
}
