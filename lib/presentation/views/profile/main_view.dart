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
              'Profil Akunmu',
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
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            AssetImage('assets/images/content/user.png'),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextButton(
                              onPressed: () {
                                if (authController.currentUser.value == null) {
                                  Get.toNamed('/login_view');
                                } else {
                                  // Additional action if needed
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
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Iconsax.edit_2, color: Colors.black),
                        onPressed: () {
                          // Edit action
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildInfoCard(
                        context,
                        icon: Iconsax.coin,
                        label: 'Point',
                        value: '56.000',
                      ),
                      _buildInfoCard(
                        context,
                        icon: Iconsax.wallet_2,
                        label: 'Saldo',
                        value: 'Rp. 156.000',
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      if (authController.currentUser.value == null) {
                        Get.toNamed('/login_view');
                      } else {
                        UserModel user = authController.currentUser.value!;
                        if (user.isStore) {
                          Get.toNamed('/store_view');
                        } else {
                          Get.toNamed('/store_name_input');
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey.shade300,
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
                  _buildSectionTitle('Setting Akun'),
                  buildMenuItem(Iconsax.profile_circle, 'Akun saya', () {
                    Get.toNamed('/my_account_view');
                  }, true),
                  buildMenuItem(Iconsax.location, 'Alamat Pengiriman', () {
                     Get.toNamed('/ship_address_view');
                  }, true),
                  buildMenuItem(Iconsax.call, 'Nomor Telepon', () {
                    // Navigate to phone settings
                  }, true),
                  buildMenuItem(Iconsax.directbox_default, 'E-mail', () {
                    // Navigate to email settings
                  }, true),
                  buildMenuItem(Iconsax.receipt_edit, 'Pengaturan Pembayaran',
                      () {
                    // Navigate to payment settings
                  }, true),
                  buildMenuItem(Iconsax.receipt, 'Rekening Bank', () {
                    // Navigate to bank settings
                  }, true),
                  Divider(color: Colors.grey, height: 2),
                  SizedBox(height: 16),
                  _buildSectionTitle('Etalase'),
                  buildMenuItem(Iconsax.money, 'Transaksi Penjualan', () {
                    // Navigate to sales transactions
                  }, true),
                  buildMenuItem(Icons.format_list_bulleted_add, 'Tambah Barang',
                      () {
                    // Navigate to add item
                  }, true),
                  buildMenuItem(Icons.format_list_numbered, 'Barang Dijual',
                      () {
                    // Navigate to items for sale
                  }, true),
                  buildMenuItem(Iconsax.directbox_default, 'Tidak Dijual', () {
                    // Navigate to not for sale items
                  }, true),
                  buildMenuItem(Icons.archive_outlined, 'Draft', () {
                    // Navigate to drafts
                  }, true),
                  Divider(color: Colors.grey, height: 2),
                  SizedBox(height: 16),
                  buildMenuItems(Iconsax.logout, 'Sign Out', () {
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

  Widget _buildInfoCard(BuildContext context,
      {required IconData icon, required String label, required String value}) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.grey.shade600, size: 24),
                SizedBox(width: 8),
                Text(label,
                    style:
                        TextStyle(fontSize: 16, color: Colors.grey.shade600)),
              ],
            ),
            SizedBox(height: 8),
            Text(value,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(left: 8.0),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }

  Widget buildMenuItem(
      IconData icon, String label, Function onTap, bool hasArrow) {
    return ListTile(
      leading: Icon(icon, size: 28, color: Colors.grey),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(fontSize: 18, color: Colors.grey.shade600)),
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
        style: TextStyle(fontSize: 18, color: Colors.red),
      ),
      onTap: onTap as void Function()?,
    );
  }
}
