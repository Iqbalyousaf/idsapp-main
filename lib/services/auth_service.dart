import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:inventor_desgin_studio/models/user_model.dart';
import 'package:inventor_desgin_studio/services/api_service.dart';

class AuthService {
  static const String _tokenKey = 'jwt_token';
  static const String _sessionTokenKey = 'session_token';
  static const String _deviceTokenKey = 'device_token';
  static const String _userKey = 'user_data';
  static const String _biometricEnabledKey = 'biometric_enabled';
  static const String _rememberMeKey = 'remember_me';

  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  final ApiService _apiService = ApiService();
  
  User? _currentUser;
  bool _isInitialized = false;

  // Getters
  User? get currentUser => _currentUser;
  bool get isAuthenticated => _apiService.isAuthenticated && _currentUser != null;
  bool get isInitialized => _isInitialized;

  // Initialize auth service
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // Restore tokens from secure storage
      final jwtToken = await _secureStorage.read(key: _tokenKey);
      final sessionToken = await _secureStorage.read(key: _sessionTokenKey);
      final deviceToken = await _secureStorage.read(key: _deviceTokenKey);

      if (jwtToken != null && sessionToken != null) {
        _apiService.setTokens(jwtToken, sessionToken, deviceToken);

        // Validate session with server
        final isValid = await _apiService.validateSession();
        if (isValid) {
          // Restore user data
          await _restoreUserData();
        } else {
          // Clear invalid tokens
          await clearAuthData();
        }
      }

      _isInitialized = true;
    } catch (e) {
      debugPrint('Error initializing auth service: $e');
      await clearAuthData();
      _isInitialized = true;
    }
  }

  // Login with email and password
  Future<AuthResponse> login(String email, String password) async {
    try {
      final response = await _apiService.login(email, password);
      
      // Store tokens securely
      await _storeTokens(response.token, response.sessionToken);
      
      // Store user data
      _currentUser = response.user;
      await _storeUserData(response.user);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Register new user
  Future<AuthResponse> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? phone,
  }) async {
    try {
      final response = await _apiService.register(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        phone: phone,
      );
      
      // Store tokens securely
      await _storeTokens(response.token, response.sessionToken);
      
      // Store user data
      _currentUser = response.user;
      await _storeUserData(response.user);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      await _apiService.logout();
    } catch (e) {
      debugPrint('Logout API call failed: $e');
    } finally {
      await clearAuthData();
    }
  }

  // Generate OTP for secure access
  Future<OtpResponse> generateOtp() async {
    if (!isAuthenticated) {
      throw Exception('User must be authenticated to generate OTP');
    }
    
    return await _apiService.generateOtp(_currentUser!.id);
  }

  // Validate OTP
  Future<Map<String, dynamic>> validateOtp(String otpCode) async {
    if (!isAuthenticated) {
      throw Exception('User must be authenticated to validate OTP');
    }
    
    return await _apiService.validateOtp(_currentUser!.id, otpCode);
  }

  // Refresh token
  Future<void> refreshToken() async {
    try {
      final response = await _apiService.refreshToken();
      await _storeTokens(response.token, response.sessionToken);
      _currentUser = response.user;
      await _storeUserData(response.user);
    } catch (e) {
      // If refresh fails, clear auth data
      await clearAuthData();
      rethrow;
    }
  }

  // Get user profile
  Future<User> getUserProfile() async {
    final user = await _apiService.getUserProfile();
    _currentUser = user;
    await _storeUserData(user);
    return user;
  }

  // Update user profile
  Future<User> updateUserProfile(Map<String, dynamic> updates) async {
    final user = await _apiService.updateUserProfile(updates);
    _currentUser = user;
    await _storeUserData(user);
    return user;
  }

  // Biometric authentication
  Future<bool> isBiometricEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_biometricEnabledKey) ?? false;
  }

  Future<void> setBiometricEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_biometricEnabledKey, enabled);
  }

  // Remember me functionality
  Future<bool> getRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_rememberMeKey) ?? false;
  }

  Future<void> setRememberMe(bool remember) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_rememberMeKey, remember);
  }

  // Store tokens securely
  Future<void> _storeTokens(String jwtToken, String sessionToken) async {
    await Future.wait([
      _secureStorage.write(key: _tokenKey, value: jwtToken),
      _secureStorage.write(key: _sessionTokenKey, value: sessionToken),
      _secureStorage.write(key: _deviceTokenKey, value: _apiService.deviceToken),
    ]);
  }

  // Store user data
  Future<void> _storeUserData(User user) async {
    final userJson = jsonEncode(user.toJson());
    await _secureStorage.write(key: _userKey, value: userJson);
  }

  // Restore user data
  Future<void> _restoreUserData() async {
    try {
      final userJson = await _secureStorage.read(key: _userKey);
      if (userJson != null) {
        final userMap = jsonDecode(userJson) as Map<String, dynamic>;
        _currentUser = User.fromJson(userMap);
      }
    } catch (e) {
      debugPrint('Error restoring user data: $e');
      _currentUser = null;
    }
  }

  // Clear all authentication data
  Future<void> clearAuthData() async {
    _currentUser = null;
    _apiService.clearTokens();
    
    await Future.wait([
      _secureStorage.delete(key: _tokenKey),
      _secureStorage.delete(key: _sessionTokenKey),
      _secureStorage.delete(key: _deviceTokenKey),
      _secureStorage.delete(key: _userKey),
    ]);
  }

  // Check if user needs to re-authenticate
  bool needsReauthentication() {
    return !isAuthenticated || _currentUser == null;
  }

  // Get stored device token
  Future<String?> getStoredDeviceToken() async {
    return await _secureStorage.read(key: _deviceTokenKey);
  }

  // Update device token
  Future<void> updateDeviceToken(String newDeviceToken) async {
    await _secureStorage.write(key: _deviceTokenKey, value: newDeviceToken);
  }

  // Check if user has valid session
  Future<bool> hasValidSession() async {
    if (!isAuthenticated) return false;
    
    try {
      return await _apiService.validateSession();
    } catch (e) {
      return false;
    }
  }

  // Auto-refresh token if needed
  Future<void> ensureValidToken() async {
    if (!isAuthenticated) return;
    
    try {
      // Try to validate session first
      final isValid = await _apiService.validateSession();
      if (!isValid) {
        // Try to refresh token
        await refreshToken();
      }
    } catch (e) {
      // If validation and refresh fail, user needs to login again
      await clearAuthData();
      throw Exception('Session expired. Please login again.');
    }
  }
}
