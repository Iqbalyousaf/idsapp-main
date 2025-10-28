import 'package:flutter/material.dart';
import 'package:inventor_desgin_studio/models/project_model.dart';
import 'package:inventor_desgin_studio/services/api_service.dart';

class ProjectsProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Project> _projects = [];
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  List<Project> get projects => _projects;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasProjects => _projects.isNotEmpty;

  // Initialize projects data
  Future<void> initializeProjects() async {
    if (_projects.isNotEmpty) return;

    _isLoading = true;
    notifyListeners();

    try {
      _projects = await _apiService.getUserProjects(limit: 10);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Failed to load projects: ${e.toString()}';
      _projects = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Refresh projects
  Future<void> refreshProjects() async {
    if (_isLoading) return; // Prevent multiple simultaneous refreshes

    _isLoading = true;
    notifyListeners();

    try {
      _projects = await _apiService.getUserProjects(limit: 10);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Failed to refresh projects: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Create new project
  Future<bool> createProject(Map<String, dynamic> projectData) async {
    if (_isLoading) return false;

    _isLoading = true;
    notifyListeners();

    try {
      final newProject = await _apiService.createProject(projectData);
      _projects.insert(0, newProject); // Add to beginning of list
      _errorMessage = null;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Failed to create project: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Update project
  Future<bool> updateProject(String projectId, Map<String, dynamic> updates) async {
    if (_isLoading) return false;

    _isLoading = true;
    notifyListeners();

    try {
      final updatedProject = await _apiService.updateProject(projectId, updates);
      final index = _projects.indexWhere((p) => p.id == projectId);
      if (index != -1) {
        _projects[index] = updatedProject;
      }
      _errorMessage = null;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Failed to update project: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Delete project
  Future<bool> deleteProject(String projectId) async {
    if (_isLoading) return false;

    _isLoading = true;
    notifyListeners();

    try {
      await _apiService.deleteProject(projectId);
      _projects.removeWhere((p) => p.id == projectId);
      _errorMessage = null;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Failed to delete project: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Clear projects (on logout)
  void clearProjects() {
    _projects = [];
    _errorMessage = null;
    notifyListeners();
  }

  // Clear error
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}