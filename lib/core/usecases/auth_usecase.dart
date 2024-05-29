// core/usecases/auth_usecase.dart
import 'package:jual_rugi_app/core/domain/model/user_model.dart';

abstract class AuthUseCase {
  Future<UserModel> loginWithEmail(String email, String password);
  Future<UserModel> registerWithEmail(String username, String email, String password);
  Future<bool> verifyOtp(String code);
}
