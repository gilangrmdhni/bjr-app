// core/domain/user_model.dart
class UserModel {
  final String username;
  final String email;
  final String role;
  final bool isLocked;
  final bool isEmailValidated;
  final String createdAt;
  final String updatedAt;
  final dynamic profile;
  final bool isStore;

  UserModel({
    required this.username,
    required this.email,
    required this.role,
    required this.isLocked,
    required this.isEmailValidated,
    required this.createdAt,
    required this.updatedAt,
    required this.profile,
    required this.isStore,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'],
      email: json['email'],
      role: json['role'],
      isLocked: json['is_locked'],
      isEmailValidated: json['is_email_validated'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      isStore: json['is_store'] ?? false,
      profile: json['profile'] ?? null,
    );
  }
}
