import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:inventor_desgin_studio/button_components/logo.dart';
import 'package:inventor_desgin_studio/providers/auth_provider.dart';
import 'package:inventor_desgin_studio/services/otp_service.dart';

class OtpScreen extends StatefulWidget {
  final String purpose; // 'mobile_access' or 'website_portal'
  
  const OtpScreen({
    super.key,
    this.purpose = 'mobile_access',
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _otpControllers = List.generate(
    6, 
    (index) => TextEditingController(),
  );
  
  final List<FocusNode> _focusNodes = List.generate(
    6, 
    (index) => FocusNode(),
  );
  
  final OtpService _otpService = OtpService();

  bool _otpGenerated = false;
  String? _successMessage;

  static const _bg = Colors.black;
  static const _field = Color(0xFF1E1E1E);
  static const _neon = Color(0xFFD6FF23);

  @override
  void initState() {
    super.initState();
    _generateOtp();
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  // Generate OTP based on purpose
  Future<void> _generateOtp() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    if (!authProvider.isAuthenticated) {
      _showError('Please login first to generate OTP');
      return;
    }

    authProvider.showLoading('Generating OTP...');

    try {
      if (widget.purpose == 'website_portal') {
        // Generate OTP for website portal access
        final response = await _otpService.generateWebsiteOtp(authProvider.user!.id);
        _showSuccess('OTP generated for website portal access. Use this code on the website: ${response.otpCode}');
      } else {
        // Generate OTP for mobile access
        await _otpService.generateMobileOtp(authProvider.user!.id);
        _showSuccess('OTP sent to your registered device. Please enter it below.');
      }

      setState(() {
        _otpGenerated = true;
      });
    } catch (e) {
      _showError('Failed to generate OTP: ${e.toString()}');
    } finally {
      authProvider.hideLoading();
    }
  }

  // Validate OTP
  Future<void> _validateOtp() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final otpCode = _otpControllers.map((controller) => controller.text).join();

    if (otpCode.length != 6) {
      _showError('Please enter complete 6-digit OTP');
      return;
    }

    authProvider.showLoading('Validating OTP...');

    try {
      await _otpService.validateMobileOtp(authProvider.user!.id, otpCode);

      _showSuccess('OTP validated successfully!');

      // Navigate back or to next screen
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          Navigator.pop(context, true); // Return true to indicate success
        }
      });
    } catch (e) {
      _showError('Invalid OTP. Please try again.');
      _clearOtpFields();
    } finally {
      authProvider.hideLoading();
    }
  }

  // Clear OTP fields
  void _clearOtpFields() {
    for (var controller in _otpControllers) {
      controller.clear();
    }
    _focusNodes[0].requestFocus();
  }

  // Show error message
  void _showError(String message) {
    // Error will be handled by UI using Consumer
  }

  // Show success message
  void _showSuccess(String message) {
    setState(() {
      _successMessage = message;
    });
  }

  // Handle OTP field changes
  void _onOtpChanged(int index, String value) {
    if (value.isNotEmpty) {
      if (index < 5) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
        // Auto-validate when all fields are filled
        final otpCode = _otpControllers.map((controller) => controller.text).join();
        if (otpCode.length == 6) {
          _validateOtp();
        }
      }
    } else if (index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.purpose == 'website_portal' ? 'Website Portal OTP' : 'Secure Access',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Logo
              const LogoAnimation(),
              
              const SizedBox(height: 32),

              // Title
              Text(
                widget.purpose == 'website_portal' 
                  ? 'Generate OTP for Website Access'
                  : 'Enter OTP for Secure Access',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              const SizedBox(height: 16),

              // Description
              Text(
                widget.purpose == 'website_portal'
                  ? 'Generate a secure OTP code to access your account on the website portal.'
                  : 'Enter the 6-digit OTP code sent to your registered device.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 32),

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

              // Success Message
              if (_successMessage != null)
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.1),
                    border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _successMessage!,
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

              // OTP Fields
              if (widget.purpose == 'mobile_access' && _otpGenerated)
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(6, (index) {
                        return SizedBox(
                          width: 45,
                          height: 55,
                          child: TextFormField(
                            controller: _otpControllers[index],
                            focusNode: _focusNodes[index],
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: InputDecoration(
                              counterText: '',
                              filled: true,
                              fillColor: _field,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: _neon, width: 2),
                              ),
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            onChanged: (value) => _onOtpChanged(index, value),
                          ),
                        );
                      }),
                    ),
                    
                    const SizedBox(height: 24),

                    // Validate Button
                    Consumer<AuthProvider>(
                      builder: (context, authProvider, child) {
                        return SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: authProvider.isLoading ? null : _validateOtp,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _neon,
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: authProvider.isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.black,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  'Validate OTP',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                          ),
                        );
                      },
                    ),
                  ],
                ),

              const SizedBox(height: 24),

              // Generate OTP Button
              Consumer<AuthProvider>(
                builder: (context, authProvider, child) {
                  return SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: authProvider.isLoading ? null : _generateOtp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _field,
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: _neon),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: authProvider.isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: _neon,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            _otpGenerated ? 'Regenerate OTP' : 'Generate OTP',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 16),

              // Clear OTP Button (only for mobile access)
              if (widget.purpose == 'mobile_access')
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: TextButton(
                    onPressed: _clearOtpFields,
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.grey,
                    ),
                    child: const Text(
                      'Clear OTP',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),

              const SizedBox(height: 32),

              // Info Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _field.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _neon.withValues(alpha: 0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Security Information:',
                      style: TextStyle(
                        color: _neon,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.purpose == 'website_portal'
                        ? '• This OTP is valid for 5 minutes\n• Use this code on the website portal\n• The code will expire after use'
                        : '• OTP is sent to your registered device\n• Valid for 5 minutes\n• Enter all 6 digits to validate',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
