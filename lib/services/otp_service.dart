import 'package:inventor_desgin_studio/models/user_model.dart';
import 'package:inventor_desgin_studio/services/api_service.dart';

class OtpService {
  static final OtpService _instance = OtpService._internal();
  factory OtpService() => _instance;
  OtpService._internal();

  final ApiService _apiService = ApiService();

  // Generate OTP for mobile app access
  Future<OtpResponse> generateMobileOtp(String userId) async {
    try {
      final response = await _apiService.generateOtp(userId);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Validate OTP for mobile app access
  Future<Map<String, dynamic>> validateMobileOtp(String userId, String otpCode) async {
    try {
      final response = await _apiService.validateOtp(userId, otpCode);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Generate OTP for website portal access (when user wants to access website)
  Future<OtpResponse> generateWebsiteOtp(String userId) async {
    try {
      // This would be a special OTP for website access
      // The website would use this OTP to authenticate the user
      final request = OtpRequest(
        userId: userId,
        deviceToken: _apiService.deviceToken ?? 'website_otp',
        type: 'website_portal_access',
      );

      final response = await _apiService.makeRequest(
        '/generate-website-otp',
        method: 'POST',
        body: request.toJson(),
        requireAuth: true,
      );

      return OtpResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  // Check OTP status (valid, expired, etc.)
  Future<Map<String, dynamic>> checkOtpStatus(String userId, String otpCode) async {
    try {
      final request = {
        'user_id': userId,
        'otp_code': otpCode,
      };

      final response = await _apiService.makeRequest(
        '/check-otp-status',
        method: 'POST',
        body: request,
        requireAuth: true,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Get OTP history for user
  Future<List<Map<String, dynamic>>> getOtpHistory(String userId) async {
    try {
      final response = await _apiService.makeRequest('/otp-history/$userId', requireAuth: true);
      return List<Map<String, dynamic>>.from(response['otp_history'] ?? []);
    } catch (e) {
      rethrow;
    }
  }

  // Clear expired OTPs
  Future<void> clearExpiredOtps(String userId) async {
    try {
      await _apiService.makeRequest(
        '/clear-expired-otps',
        method: 'POST',
        body: {'user_id': userId},
        requireAuth: true,
      );
    } catch (e) {
      rethrow;
    }
  }

  // Generate secure OTP for sensitive operations
  Future<OtpResponse> generateSecureOtp(String userId, String operation) async {
    try {
      final request = {
        'user_id': userId,
        'operation': operation,
        'device_token': _apiService.deviceToken ?? 'secure_operation',
        'type': 'secure_operation',
      };

      final response = await _apiService.makeRequest(
        '/generate-secure-otp',
        method: 'POST',
        body: request,
        requireAuth: true,
      );

      return OtpResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  // Validate secure OTP
  Future<Map<String, dynamic>> validateSecureOtp(
    String userId, 
    String otpCode, 
    String operation
  ) async {
    try {
      final request = {
        'user_id': userId,
        'otp_code': otpCode,
        'operation': operation,
      };

      final response = await _apiService.makeRequest(
        '/validate-secure-otp',
        method: 'POST',
        body: request,
        requireAuth: true,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
