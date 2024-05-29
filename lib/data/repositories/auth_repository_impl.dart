// data/repositories/auth_repository_impl.dart
import 'package:jual_rugi_app/core/domain/model/user_model.dart';
import 'package:jual_rugi_app/data/datasource/auth_remote_data_source.dart';
import 'package:jual_rugi_app/data/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<UserModel> loginWithEmail(String email, String password) async {
    try {
      final UserModel user =
          await authRemoteDataSource.loginWithEmail(email, password);
      return user;
    } catch (e) {
      print('Error during login: $e');
      throw Exception('Failed to login. Check your network connection.');
    }
  }

  @override
  Future<UserModel> registerWithEmail(String username, String email, String password) async {
    try {
      final UserModel user =
          await authRemoteDataSource.registerWithEmail(username, email, password);
      return user;
    } catch (e) {
      print('Error during registration: $e');
      throw Exception('Failed to register. Check your network connection.');
    }
  }

  @override
  Future<bool> verifyOtp(String code) async {
    try {
      final bool isVerified = await authRemoteDataSource.verifyOtp(code);
      return isVerified;
    } catch (e) {
      print('Error during OTP verification: $e');
      throw Exception('Failed to verify OTP. Check your network connection.');
    }
  }
}
