// presentation/controllers/auth_controller.dart
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:jual_rugi_app/core/domain/model/user_model.dart';
import 'package:jual_rugi_app/core/usecases/auth_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final AuthUseCase authUseCase;

  AuthController({required this.authUseCase});

  Rx<UserModel?> currentUser = Rx<UserModel?>(null);

  Future<bool> login(String email, String password) async {
    try {
      UserModel user = await authUseCase.loginWithEmail(email, password);
      currentUser.value = user;
      // Lakukan sesuatu dengan data pengguna (contoh: simpan ke penyimpanan lokal)
      return true;
    } catch (e) {
      print('Login failed: $e');
      return false;
    }
  }

  Future<bool> register(String username, String email, String password) async {
    try {
      UserModel user =
          await authUseCase.registerWithEmail(username, email, password);
      currentUser.value = user;

      // Lakukan sesuatu dengan data pengguna (contoh: simpan ke penyimpanan lokal)
      return true;
    } catch (e) {
      if (e is DioError) {
        print('Registration failed - DioError: ${e.message}');
      } else if (e is SocketException) {
        print('Registration failed - SocketException: ${e.message}');
      } else {
        print('Registration failed: $e');
      }

      return false;
    }
  }

  Future<bool> verifyOtp(String code) async {
    try {
      bool isVerified = await authUseCase.verifyOtp(code);
      if (isVerified) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('OTP verification failed: $e');
      return false;
    }
  }

  void logout() async {
    try {
      // Hapus token dari penyimpanan lokal (SharedPreferences atau storage yang digunakan)
      await _clearToken();

      // Reset state atau data pengguna yang perlu direset
      currentUser.value = null;

      // Navigasi ke halaman login (atau halaman lain yang sesuai)
      Get.offAllNamed('/');
    } catch (e) {
      print('Logout failed: $e');
    }
  }

// Metode untuk menghapus token dari penyimpanan lokal
  Future<void> _clearToken() async {
    try {
      // Ambil instance dari SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Hapus token dari SharedPreferences
      await prefs.remove('token');
      print('Token removed from SharedPreferences.');
    } catch (e) {
      print('Failed to clear token: $e');
      // Handle kesalahan jika diperlukan
    }
  }
}
