import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jual_rugi_app/core/domain/model/user_model.dart';
import 'package:jual_rugi_app/presentation/controllers/auth_controller.dart';

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (authController) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Profile Akunmu',
              style: TextStyle(color: Colors.grey.shade800),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            AssetImage('assets/images/content/user.png'),
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: () {
                              // Aksi ketika teks "Silahkan Login" ditekan
                              if (authController.currentUser.value == null) {
                                // Navigasi ke halaman login jika pengguna belum login
                                Get.toNamed('/login_view');
                              } else {
                                // Aksi lain yang ingin Anda lakukan ketika teks lainnya ditekan
                              }
                            },
                            child: Text(
                              authController.currentUser.value != null
                                  ? authController.currentUser.value!.username
                                  : 'Silahkan Login',
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            authController.currentUser.value != null
                                ? authController.currentUser.value!.email
                                : '',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(Iconsax.path, color: Colors.black),
                        onPressed: () {
                          // Aksi ketika tombol edit ditekan
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () async {
                      // Pengecekan status login
                      if (authController.currentUser.value == null) {
                        // Jika belum login, arahkan ke halaman login
                        Get.toNamed('/login_view');
                      } else {
                        // Ambil data user dari controller
                        UserModel user = authController.currentUser.value!;

                        // Log nilai isStore
                        print('Is Store: ${user.isStore}');

                        // Pengecekan apakah user memiliki toko
                        if (user.isStore) {
                          // Jika toko sudah dibuat, arahkan ke halaman store_view
                          Get.toNamed('/store_view');
                        } else {
                          // Jika toko belum dibuat, arahkan ke halaman store_name_input
                          Get.toNamed('/store_name_input');
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey.shade300,
                      padding: EdgeInsets.all(14),
                      minimumSize:
                          Size(double.infinity, 40), // Atur tinggi tombol
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(16), // Atur border radius
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Icon(
                            Iconsax.shop,
                            size: 24,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        Text(
                          'Mulai Jualan',
                          style: TextStyle(
                              fontSize: 18, color: Colors.grey.shade600),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                          color: Colors.grey.shade600,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 8.0), // Sesuaikan nilai padding sesuai kebutuhan
                    child: Text(
                      'Setting Akun',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  buildMenuItem(Iconsax.profile_circle, 'Akun Saya', () {
                    // Aksi untuk menavigasi ke layar pesanan
                  }, true),
                  buildMenuItem(Iconsax.location, 'Alamat pengiriman', () {
                    // Aksi untuk menavigasi ke layar daftar keinginan
                  }, true),
                  buildMenuItem(Iconsax.call, 'Nomor Telepon', () {
                    // Aksi untuk menavigasi ke layar saldo
                  }, true),
                  buildMenuItem(Iconsax.directbox_default, 'E-mail', () {
                    // Aksi untuk menavigasi ke layar alamat pengiriman
                  }, true),
                  buildMenuItem(Iconsax.receipt_edit, 'Pengaturan Pembayaran',
                      () {
                    // Aksi untuk menavigasi ke layar alamat pengiriman
                  }, true),
                  buildMenuItem(Iconsax.receipt_edit, 'Rekening Bank', () {
                    // Aksi untuk menavigasi ke layar alamat pengiriman
                  }, true),
                  Divider(
                    color: Colors.grey,
                    height: 2,
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 8.0), // Sesuaikan nilai padding sesuai kebutuhan
                    child: Text(
                      'Etalase',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  buildMenuItem(Iconsax.money, 'Transaksi Penjualan', () {
                    // Aksi untuk menavigasi ke layar pesanan
                  }, true), // Tambahkan parameter true pada item ini
                  buildMenuItem(Icons.format_list_bulleted_add, 'Tambah Barang',
                      () {
                    // Aksi untuk menavigasi ke layar daftar keinginan
                  }, true),
                  buildMenuItem(Icons.format_list_numbered, 'Barang Dijual',
                      () {
                    // Aksi untuk menavigasi ke layar saldo
                  }, true),
                  buildMenuItem(Iconsax.directbox_default, 'Tidak Dijual', () {
                    // Aksi untuk menavigasi ke layar alamat pengiriman
                  }, true),
                  buildMenuItem(Icons.archive_outlined, 'Draft', () {
                    // Aksi untuk menavigasi ke layar alamat pengiriman
                  }, true),
                  Divider(
                    color: Colors.grey,
                    height: 2,
                  ),
                  SizedBox(height: 16),
                  buildMenuItems(Iconsax.logout, 'Sign Out', () {
                    // Panggil fungsi logout pada AuthController
                    authController.logout();
                  }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildMenuItem(
      IconData icon, String label, Function onTap, bool hasArrow) {
    return ListTile(
      leading: Icon(icon, size: 28, color: Colors.grey),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
          ),
          if (hasArrow)
            Icon(Icons.arrow_forward_ios,
                size: 18, color: Colors.grey.shade600),
        ],
      ),
      onTap: onTap as void Function()?,
    );
  }

  Widget buildMenuItems(IconData icon, String label, Function onTap) {
    return ListTile(
      leading: Icon(icon, size: 28, color: Colors.red),
      title: Text(
        label,
        style: TextStyle(fontSize: 18, color: Colors.red), // Warna teks merah
      ),
      onTap: onTap as void Function()?,
    );
  }
}
