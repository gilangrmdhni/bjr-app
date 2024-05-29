import 'dart:math';

import 'package:get/get.dart';
import 'package:jual_rugi_app/core/domain/model/wishlist_product_model.dart';

class WishlistController extends GetxController {
  // Daftar produk keinginan
  var wishlistProducts = <WishlistProduct>[
    WishlistProduct(
      name: 'NIKE AIR JORDAN 1',
      originalPrice: 1075000,
      discountPrice: 8600000,
      discount: 20,
      category: 'Fashion',
      location: 'Jakarta Barat',
      images: [
        'assets/images/products/NikeAirJordonSingleOrange.png',
        'assets/images/products/NikeAirJordonSingleOrange.png',
      ],
      rating: Random().nextDouble() * 5,
    ),
    WishlistProduct(
      name: 'Iphone 12 64gb Blue',
      originalPrice: 8749000,
      discountPrice: 6999200,
      discount: 20,
      category: 'Teknologi',
      location: 'Jakarta Selatan',
      images: [
        'assets/images/products/iphone_12_blue.png',
        'assets/images/products/iphone_12_blue.png',
      ],
      rating: Random().nextDouble() * 5,
    ),
    WishlistProduct(
      name: 'Iphone 12 64gb Blue',
      originalPrice: 8749000,
      discountPrice: 6999200,
      discount: 20,
      category: 'Teknologi',
      location: 'Jakarta Selatan',
      images: [
        'assets/images/products/iphone_12_blue.png',
        'assets/images/products/iphone_12_blue.png',
      ],
      rating: Random().nextDouble() * 5,
    ),

    WishlistProduct(
      name: 'Iphone 12 64gb Blue',
      originalPrice: 8749000,
      discountPrice: 6999200,
      discount: 20,
      category: 'Teknologi',
      location: 'Jakarta Selatan',
      images: [
        'assets/images/products/iphone_12_blue.png',
        'assets/images/products/iphone_12_blue.png',
      ],
      rating: Random().nextDouble() * 5,
    ),

    // Tambahkan data produk lainnya di sini
  ].obs;
}
