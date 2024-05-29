import 'package:flutter/material.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<CategoryItem> categories = [
      CategoryItem(icon: Icons.grid_view, title: 'Lihat Semua', onTap: () {}),
      CategoryItem(icon: Icons.local_offer, title: 'Fashion', onTap: () {}),
      CategoryItem(icon: Icons.shopping_bag, title: 'Furniture', onTap: () {}),
      CategoryItem(icon: Icons.account_balance_wallet, title: 'Otomotif', onTap: () {}),
      CategoryItem(icon: Icons.star, title: 'Gadget', onTap: () {}),
    ];

    return SizedBox(
      height: 80,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          final category = categories[index];
          return Container(
            width: 90, // Adjusted width for better visibility
            margin: const EdgeInsets.symmetric(horizontal: 2),
            child: VerticalIconText(
              icon: category.icon,
              title: category.title,
              onTap: category.onTap,
            ),
          );
        },
      ),
    );
  }
}

class CategoryItem {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  CategoryItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });
}

class VerticalIconText extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const VerticalIconText({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blue, // Warna latar belakang ikon
              borderRadius: BorderRadius.circular(16), // Menyesuaikan dengan tinggi ikon
            ),
            padding: const EdgeInsets.all(10),
            child: Icon(icon, size: 36, color: Colors.white), // Warna ikon putih
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11),
          ),
        ],
      ),
    );
  }
}

