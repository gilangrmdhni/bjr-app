import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jual_rugi_app/data/repositories/product_repository.dart';
import 'package:jual_rugi_app/presentation/controllers/auth_controller.dart';
import 'package:jual_rugi_app/presentation/views/transaction/cart_view.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double iconSize =
            constraints.maxWidth * 0.065; // Sesuaikan dengan kebutuhan
        double titleSize =
            constraints.maxWidth * 0.05; // Sesuaikan dengan kebutuhan

        return AppBar(
          title: Container(
            padding: EdgeInsets.symmetric(
                horizontal: 8), // Sesuaikan dengan kebutuhan
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  color: Colors.grey.shade800,
                ),
                SizedBox(width: 4),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Cari di BJR',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(
                Icons.forum_outlined,
                size: iconSize,
                color: Colors.grey.shade800,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.notifications_outlined,
                size: iconSize,
                color: Colors.grey.shade800,
              ),
              onPressed: () {
                Get.toNamed('/notification'); // Navigate to the login screen
              },
            ),
            IconButton(
              icon: Icon(
                Icons.shopping_cart,
                size: iconSize,
                color: Colors.grey.shade800,
              ),
              onPressed: () {
                // Aksi ketika ikon keranjang belanja ditekan
                if (authController.currentUser.value == null) {
                  // Navigasi ke halaman login jika pengguna belum login
                  Get.toNamed('/login_view');
                } else {
                  // Navigasi ke halaman CartView jika pengguna sudah login
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartView(
                        productRepository:
                            ProductRepositoryImpl(), // Ganti dengan instance repository Anda
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
