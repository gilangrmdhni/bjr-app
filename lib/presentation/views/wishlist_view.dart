import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jual_rugi_app/core/domain/model/wishlist_product_model.dart';
import 'package:jual_rugi_app/presentation/controllers/wishlist_controller.dart';
import 'package:jual_rugi_app/presentation/views/widgets/group.wishlist.dart';
import 'package:money_formatter/money_formatter.dart';

class WishlistView extends StatelessWidget {
  final WishlistController wishlistController = Get.put(WishlistController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Wishlist',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                height: 48, // Atur tinggi sesuai kebutuhan
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search on Wishlist',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey.withOpacity(0.5),
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey.withOpacity(0.5),
                        width: 1.0,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 8), // Atur padding vertikal
                  ),
                ),
              ),
            ),
            GroupWishlist(),
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Semua Barang Barangmu',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: wishlistController.wishlistProducts.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 180 / 300,
              ),
              itemBuilder: (context, index) {
                var product = wishlistController.wishlistProducts[index];
                return _buildProductCard(product);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(WishlistProduct product) {
    MoneyFormatterOutput discountPrice = MoneyFormatter(
      amount: product.discountPrice.toDouble(),
      settings: MoneyFormatterSettings(
        symbol: 'Rp ',
        thousandSeparator: '.',
        decimalSeparator: ',',
        symbolAndNumberSeparator: ' ',
        fractionDigits: 0,
      ),
    ).output;

    MoneyFormatterOutput originalPrice = MoneyFormatter(
      amount: product.originalPrice.toDouble(),
      settings: MoneyFormatterSettings(
        symbol: 'Rp ',
        thousandSeparator: '.',
        decimalSeparator: ',',
        symbolAndNumberSeparator: ' ',
        fractionDigits: 0,
      ),
    ).output;
    double rating = product.rating;

    return SizedBox(
      width: 170,
      height: 300,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: BorderSide(
            color: Colors.grey.withOpacity(0.5),
            width: 1.0,
          ),
        ),
        child: Column(
          // padding: const EdgeInsets.all(12.0),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    product.images.first,
                    fit:
                        BoxFit.cover, // Gambar sesuai rasio aspek dan di tengah
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${product.category}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${discountPrice.symbolOnLeft}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      // color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 2),
                  Row(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '${product.discount}%',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        '${originalPrice.symbolOnLeft}',
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.grey,
                        size: 16,
                      ),
                      SizedBox(width: 2),
                      Text(
                        product.location,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Divider(height: 1, color: Colors.grey),
                  SizedBox(height: 2),
                  Row(
                    children: [
                      ...List.generate(
                        5,
                        (index) => Icon(
                          index < rating ? Icons.star : Icons.star_border,
                          color: Colors.yellow,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ), // Add some spacing between stars and text
                      Text(
                        '${rating.toStringAsFixed(1)}', // Menggunakan method toStringAsFixed() untuk membulatkan menjadi bilangan dengan 1 angka di belakang koma
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
