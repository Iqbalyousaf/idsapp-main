class User {
  final String id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String role;
  final String? profileImageUrl;
  final bool emailVerified;
  final DateTime? createdAt;
  final DateTime? lastLogin;

  const User({
    required this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.phone,
    this.role = 'customer',
    this.profileImageUrl,
    this.emailVerified = false,
    this.createdAt,
    this.lastLogin,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    // Accept both snake_case and camelCase keys safely
    String? str(dynamic v) => v?.toString();
    DateTime? dt(dynamic v) {
      if (v == null) return null;
      if (v is DateTime) return v;
      final s = v.toString();
      return DateTime.tryParse(s);
    }

    return User(
      id: str(json['id']) ?? '',
      email: str(json['email']),
      firstName: str(json['first_name'] ?? json['firstName']),
      lastName: str(json['last_name'] ?? json['lastName']),
      phone: str(json['phone']),
      role: str(json['role']) ?? 'customer',
      profileImageUrl: str(json['profile_image_url'] ?? json['profileImageUrl']),
      emailVerified: (json['email_verified'] ?? json['emailVerified'] ?? false) == true,
      createdAt: dt(json['created_at'] ?? json['createdAt']),
      lastLogin: dt(json['last_login'] ?? json['lastLogin']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'phone': phone,
        'role': role,
        'profile_image_url': profileImageUrl,
        'email_verified': emailVerified,
        'created_at': createdAt?.toIso8601String(),
        'last_login': lastLogin?.toIso8601String(),
      };

  String get fullName => [firstName, lastName].where((e) => (e ?? '').isNotEmpty).join(' ');
}

class AuthResponse {
  final String? message;
  final User user;
  final String token;
  final String sessionToken;
  final String? expiresIn;

  const AuthResponse({
    this.message,
    required this.user,
    required this.token,
    required this.sessionToken,
    this.expiresIn,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    final data = json;
    final userJson = (data['user'] is Map) ? data['user'] as Map<String, dynamic> : data;

    String pickToken(Map<String, dynamic> j) =>
        (j['token'] ?? j['jwt'] ?? j['access_token'] ?? '').toString();
    String pickSession(Map<String, dynamic> j) =>
        (j['session_token'] ?? j['sessionToken'] ?? j['session'] ?? '').toString();
    String? pickExpires(Map<String, dynamic> j) {
      final v = j['expires_in'] ?? j['expiresIn'];
      return v?.toString();
    }

    return AuthResponse(
      message: data['message']?.toString(),
      user: User.fromJson(userJson),
      token: pickToken(data),
      sessionToken: pickSession(data),
      expiresIn: pickExpires(data),
    );
  }
}

class LoginRequest {
  final String email;
  final String password;
  final String deviceToken;
  final String deviceType;

  const LoginRequest({
    required this.email,
    required this.password,
    required this.deviceToken,
    required this.deviceType,
  });

  Map<String, dynamic> toJson() => {
        // Use camelCase per API docs
        'email': email,
        'password': password,
        'deviceToken': deviceToken,
        'deviceType': deviceType,
      };
}

class RegisterRequest {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String? phone;
  final String deviceToken;
  final String deviceType;

  const RegisterRequest({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    this.phone,
    required this.deviceToken,
    required this.deviceType,
  });

  Map<String, dynamic> toJson() => {
        // Use camelCase per API docs
        'email': email,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
        if (phone != null) 'phone': phone,
        'deviceToken': deviceToken,
        'deviceType': deviceType,
      };
}

class ApiError {
  final String message;
  final String error;
  final int statusCode;

  const ApiError({
    required this.message,
    required this.error,
    required this.statusCode,
  });

  factory ApiError.fromJson(Map<String, dynamic> json) => ApiError(
        message: (json['message'] ?? 'Unknown error').toString(),
        error: (json['error'] ?? 'UNKNOWN_ERROR').toString(),
        statusCode: int.tryParse((json['statusCode'] ?? json['status'] ?? 400).toString()) ?? 400,
      );
}

class OtpRequest {
  final String userId;
  final String deviceToken;
  final String type;

  const OtpRequest({
    required this.userId,
    required this.deviceToken,
    this.type = 'mobile_app_login',
  });

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'deviceToken': deviceToken,
        'type': type,
      };
}

class OtpResponse {
  final String message;
  final String otpCode;
  final DateTime? expiresAt;

  const OtpResponse({
    required this.message,
    required this.otpCode,
    this.expiresAt,
  });

  factory OtpResponse.fromJson(Map<String, dynamic> json) {
    DateTime? dt(dynamic v) => v == null ? null : DateTime.tryParse(v.toString());
    return OtpResponse(
      message: (json['message'] ?? 'OK').toString(),
      otpCode: (json['otp_code'] ?? json['otpCode'] ?? '').toString(),
      expiresAt: dt(json['expires_at'] ?? json['expiresAt']),
    );
  }
}
