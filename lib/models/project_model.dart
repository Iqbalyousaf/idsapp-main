import 'package:flutter/material.dart';

class Project {
  final String id;
  final String title;
  final String? description;
  final String status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? icon; // Optional icon identifier

  const Project({
    required this.id,
    required this.title,
    this.description,
    required this.status,
    this.createdAt,
    this.updatedAt,
    this.icon,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    String? str(dynamic v) => v?.toString();
    DateTime? dt(dynamic v) {
      if (v == null) return null;
      if (v is DateTime) return v;
      final s = v.toString();
      return DateTime.tryParse(s);
    }

    return Project(
      id: str(json['id']) ?? '',
      title: str(json['title']) ?? '',
      description: str(json['description']),
      status: str(json['status']) ?? 'unknown',
      createdAt: dt(json['created_at'] ?? json['createdAt']),
      updatedAt: dt(json['updated_at'] ?? json['updatedAt']),
      icon: str(json['icon']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'status': status,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'icon': icon,
      };

  // Helper method to get status color
  Color getStatusColor() {
    switch (status.toLowerCase()) {
      case 'completed':
        return const Color(0xFF4ADE80);
      case 'progress':
      case 'in_progress':
        return const Color(0xFF63E6FF);
      case 'review':
        return const Color(0xFFFFC857);
      default:
        return const Color(0xFF9CA3AF);
    }
  }

  // Helper method to get status icon
  IconData getStatusIcon() {
    switch (status.toLowerCase()) {
      case 'completed':
        return Icons.check_circle_outline;
      case 'progress':
      case 'in_progress':
        return Icons.access_time;
      case 'review':
        return Icons.visibility_outlined;
      default:
        return Icons.help_outline;
    }
  }

  // Helper method to get time ago string
  String getTimeAgo() {
    if (updatedAt == null) return '';
    final now = DateTime.now();
    final difference = now.difference(updatedAt!);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }
}