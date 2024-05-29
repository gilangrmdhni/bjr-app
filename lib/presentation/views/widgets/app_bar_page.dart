import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AppBarPage extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Tambah Product',
        style: TextStyle(color: Colors.grey.shade800),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      actions: [
        IconButton(
          icon: Icon(
            Icons.more_vert, // Replace with the desired icon (three dots)
            size: 24.0, // Adjust the size as needed
            color: Colors.grey.shade800,
          ),
          onPressed: () {
            // Add functionality for the more options icon here
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
