// auth_usecase_impl.dart
import 'package:jual_rugi_app/core/domain/model/user_model.dart';
import 'package:jual_rugi_app/core/usecases/auth_usecase.dart';
import 'package:jual_rugi_app/data/repositories/auth_repository.dart';

class AuthUseCaseImpl implements AuthUseCase {
  final AuthRepository authRepository;

  AuthUseCaseImpl({required this.authRepository});

  @override
  Future<UserModel> loginWithEmail(String email, String password) {
    return authRepository.loginWithEmail(email, password);
  }

  @override
  Future<UserModel> registerWithEmail(String username, String email, String password) {
    return authRepository.registerWithEmail(username, email, password);
  }

  @override
  Future<bool> verifyOtp(String code) {
    return authRepository.verifyOtp(code);
  }
}
