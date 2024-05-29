import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jual_rugi_app/app_routes.dart';
import 'package:jual_rugi_app/presentation/controllers/auth_controller.dart';

class LoginView extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            'Login',
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Selamat Datang Kembali!, Login untuk melanjutkan',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 22),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        fillColor: Colors.white,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1.5,
                            color: Colors.blue,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    SizedBox(
                        height:
                            22), // Mengurangi jarak antara input email dan password
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        fillColor: Colors.white,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1.5,
                            color: Colors.blue,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    SizedBox(
                        height:
                            8), // Mengurangi jarak antara input password dan teks Lupa Password
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          // Tambahkan aksi untuk tautan "Lupa Password" di sini
                        },
                        child: Text('Lupa Password?'),
                      ),
                    ),

                    SizedBox(height: 24),
                    Spacer(), // Menambahkan spacer agar tombol login paling bawah
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_validateInput()) {
                            final result = await authController.login(
                              emailController.text,
                              passwordController.text,
                            );

                            if (result) {
                              Get.offAllNamed(AppRoutes.home);
                            } else {
                              Get.snackbar(
                                'Login Gagal',
                                'Email atau password salah.',
                                snackPosition: SnackPosition.BOTTOM,
                                colorText: Colors.white,
                                backgroundColor: Colors.red,
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(450, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          // Tambahkan aksi navigasi ke halaman registrasi di sini
                          Get.toNamed('/register_view');
                        },
                        child: Text('Belum Punya Akun? Daftar Di Sini'),
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _validateInput() {
    if (emailController.text.isEmpty ||
        !GetUtils.isEmail(emailController.text)) {
      Get.snackbar(
        'Input Invalid',
        'Masukkan email yang valid.',
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
      print('Invalid email input: ${emailController.text}');
      return false;
    }

    if (passwordController.text.isEmpty) {
      Get.snackbar(
        'Input Invalid',
        'Masukkan password.',
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
      print('Invalid password input: ${passwordController.text}');
      return false;
    }

    return true;
  }
}
