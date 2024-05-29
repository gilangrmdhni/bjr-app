// data/datasource/auth_api.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jual_rugi_app/core/domain/model/user_model.dart';
import 'package:jual_rugi_app/data/datasource/auth_remote_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthApi implements AuthRemoteDataSource {
  final String apiUrl = 'https://api.bjr-dev.nuncorp.id/as/api/v1';

  @override
  Future<UserModel> loginWithEmail(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/auth/signin'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData['status']['code'] == 'AS-200000') {
          final Map<String, dynamic> body = responseData['body'];
          final UserModel user = UserModel.fromJson(body);

          // Simpan token ke SharedPreferences
          await _saveToken(response.headers['authorization']);

          return user;
        } else {
          throw Exception(
              'Failed to login. ${responseData['status']['message']}');
        }
      } else {
        print(
            'Error during login. Server returned status ${response.statusCode}');
        throw Exception('Failed to login. Invalid server response.');
      }
    } catch (e) {
      print('Error during login: $e');
      throw Exception('Failed to login. Check your network connection.');
    }
  }

  @override
  Future<UserModel> registerWithEmail(
      String username, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/auth/signup'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'email': email,
          'password': password,
        }),
      );

      print('Server response: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData['status']['code'] == 'AS-200000') {
          final Map<String, dynamic> body = responseData['body'];
          final UserModel user = UserModel.fromJson(body);

          // Simpan token ke SharedPreferences
          await _saveToken(response.headers['authorization']);

          return user;
        } else {
          throw Exception(
              'Failed to register. ${responseData['status']['message']}');
        }
      } else {
        throw Exception(
            'Failed to register. Server returned status ${response.statusCode}');
      }
    } catch (e) {
      print('Error during registration: $e');
      throw Exception('Failed to register. Check your network connection.');
    }
  }

  @override
  Future<bool> verifyOtp(String code) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token != null && token.split('.').length == 3) {
        // Tambahkan log untuk mencetak payload token sebelum pengiriman ke server
        final List<String> tokenParts = token.split('.');
        final String header = tokenParts[0];
        final String payload = tokenParts[1];
        final String signature = tokenParts[2];

        print('Token before verification - Payload: $payload');

        final response = await http.post(
          Uri.parse('$apiUrl/auth/verify-email'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': '$token',
          },
          body: jsonEncode(<String, String>{
            'code': code, // Ganti parameter dari 'otp' menjadi 'code'
          }),
        );

        print('Token before verification: $token');
        print('Server response (verifyOtp): ${response.body}');

        if (response.statusCode == 200) {
          return true; // Jika verifikasi berhasil
        } else {
          throw Exception('Failed to verify OTP. ${response.body}');
        }
      } else {
        throw Exception(
            'Token not found or invalid format. User not authenticated.');
      }
    } catch (e) {
      print('Error during OTP verification: $e');
      throw Exception('Failed to verify OTP. Check your network connection.');
    }
  }

  Future<bool> resendOtp(String email) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/auth/resend-otp'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'email': email,
        }),
      );

      print('Server response (resendOtp): ${response.body}');

      if (response.statusCode == 200) {
        return true; // Jika pengiriman OTP berhasil
      } else {
        throw Exception('Failed to resend OTP');
      }
    } catch (e) {
      print('Error during OTP resend: $e');
      throw Exception('Failed to resend OTP. Check your network connection.');
    }
  }

  Future<void> _saveToken(String? token) async {
    if (token != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', token);

      // Tambahkan log untuk memeriksa apakah token berhasil disimpan
      String? savedToken = prefs.getString('token');
      if (savedToken != null && savedToken.split('.').length == 3) {
        print('Token saved to SharedPreferences: $savedToken');
      } else {
        print('Failed to save token to SharedPreferences.');
      }
    }
  }

  Future<void> logout() async {
    try {
      // Hapus token dari SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('token');

      // Tambahkan tindakan tambahan logout sesuai kebutuhan aplikasi
      // misalnya, membersihkan state, mengarahkan pengguna, dll.
    } catch (e) {
      print('Error during logout: $e');
      throw Exception('Failed to logout. Check your network connection.');
    }
  }
}
