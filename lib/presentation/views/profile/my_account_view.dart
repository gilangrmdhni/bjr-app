import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jual_rugi_app/core/domain/model/user_model.dart';
import 'package:jual_rugi_app/presentation/controllers/auth_controller.dart';

class MyAccountView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (authController) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Akun Saya',
              style: TextStyle(color: Colors.grey.shade800),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.grey.shade800),
              onPressed: () {
                Get.back();
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              AssetImage('assets/images/content/user.png'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Action to change profile photo
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Ganti Foto',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.blue,
                                ),
                              ),
                              Icon(
                                Iconsax.edit_2,
                                color: Colors.blue,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildSectionTitle('Info Profil'),
                  buildInfoRow(
                      'Username',
                      authController.currentUser.value?.username ??
                          'Charloteviolete20'),
                  SizedBox(height: 16),
                  _buildSectionTitle('Info Pribadi'),
                  buildInfoRow(
                      'Email',
                      authController.currentUser.value?.email ??
                          '*Belum di verifikasi'),
                  SizedBox(height: 12),
                  buildInfoRow('Nomor HP', '+62 85729067767'),
                  SizedBox(height: 12),
                  buildInfoRow('Jenis Kelamin', 'Wanita'),
                  SizedBox(height: 12),
                  buildInfoRow('Tanggal Lahir', '10 Oktober 2010'),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      onPrimary: Colors.red,
                      padding: EdgeInsets.all(14),
                      minimumSize: Size(double.infinity, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Icon(
                            Iconsax.shop_remove,
                            size: 24,
                            color: Colors.red,
                          ),
                        ),
                        Text(
                          'Tutup Toko',
                          style: TextStyle(fontSize: 18, color: Colors.red),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      authController.logout();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      onPrimary: Colors.red,
                      padding: EdgeInsets.all(14),
                      minimumSize: Size(double.infinity, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Icon(
                            Iconsax.logout,
                            size: 24,
                            color: Colors.red,
                          ),
                        ),
                        Text(
                          'Sign Out',
                          style: TextStyle(fontSize: 18, color: Colors.red),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: 4, // Set to the index of "Akun"
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Beranda',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border),
                label: 'Wishlist',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_circle_outline),
                label: 'Jual',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.assignment),
                label: 'Pesanan',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: 'Akun',
              ),
            ],
            onTap: (index) {
              // Handle bottom navigation item taps
              switch (index) {
                case 0:
                  Get.toNamed('/home_view');
                  break;
                case 1:
                  Get.toNamed('/wishlist_view');
                  break;
                case 2:
                  Get.toNamed('/sell_view');
                  break;
                case 3:
                  Get.toNamed('/orders_view');
                  break;
                case 4:
                  Get.toNamed('/my_account_view');
                  break;
              }
            },
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(left: 8.0, bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
