import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:inventor_desgin_studio/button_components/logo.dart';
import 'package:inventor_desgin_studio/screens/login_screen.dart';
import 'package:inventor_desgin_studio/widgets/bottom_navigation.dart';
import 'package:inventor_desgin_studio/providers/auth_provider.dart';
import 'package:inventor_desgin_studio/providers/user_provider.dart';
import 'package:inventor_desgin_studio/providers/app_provider.dart';

void main() => runApp(const InventorApp());

class InventorApp extends StatelessWidget {
  const InventorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => AppProvider()),
      ],
      child: MaterialApp(
        title: 'Inventor Studio',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: const Color(0xFF0B0D10),
          useMaterial3: true,
        ),
        home: const SignUpScreen(),
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                                Sign Up Screen                              */
/* -------------------------------------------------------------------------- */

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Colors
  static const neon = Color(0xFFD6FF23);
  static const panel = Color(0xFF14181F);
  static const field = Color(0xFF1A2029);
  static const hint = Color(0xFF8A93A3);

  // Controllers
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _pass = TextEditingController();
  final _confirm = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // State
  bool _obscure = true;
  bool _agreeTos = false;
  bool _subscribe = true;

  // Password rules
  // Password rules
  bool get _ruleLength => _pass.text.length >= 8;

  bool get _ruleUpperLower =>
      RegExp(r'(?=.*[a-z])(?=.*[A-Z])').hasMatch(_pass.text);

  bool get _ruleNumber =>
      RegExp(r'(?=.*\d)').hasMatch(_pass.text);

// ✅ FIXED: use raw triple quotes so both ' and " can appear safely
  bool get _ruleSymbol =>
      RegExp(r'''(?=.*[!@#\$%^&*()_\-+=\[\{\]};:'",<.>\/?\\|`~])''')
          .hasMatch(_pass.text);

  bool get _passwordsMatch =>
      _pass.text.isNotEmpty && _pass.text == _confirm.text;

  bool get _canSubmit =>
      _firstName.text.trim().isNotEmpty &&
      _lastName.text.trim().isNotEmpty &&
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(_email.text.trim()) &&
      _ruleLength &&
      _ruleUpperLower &&
      _ruleNumber &&
      _ruleSymbol &&
      _passwordsMatch &&
      _agreeTos;

  @override
  void initState() {
    super.initState();
    _initializeAuth();
  }

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _email.dispose();
    _phone.dispose();
    _pass.dispose();
    _confirm.dispose();
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


  // Handle sign up
  Future<void> _handleSignUp() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_canSubmit) return;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    final success = await authProvider.register(
      email: _email.text.trim(),
      password: _pass.text,
      firstName: _firstName.text.trim(),
      lastName: _lastName.text.trim(),
      phone: _phone.text.trim().isNotEmpty ? _phone.text.trim() : null,
    );

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


  InputDecoration _dec({
    required String hintText,
    required IconData icon,
    Widget? suffix,
  }) {
    return InputDecoration(
      filled: true,
      fillColor: field,
      hintText: hintText,
      hintStyle: const TextStyle(color: hint),
      prefixIcon: Icon(icon, color: hint),
      suffixIcon: suffix,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Top App Row (mini brand bar + icons)

                    const SizedBox(height: 18),

                    // Neon logo square
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


                  const SizedBox(height: 18),

                  // Headings
                  Center(
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'Join ',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                          TextSpan(
                            text: 'Inventor Studio',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: neon,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Create stunning designs with our powerful mobile design tools and collaborative features',
                    style: TextStyle(color: Colors.white70),
                  ),

                  const SizedBox(height: 16),

                  // Step indicator row
                  Row(
                    children: [
                      const Text('Step 1 of 3',
                          style: TextStyle(color: Colors.white60)),
                      const Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Account Setup',
                            style: TextStyle(color: neon)),
                      ),
                    ],
                  ),

                  // Form Panel
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: panel,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text('First Name',
                            style: TextStyle(color: Colors.white70)),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _firstName,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your first name';
                            }
                            return null;
                          },
                          decoration: _dec(
                            hintText: 'Enter your first name',
                            icon: Icons.person_outline,
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 12),
                        const Text('Last Name',
                            style: TextStyle(color: Colors.white70)),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _lastName,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your last name';
                            }
                            return null;
                          },
                          decoration: _dec(
                            hintText: 'Enter your last name',
                            icon: Icons.person_outline,
                          ),
                        ),
                        const SizedBox(height: 14),

                        const Text('Email Address',
                            style: TextStyle(color: Colors.white70)),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _email,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                          decoration: _dec(
                            hintText: 'Enter your email',
                            icon: Icons.alternate_email,
                          ),
                        ),
                        const SizedBox(height: 14),

                        const Text('Phone Number (Optional)',
                            style: TextStyle(color: Colors.white70)),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _phone,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          decoration: _dec(
                            hintText: 'Enter your phone number',
                            icon: Icons.phone_outlined,
                          ),
                        ),
                        const SizedBox(height: 14),

                        const Text('Password',
                            style: TextStyle(color: Colors.white70)),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _pass,
                          obscureText: _obscure,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            }
                            if (value.length < 8) {
                              return 'Password must be at least 8 characters';
                            }
                            if (!RegExp(r'(?=.*[a-z])(?=.*[A-Z])').hasMatch(value)) {
                              return 'Password must contain uppercase and lowercase letters';
                            }
                            if (!RegExp(r'(?=.*\d)').hasMatch(value)) {
                              return 'Password must contain at least one number';
                            }
                            if (!RegExp(r'''(?=.*[!@#\$%^&*()_\-+=\[\{\]};:'",<.>\/?\\|`~])''').hasMatch(value)) {
                              return 'Password must contain at least one special character';
                            }
                            return null;
                          },
                          decoration: _dec(
                            hintText: 'Create a strong password',
                            icon: Icons.lock_outline,
                            suffix: IconButton(
                              tooltip: _obscure ? 'Show' : 'Hide',
                              icon: Icon(
                                _obscure ? Icons.visibility : Icons.visibility_off,
                                color: hint,
                              ),
                              onPressed: () =>
                                  setState(() => _obscure = !_obscure),
                            ),
                          ),
                        ),

                        // Rules checklist
                        const SizedBox(height: 10),
                        _RuleRow(
                          ok: _ruleLength,
                          text: 'At least 8 characters',
                        ),
                        _RuleRow(
                          ok: _ruleUpperLower,
                          text: 'Include uppercase & lowercase',
                        ),
                        _RuleRow(
                          ok: _ruleNumber,
                          text: 'Include numbers',
                        ),
                        _RuleRow(
                          ok: _ruleSymbol,
                          text: 'Include symbols',
                        ),

                        const SizedBox(height: 14),

                        const Text('Confirm Password',
                            style: TextStyle(color: Colors.white70)),
                        const SizedBox(height: 6),
                        TextField(
                          controller: _confirm,
                          obscureText: true,
                          decoration: _dec(
                            hintText: 'Confirm your password',
                            icon: Icons.verified_user_outlined,
                          ),
                        ),

                        const SizedBox(height: 12),

                        // TOS
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: _agreeTos,
                              onChanged: (v) => setState(() => _agreeTos = v ?? false),
                              activeColor: neon,
                            ),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  style: const TextStyle(color: Colors.white70),
                                  children: [
                                    const TextSpan(text: 'I agree to the '),
                                    TextSpan(
                                      text: 'Terms of Service',
                                      style: const TextStyle(
                                          color: neon, fontWeight: FontWeight.w600),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          // open tos
                                        },
                                    ),
                                    const TextSpan(text: ' and '),
                                    TextSpan(
                                      text: 'Privacy Policy',
                                      style: const TextStyle(
                                          color: neon, fontWeight: FontWeight.w600),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          // open privacy
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Subscribe
                        Row(
                          children: [
                            Checkbox(
                              value: _subscribe,
                              onChanged: (v) => setState(() => _subscribe = v ?? false),
                              activeColor: neon,
                            ),
                            const Expanded(
                              child: Text(
                                'Send me updates about new features and design resources',
                                style: TextStyle(color: Colors.white70),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        // Create Account button (reusable)
                        Consumer<AuthProvider>(
                          builder: (context, authProvider, child) {
                            return NeonButton(
                              label: 'Create Account',
                              loading: authProvider.isLoading,
                              enabled: _canSubmit,
                              onPressed: !_canSubmit ? null : _handleSignUp,
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Or continue with
                  Row(
                    children: const [
                      Expanded(child: Divider(color: Colors.white12)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text('Or continue with',
                            style: TextStyle(color: Colors.white60)),
                      ),
                      Expanded(child: Divider(color: Colors.white12)),
                    ],
                  ),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: _SocialButton(
                          icon: Icons.g_mobiledata,
                          label: 'Google',
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _SocialButton(
                          icon: Icons.apple,
                          label: 'Apple',
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Sign in link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?  ',
                          style: TextStyle(color: Colors.white70)),
                      TextButton(
                        onPressed:  () {
                          Navigator.push(context,MaterialPageRoute(builder: (context) => const LoginScreen(),),);
                        },
                        child: const Text(
                          'Sign in',
                          style: TextStyle(
                            color: neon,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            ),
          ),
        ),
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                                   Widgets                                  */
/* -------------------------------------------------------------------------- */

class _RuleRow extends StatelessWidget {
  final bool ok;
  final String text;
  const _RuleRow({required this.ok, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          ok ? Icons.check_circle : Icons.cancel,
          size: 18,
          color: ok ? const Color(0xFF6BFF6B) : const Color(0xFFFF5A5A),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            color: ok ? Colors.white70 : Colors.white60,
          ),
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, color: Colors.white),
        label: Text(label, style: const TextStyle(color: Colors.white)),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1A2029),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}

/// Reusable neon CTA (gradient + loading + enabled/disabled)
class NeonButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool loading;
  final bool enabled;

  const NeonButton({
    super.key,
    required this.label,
    this.onPressed,
    this.loading = false,
    this.enabled = true,
  });

  static const neon1 = Color(0xFFD6FF23);
  static const neon2 = Color(0xFFC6FF00);

  @override
  Widget build(BuildContext context) {
    final canTap = enabled && !loading && onPressed != null;

    return SizedBox(
      height: 54,
      child: InkWell(
        onTap: canTap ? onPressed : null,
        borderRadius: BorderRadius.circular(14),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: canTap
                ? const LinearGradient(
              colors: [neon1, neon2],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            )
                : const LinearGradient(
              colors: [Color(0xFF2A2F38), Color(0xFF2A2F38)],
            ),
            boxShadow: canTap
                ? const [
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: 18,
                offset: Offset(0, 8),
              ),
            ]
                : null,
          ),
          child: Center(
            child: loading
                ? const SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(Colors.black),
              ),
            )
                : Text(
              label,
              style: TextStyle(
                color: canTap ? Colors.black : Colors.white38,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
