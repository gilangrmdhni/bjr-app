import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:jual_rugi_app/core/domain/model/product_compare.dart';
import 'package:jual_rugi_app/core/usecases/compare_usecase.dart';
import 'package:jual_rugi_app/data/repositories/compare_repository.dart';
import 'package:jual_rugi_app/presentation/controllers/compare_controller.dart';

class ComparePage extends StatefulWidget {
  @override
  _ComparePageState createState() => _ComparePageState();
}

class _ComparePageState extends State<ComparePage> {
  late CompareController _controller;
  late List<ProductCompare> _products;
  final NumberFormat _currencyFormat =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');

  @override
  void initState() {
    super.initState();
    _controller = CompareController(CompareUseCase(CompareRepository()));
    _products = _controller.getDummyProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Pembanding',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Table(
                columnWidths: {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(1),
                },
                children: [
                  TableRow(
                    children: [
                      _buildProductComparisons(_products[0]),
                      _buildProductComparisons(_products[1]),
                    ],
                  ),
                  TableRow(
                    children: [
                      _buildProductComparison(_products[0]),
                      _buildProductComparison(_products[1]),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
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
                setState(() {});
              },
            ),
            OutlinedButton(
              onPressed: () {},
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

  Widget _buildProductHeader(String title) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey),
        ),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Widget _buildProductComparisons(ProductCompare product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 150,
          child: Center(
            child: Image.asset(
              product.images.first,
              fit: BoxFit.cover,
            ),
          ),
        ),
        _buildProductDetails('', product.name),
        _buildProductDetail('', _currencyFormat.format(product.price)),
      ],
    );
  }

  Widget _buildProductComparison(ProductCompare product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        _buildProductDetail('Deskripsi:', product.description),
        _buildProductDetail('Stok:', '${product.stock}'),
        _buildProductDetail('Kategori:', product.category),
        _buildProductDetail('Toko:', product.store),
        _buildProductDetail('Harmful:', product.harmful ? 'Yes' : 'No'),
        _buildProductDetail('Liquid:', product.liquid ? 'Yes' : 'No'),
        _buildProductDetail('Flammable:', product.flammable ? 'Yes' : 'No'),
        _buildProductDetail('Fragile:', product.fragile ? 'Yes' : 'No'),
      ],
    );
  }

  Widget _buildProductDetails(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
          Text(
            label.isNotEmpty
                ? value
                : (value.length > 18
                    ? value.substring(0, 18) + '...'
                    : value), // Truncate long text only for product name
            textAlign: label.isNotEmpty
                ? TextAlign.center
                : TextAlign.center, // Center the text only for product name
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: label.isNotEmpty
                  ? Colors.black
                  : Colors.black, // Custom text color for product name
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductDetail(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            textAlign: TextAlign.start, // Center the text
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          Divider(height: 1, color: Colors.grey), // Add thin line separator
        ],
      ),
    );
  }
}
