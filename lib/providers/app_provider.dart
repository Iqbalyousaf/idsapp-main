import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class AppProvider with ChangeNotifier {
  bool _isOnline = true;
  bool _isLoading = false;
  String? _loadingMessage;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;

  // Getters
  bool get isOnline => _isOnline;
  bool get isLoading => _isLoading;
  String? get loadingMessage => _loadingMessage;

  // Initialize app provider
  Future<void> initialize() async {
    // Check initial connectivity
    await _checkConnectivity();

    // Listen to connectivity changes
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((result) {
      _updateConnectivity(result);
    });
  }

  // Check connectivity
  Future<void> _checkConnectivity() async {
    try {
      final result = await _connectivity.checkConnectivity();
      _updateConnectivity(result);
    } catch (e) {
      _isOnline = false;
      notifyListeners();
    }
  }

  // Update connectivity status
  void _updateConnectivity(ConnectivityResult result) {
    final wasOnline = _isOnline;
    _isOnline = result != ConnectivityResult.none;

    // Notify only if status changed
    if (wasOnline != _isOnline) {
      notifyListeners();
    }
  }

  // Dispose method to clean up listeners
  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }

  // Show loading
  void showLoading([String? message]) {
    _isLoading = true;
    _loadingMessage = message;
    notifyListeners();
  }

  // Hide loading
  void hideLoading() {
    _isLoading = false;
    _loadingMessage = null;
    notifyListeners();
  }

  // Show global loading with message
  void setLoading(bool loading, [String? message]) {
    _isLoading = loading;
    _loadingMessage = message;
    notifyListeners();
  }

  // Refresh connectivity status
  Future<void> refreshConnectivity() async {
    await _checkConnectivity();
  }
}