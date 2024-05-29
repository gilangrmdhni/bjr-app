// otp_verification_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jual_rugi_app/presentation/controllers/auth_controller.dart';

class OtpVerificationView extends StatelessWidget {
  final TextEditingController otpController = TextEditingController();
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Verifikasi Email',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: otpController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Masukkan OTP',
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 16,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1.5,
                        color: Colors.blue,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Center(
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          final result = await authController.verifyOtp(
                            otpController.text,
                          );
                          if (result) {
                            // Berhasil verifikasi OTP, navigasi ke halaman home
                            Get.offAllNamed('/');
                          } else {
                            // Gagal verifikasi OTP, tampilkan pesan kesalahan
                            Get.snackbar(
                              'Verifikasi Gagal',
                              'Gagal melakukan verifikasi OTP.',
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(450, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Verifikasi',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
