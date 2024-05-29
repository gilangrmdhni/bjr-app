import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import 'package:jual_rugi_app/presentation/views/utils/navigation_controller.dart';
import 'package:jual_rugi_app/presentation/controllers/auth_controller.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final NavigationController controller = Get.find();
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: (index) {
            if (index != 1 && index != 3) {
              // For other icons, directly change the page based on the index
              controller.changePage(index);
            } else {
              // For Wishlist (index == 1) and Transaksi (index == 3)
              // Check if the user is logged in
              if (authController.currentUser.value == null) {
                // If not logged in, navigate to the login page
                Get.toNamed('/login_view');
              } else {
                // If logged in, navigate to the respective pages
                if (index == 1) {
                  Get.toNamed('/wishlist_view');
                } else if (index == 3) {
                  Get.toNamed('/transaksi_view');
                }
              }
            }
          },
          type: BottomNavigationBarType.fixed,
          items: [
            _buildBottomNavigationBarItem(Iconsax.home, 'Beranda'),
            _buildBottomNavigationBarItem(Iconsax.shopping_bag, 'Wishlist'),
            _buildSpecialBottomNavigationBarItem(Iconsax.add_circle, 'Jual'),
            _buildBottomNavigationBarItem(Iconsax.receipt_item, 'Transaksi'),
            _buildBottomNavigationBarItem(Iconsax.profile_circle, 'Akun'),
          ],
        ));
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
    IconData icon,
    String label,
  ) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }

  BottomNavigationBarItem _buildSpecialBottomNavigationBarItem(
    IconData icon,
    String label,
  ) {
    return BottomNavigationBarItem(
      icon: SizedBox(
        width: 50.0,
        height: 46.0,
        child: Icon(
          icon,
          color:
              controller.selectedIndex.value == 2 ? Colors.blue : Colors.blue,
          size: 44.0,
        ),
      ),
      label: label,
    );
  }
}
