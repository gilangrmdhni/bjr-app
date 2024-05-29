// data/datasource/auth_remote_data_source.dart

import 'package:jual_rugi_app/core/domain/model/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> loginWithEmail(String email, String password);
  Future<UserModel> registerWithEmail(String username, String email, String password);
  Future<bool> verifyOtp(String otp);
}