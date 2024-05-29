// register_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jual_rugi_app/presentation/controllers/auth_controller.dart';

class RegisterView extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2191FF),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Registrasi',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFF2191FF),
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Silahkan Registrasi untuk melanjutkan aktifitasmu',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
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
                    SizedBox(height: 16),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
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
                    SizedBox(height: 16),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
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
                    SizedBox(height: 16),
                    TextField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
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
                    Spacer(),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () async {
                          final result = await authController.register(
                            usernameController.text,
                            emailController.text,
                            passwordController.text,
                          );

                          if (result) {
                            Get.offNamed('/otp_view');
                          } else {
                            Get.snackbar(
                              'Registrasi Gagal',
                              'Gagal melakukan registrasi.',
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
                          'Daftar',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    SizedBox(height: 4),
                    Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          Get.toNamed('/login_view');
                        },
                        child: Text('Sudah punya akun? Login di sini'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
