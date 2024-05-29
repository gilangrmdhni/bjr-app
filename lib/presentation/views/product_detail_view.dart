import 'dart:convert';
import 'dart:math';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jual_rugi_app/core/domain/model/product.dart';
import 'package:jual_rugi_app/core/domain/model/product_by_id.dart';
import 'package:jual_rugi_app/data/repositories/product_repository.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jual_rugi_app/presentation/views/widgets/product_reviews.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetailView extends StatefulWidget {
  final String productId;
  final ProductRepository productRepository = ProductRepositoryImpl();

  ProductDetailView({required this.productId});

  @override
  _ProductDetailViewState createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  bool isFavorite = false;
  int cartItemCount = 0;
  bool isDescriptionExpanded = false;
  int rating = Random().nextInt(2) + 3;
  List<String> cartItems = [];
  List<ProductById> products = [];

  @override
  void initState() {
    super.initState();
    loadCartItems();
    loadProductDetails();
  }

  Future<void> loadCartItems() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? storedItems = prefs.getStringList('cart');
      setState(() {
        cartItems = storedItems ?? [];
      });
    } catch (e) {
      print('Error loading cart items: $e');
    }
  }

  Future<void> loadProductDetails() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? storedItems = prefs.getStringList('cart');

      if (storedItems != null && storedItems.isNotEmpty) {
        List<ProductById> loadedProducts = [];

        for (String productId in storedItems) {
          ProductById? product =
              await widget.productRepository.getProductById(productId);
          if (product != null) {
            loadedProducts.add(product);
          }
        }

        setState(() {
          products = loadedProducts;
        });
      }
    } catch (e) {
      print('Error loading product details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Produk Detail',
          style: TextStyle(color: Colors.grey.shade800),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            // Tambahkan fungsi navigasi kembali ketika tombol panah kembali ditekan
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Iconsax.heart,
              size: 24.0,
              color: Colors.grey.shade800,
            ),
            onPressed: () {
              // Tambahkan fungsionalitas untuk ikon opsi lebih banyak di sini
            },
          ),
        ],
      ),
      body: FutureBuilder<ProductById>(
        future: widget.productRepository.getProductById(widget.productId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            ProductById product = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          buildFullImageUrl(product.images[0].filePath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      product.category.name,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      product.name,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      formatCurrency(product.discountPrice.toDouble()),
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                            '${(product.discount * 100).toInt()}%',
                            style: TextStyle(color: Colors.red, fontSize: 13),
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          formatCurrency(product.originalPrice.toDouble()),
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Divider(
                      color: Colors.grey[400],
                      height: 18,
                      thickness: 0.6,
                    ),
                    Row(
                      children: [
                        ...List.generate(
                          5,
                          (index) => Icon(
                            index < rating ? Icons.star : Icons.star_border,
                            color: Colors.yellow,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          '$rating.0 (21)',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[100],
                      ),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Informasi:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: _buildInlineAttribute(
                                    'Minimum Order', '${product.minOrder}'),
                              ),
                              SizedBox(width: 2),
                              Expanded(
                                child: _buildInlineAttribute(
                                    'Stock', '${product.stock} Buah'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Deskripsi Produk:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            isDescriptionExpanded
                                ? product.description.isNotEmpty
                                    ? product.description
                                    : 'Tampilkan gayamu dengan kepercayaan diri menggunakan produk fashion terbaru kami. Didesain dengan detail yang sempurna, produk ini memberikan sentuhan gaya dan kenyamanan dalam setiap penampilanmu. Temukan gaya baru dan ekspresikan kepribadianmu melalui koleksi fashion kami.'
                                : '${(product.description.isNotEmpty ? product.description.substring(0, 150) : 'Tampilkan gayamu dengan kepercayaan diri menggunakan produk fashion terbaru kami')}... ',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 8),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                isDescriptionExpanded = !isDescriptionExpanded;
                              });
                            },
                            child: Text(
                              isDescriptionExpanded ? 'Show Less' : 'Show More',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    ProductReviews(
                      totalReviews: 21,
                      averageRating: rating,
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(
                Iconsax.messages_2,
                color: Colors.blue,
                size: 30,
              ),
              onPressed: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
              },
            ),
            OutlinedButton(
              onPressed: () {
                addToCart(widget.productId);
              },
              style: OutlinedButton.styleFrom(
                primary: Colors.blue,
                side: BorderSide(color: Colors.blue),
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                '+ Keranjang',
                style: TextStyle(fontSize: 16),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/compare_page');
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Favorite',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttributeItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: value == 'Yes' ? Colors.red : Colors.green,
          ),
        ),
      ],
    );
  }

  String buildFullImageUrl(String filePath) {
    final String BASE_URL = "https://api.bjr-dev.nuncorp.id/ms/api/v1/static";
    return BASE_URL + filePath;
  }

  String formatCurrency(double amount) {
    final currencyFormat =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp.');
    return currencyFormat.format(amount);
  }

  double calculateDiscountPercentage(
      double originalPrice, double discountedPrice) {
    double discountPercentage =
        ((originalPrice - discountedPrice) / originalPrice) * 20;
    return discountPercentage.round().toDouble();
  }

  Widget _buildInlineAttribute(String label, String value) {
    return Text(
      '$label: $value',
      style: TextStyle(
        fontSize: 16,
      ),
    );
  }

  void addToCart(String productId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? cartData = prefs.getStringList('cart') ?? [];
      cartData.add(productId);
      await prefs.setStringList('cart', cartData);

      // Menampilkan notifikasi Snackbar
      Get.snackbar(
        'Produk di tambahkan',
        'Produk di tambahkan ke dalam keranjang',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
      );
    } catch (e) {
      print('Error adding product to cart: $e');
    }
  }
}
