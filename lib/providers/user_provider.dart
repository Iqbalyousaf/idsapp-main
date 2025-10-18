import 'package:flutter/material.dart';
import 'package:inventor_desgin_studio/models/user_model.dart';
import 'package:inventor_desgin_studio/services/auth_service.dart';

class UserProvider with ChangeNotifier {
  final AuthService _authService = AuthService();

  User? _user;
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _authService.isAuthenticated;

  // Initialize user data
  Future<void> initializeUser() async {
    if (_user != null) return;

    _isLoading = true;
    notifyListeners();

    try {
      _user = await _authService.getUserProfile();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Failed to load user profile: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Set user (when login/register happens)
  void setUser(User user) {
    _user = user;
    _errorMessage = null;
    notifyListeners();
  }

  // Clear user (on logout)
  void clearUser() {
    _user = null;
    _errorMessage = null;
    notifyListeners();
  }

  // Refresh user profile
  Future<void> refreshProfile() async {
    if (_isLoading) return; // Prevent multiple simultaneous refreshes

    _isLoading = true;
    notifyListeners();

    try {
      _user = await _authService.getUserProfile();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Failed to refresh profile: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Update user profile
  Future<bool> updateProfile(Map<String, dynamic> updates) async {
    if (_isLoading) return false; // Prevent multiple simultaneous updates

    _isLoading = true;
    notifyListeners();

    try {
      _user = await _authService.updateUserProfile(updates);
      _errorMessage = null;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Failed to update profile: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Get user full name
  String get fullName => _user?.fullName ?? 'User';

  // Get user initials
  String get initials {
    if (_user == null) return 'U';
    final first = _user!.firstName?.characters.first ?? '';
    final last = _user!.lastName?.characters.first ?? '';
    return (first + last).toUpperCase();
  }

  // Get user role
  String get role => _user?.role ?? 'customer';

  // Get user email
  String? get email => _user?.email;

  // Get user first name
  String? get firstName => _user?.firstName;

  // Get user last name
  String? get lastName => _user?.lastName;

  // Get user phone
  String? get phone => _user?.phone;

  // Get user creation date
  DateTime? get createdAt => _user?.createdAt;

  // Get user last login
  DateTime? get lastLogin => _user?.lastLogin;

  // Get email verification status
  bool get emailVerified => _user?.emailVerified ?? false;

  // Clear error
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}