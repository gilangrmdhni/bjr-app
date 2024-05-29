import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jual_rugi_app/presentation/controllers/auth_controller.dart';

class AuthGuard extends StatelessWidget {
  final Widget child;

  AuthGuard({required this.child});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();

    return Obx(
      () {
        // Cek apakah pengguna sudah login
        if (authController.currentUser.value != null) {
          // Pengguna sudah login, izinkan akses ke halaman child
          return child;
        } else {
          // Pengguna belum login, arahkan ke halaman login
          Future.delayed(Duration.zero, () {
            Navigator.pushNamedAndRemoveUntil(context, '/login_view', (route) => false);
          });
          return SizedBox.shrink();
        }
      },
    );
  }
}
