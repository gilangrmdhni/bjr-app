// data/repositories/auth_repository.dart
import 'package:jual_rugi_app/core/domain/model/user_model.dart';

abstract class AuthRepository {
  Future<UserModel> loginWithEmail(String email, String password);
  Future<UserModel> registerWithEmail(String username, String email, String password);
  Future<bool> verifyOtp(String code);
}