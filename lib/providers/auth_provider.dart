import 'package:flutter/material.dart';
import 'package:inventor_desgin_studio/models/user_model.dart';
import 'package:inventor_desgin_studio/services/auth_service.dart';
import 'package:inventor_desgin_studio/services/api_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();

  User? _user;
  bool _isLoading = false;
  String? _errorMessage;
  bool _isInitialized = false;

  // Getters
  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _authService.isAuthenticated;
  bool get isInitialized => _isInitialized;

  // Initialize auth provider
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      await _authService.initialize();
      _user = _authService.currentUser;
      _isInitialized = true;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to initialize authentication: ${e.toString()}';
      notifyListeners();
    }
  }

  // Login
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _authService.login(email, password);
      _user = response.user;
      _isLoading = false;
      notifyListeners();
      return true;
    } on ApiException catch (e) {
      _errorMessage = e.message;
      _isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      _errorMessage = 'Login failed: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Register
  Future<bool> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? phone,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _authService.register(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        phone: phone,
      );
      _user = response.user;
      _isLoading = false;
      notifyListeners();
      return true;
    } on ApiException catch (e) {
      _errorMessage = e.message;
      _isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      _errorMessage = 'Registration failed: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Logout
  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _authService.logout();
      _user = null;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Logout failed: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Refresh user profile
  Future<void> refreshUserProfile() async {
    try {
      _user = await _authService.getUserProfile();
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to refresh profile: ${e.toString()}';
      notifyListeners();
    }
  }

  // Update user profile
  Future<bool> updateUserProfile(Map<String, dynamic> updates) async {
    try {
      _user = await _authService.updateUserProfile(updates);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Failed to update profile: ${e.toString()}';
      notifyListeners();
      return false;
    }
  }

  // Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Show loading
  void showLoading([String? message]) {
    _isLoading = true;
    notifyListeners();
  }

  // Hide loading
  void hideLoading() {
    _isLoading = false;
    notifyListeners();
  }

  // Check if user needs re-authentication
  bool needsReauthentication() {
    return _authService.needsReauthentication();
  }

  // Ensure valid token
  Future<void> ensureValidToken() async {
    try {
      await _authService.ensureValidToken();
    } catch (e) {
      _errorMessage = 'Session expired. Please login again.';
      notifyListeners();
    }
  }
}