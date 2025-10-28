import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:inventor_desgin_studio/models/user_model.dart';
import 'package:inventor_desgin_studio/models/project_model.dart';

class ApiService {
  static const String _baseUrl = 'https://inventerdesignstudio.com/api/mobile';
  static const String _apiSecurityToken = 'inventor-design-studio-api-2024-secure';
  
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();
  final Connectivity _connectivity = Connectivity();
  
  String? _jwtToken;
  String? _sessionToken;
  String? _deviceToken;

  // Getters
  String? get jwtToken => _jwtToken;
  String? get sessionToken => _sessionToken;
  String? get deviceToken => _deviceToken;
  bool get isAuthenticated => _jwtToken != null;

  // Initialize device token
  Future<void> initializeDeviceToken() async {
    _deviceToken ??= await _generateDeviceToken();
  }

  // Generate unique device token
  Future<String> _generateDeviceToken() async {
    try {
      if (Platform.isAndroid) {
        final androidInfo = await _deviceInfo.androidInfo;
        return 'android_${androidInfo.id}_${DateTime.now().millisecondsSinceEpoch}';
      } else if (Platform.isIOS) {
        final iosInfo = await _deviceInfo.iosInfo;
        return 'ios_${iosInfo.identifierForVendor}_${DateTime.now().millisecondsSinceEpoch}';
      }
    } catch (e) {
      debugPrint('Error generating device token: $e');
    }
    return 'unknown_${DateTime.now().millisecondsSinceEpoch}';
  }

  // Check network connectivity
  Future<bool> _checkConnectivity() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  // Get common headers
  Map<String, String> _getHeaders({bool includeAuth = true}) {
    final headers = {
      'Content-Type': 'application/json',
      'X-API-Security-Token': _apiSecurityToken,
      'User-Agent': 'InventorDesignStudio-Mobile/1.0',
    };

    if (_deviceToken != null) {
      headers['X-Device-Token'] = _deviceToken!;
    }

    if (Platform.isIOS) {
      headers['X-Platform'] = 'ios';
    } else if (Platform.isAndroid) {
      headers['X-Platform'] = 'android';
    }

    if (includeAuth && _jwtToken != null) {
      headers['Authorization'] = 'Bearer $_jwtToken';
    }

    return headers;
  }

  // Make API request
  Future<Map<String, dynamic>> makeRequest(
    String endpoint, {
    String method = 'GET',
    Map<String, dynamic>? body,
    bool requireAuth = true,
  }) async {
    // Check connectivity
    if (!await _checkConnectivity()) {
      throw ApiException('No internet connection', 'NETWORK_ERROR');
    }

    final url = Uri.parse('$_baseUrl$endpoint');
    final headers = _getHeaders(includeAuth: requireAuth);

    try {
      http.Response response;

      switch (method.toUpperCase()) {
        case 'POST':
          response = await http.post(
            url,
            headers: headers,
            body: body != null ? jsonEncode(body) : null,
          );
          break;
        case 'PUT':
          response = await http.put(
            url,
            headers: headers,
            body: body != null ? jsonEncode(body) : null,
          );
          break;
        case 'DELETE':
          response = await http.delete(url, headers: headers);
          break;
        default:
          response = await http.get(url, headers: headers);
      }

      final dynamic decoded = jsonDecode(response.body);
      final Map<String, dynamic> responseData =
          decoded is Map<String, dynamic> ? decoded : <String, dynamic>{'data': decoded};

      // Handle rate limiting
      if (response.statusCode == 429) {
        final retryAfter = response.headers['retry-after'];
        throw ApiException(
          'Rate limit exceeded. Please try again later.',
          'RATE_LIMIT_EXCEEDED',
          statusCode: 429,
          retryAfter: retryAfter,
        );
      }

      // Handle token expiration
      if (response.statusCode == 401 && requireAuth) {
        final error = responseData['error'];
        if (error == 'TOKEN_EXPIRED') {
          throw ApiException('Token expired', 'TOKEN_EXPIRED', statusCode: 401);
        }
        throw ApiException(
          'Authentication required',
          'AUTHENTICATION_REQUIRED',
          statusCode: 401,
        );
      }

      if (!response.statusCode.toString().startsWith('2')) {
        final error = ApiError.fromJson(responseData);
        throw ApiException(
          error.message,
          error.error,
          statusCode: error.statusCode,
        );
      }

      return responseData;
    } on SocketException {
      throw ApiException('Network error', 'NETWORK_ERROR');
    } on FormatException {
      throw ApiException('Invalid response format', 'INVALID_RESPONSE');
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Unexpected error: ${e.toString()}', 'UNKNOWN_ERROR');
    }
  }

  // Authentication methods
  Future<AuthResponse> login(String email, String password) async {
    await initializeDeviceToken();
    
    final request = LoginRequest(
      email: email,
      password: password,
      deviceToken: _deviceToken!,
      deviceType: Platform.isIOS ? 'ios' : 'android',
    );

    final response = await makeRequest(
      '/auth/login',
      method: 'POST',
      body: request.toJson(),
      requireAuth: false,
    );

    final authResponse = AuthResponse.fromJson(response);
    _jwtToken = authResponse.token;
    _sessionToken = authResponse.sessionToken;
    
    return authResponse;
  }

  Future<AuthResponse> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? phone,
  }) async {
    await initializeDeviceToken();
    
    final request = RegisterRequest(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      deviceToken: _deviceToken!,
      deviceType: Platform.isIOS ? 'ios' : 'android',
    );

    final response = await makeRequest(
      '/auth/register',
      method: 'POST',
      body: request.toJson(),
      requireAuth: false,
    );

    final authResponse = AuthResponse.fromJson(response);
    _jwtToken = authResponse.token;
    _sessionToken = authResponse.sessionToken;
    
    return authResponse;
  }

  Future<AuthResponse> refreshToken() async {
    if (_jwtToken == null) {
      throw ApiException('No token to refresh', 'NO_TOKEN');
    }

    final response = await makeRequest('/refresh-token', method: 'POST');
    final authResponse = AuthResponse.fromJson(response);
    _jwtToken = authResponse.token;
    _sessionToken = authResponse.sessionToken;
    
    return authResponse;
  }

  Future<void> logout() async {
    if (_jwtToken != null) {
      try {
        await makeRequest('/logout', method: 'POST');
      } catch (e) {
        // Continue with logout even if API call fails
        debugPrint('Logout API call failed: $e');
      }
    }
    
    _jwtToken = null;
    _sessionToken = null;
  }

  // OTP methods
  Future<OtpResponse> generateOtp(String userId) async {
    await initializeDeviceToken();
    
    final request = OtpRequest(
      userId: userId,
      deviceToken: _deviceToken!,
    );

    final response = await makeRequest(
      '/generate-otp',
      method: 'POST',
      body: request.toJson(),
    );

    return OtpResponse.fromJson(response);
  }

  Future<Map<String, dynamic>> validateOtp(String userId, String otpCode) async {
    await initializeDeviceToken();
    
    final request = {
      'user_id': userId,
      'device_token': _deviceToken,
      'otp_code': otpCode,
    };

    return await makeRequest(
      '/validate-otp',
      method: 'POST',
      body: request,
    );
  }

  // User profile methods
  Future<User> getUserProfile() async {
    final response = await makeRequest('/user-profile');
    return User.fromJson(response);
  }

  Future<User> updateUserProfile(Map<String, dynamic> updates) async {
    final response = await makeRequest(
      '/user-profile',
      method: 'PUT',
      body: updates,
    );
    return User.fromJson(response);
  }

  // Session validation
  Future<bool> validateSession() async {
    if (_jwtToken == null || _sessionToken == null || _deviceToken == null) {
      return false;
    }

    try {
      final request = {
        'user_id': _jwtToken, // You might want to store user ID separately
        'device_token': _deviceToken,
        'session_token': _sessionToken,
      };

      await makeRequest('/validate-session', method: 'POST', body: request);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Set tokens (for restoring from storage)
  void setTokens(String? jwtToken, String? sessionToken, String? deviceToken) {
    _jwtToken = jwtToken;
    _sessionToken = sessionToken;
    _deviceToken = deviceToken;
  }

  // Clear all tokens
  void clearTokens() {
    _jwtToken = null;
    _sessionToken = null;
    _deviceToken = null;
  }

  // Projects methods
  Future<List<Project>> getUserProjects({int limit = 10, int offset = 0}) async {
    final response = await makeRequest(
      '/user/projects?limit=$limit&offset=$offset',
      method: 'GET',
    );

    final data = response['data'] ?? response;
    if (data is List) {
      return data.map((item) => Project.fromJson(item as Map<String, dynamic>)).toList();
    }
    return [];
  }

  Future<Project> createProject(Map<String, dynamic> projectData) async {
    final response = await makeRequest(
      '/projects',
      method: 'POST',
      body: projectData,
    );

    return Project.fromJson(response);
  }

  Future<Project> updateProject(String projectId, Map<String, dynamic> updates) async {
    final response = await makeRequest(
      '/projects/$projectId',
      method: 'PUT',
      body: updates,
    );

    return Project.fromJson(response);
  }

  Future<void> deleteProject(String projectId) async {
    await makeRequest(
      '/projects/$projectId',
      method: 'DELETE',
    );
  }

  // Stats methods
  Future<Map<String, dynamic>> getUserStats() async {
    final response = await makeRequest('/user/stats');
    return response;
  }
}

// Custom exception class
class ApiException implements Exception {
  final String message;
  final String error;
  final int? statusCode;
  final String? retryAfter;

  const ApiException(
    this.message,
    this.error, {
    this.statusCode,
    this.retryAfter,
  });

  @override
  String toString() => 'ApiException: $message ($error)';
}
