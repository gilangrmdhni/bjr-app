import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jual_rugi_app/core/domain/model/product.dart';
import 'package:jual_rugi_app/presentation/views/product_detail_view.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    print('Building ProductCard for Product ID: ${product.id}');
    NumberFormat currencyFormat =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');
    int rating = Random().nextInt(2) + 3;

    return Card(
      margin: EdgeInsets.all(6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(
          color: Colors.grey.withOpacity(0.5),
          width: 1.0,
        ),
      ),
      child: InkWell(
        onTap: () {
          Get.to(() => ProductDetailView(productId: product.id.toString()));
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            double cardHeight = constraints.maxWidth * 0.8;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: cardHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.5),
                      width: 1.0,
                    ),
                  ),
                  child: Image.network(
                    buildFullImageUrl(product.images[0].filePath),
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.category.name.toString(),
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      Container(
                        child: Text(
                          product.name.toString(),
                          maxLines:
                              1, // Sesuaikan dengan jumlah baris yang diinginkan
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(height: 2),
                      // Ganti properti dari price menjadi originalPrice
                      Text(
                        '${currencyFormat.format(product.discountPrice)}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 2),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '${(product.discount * 100).toInt()}%',
                              style: TextStyle(color: Colors.red, fontSize: 12),
                            ),
                          ),
                          SizedBox(width: 4),
                          Text(
                            '${currencyFormat.format(product.originalPrice)}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
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
                            "Jakarta Selatan",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2),
                      Container(
                        height: 0.5,
                        color: Colors.grey,
                        margin: EdgeInsets.symmetric(vertical: 6),
                      ),
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
                              width:
                                  8), // Add some spacing between stars and text
                          Text(
                            '$rating.0', // Display the rating here
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  String buildFullImageUrl(String filePath) {
    final String BASE_URL = "https://api.bjr-dev.nuncorp.id/ms/api/v1/static";
    return BASE_URL + filePath;
  }
}
