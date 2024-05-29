// import 'package:get_storage/get_storage.dart';
// import 'package:jual_rugi_app/core/domain/models/product.dart';

// class WishlistRepository {
//   final box = GetStorage();

//   // Mendapatkan wishlist dari penyimpanan lokal
//   List<Product> getWishlist() {
//     final List<dynamic>? wishlistData = box.read('wishlist');
//     if (wishlistData != null) {
//       return wishlistData.map((data) => Product.fromJson(data)).toList();
//     } else {
//       return [];
//     }
//   }         

//   // Menyimpan wishlist ke penyimpanan lokal
//   void saveWishlist(List<Product> wishlist) {
//     final List<Map<String, dynamic>> wishlistData =
//         wishlist.map((product) => product.toJson()).toList();
//     box.write('wishlist', wishlistData);
//   }

//   // Menambahkan produk ke wishlist
//   void addToWishlist(Product product) {
//     final List<Product> wishlist = getWishlist();
//     wishlist.add(product);
//     saveWishlist(wishlist);
//   }

//   // Menghapus produk dari wishlist
//   void removeFromWishlist(Product product) {
//     final List<Product> wishlist = getWishlist();
//     wishlist.removeWhere((element) => element.id == product.id);
//     saveWishlist(wishlist);
//   }
// }
