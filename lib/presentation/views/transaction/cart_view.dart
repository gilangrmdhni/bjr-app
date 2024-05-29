import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jual_rugi_app/core/domain/model/product_by_id.dart';
import 'package:jual_rugi_app/data/repositories/product_repository.dart';
import 'package:jual_rugi_app/presentation/views/transaction/add_address.dart';
import 'package:jual_rugi_app/presentation/views/transaction/address_list_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartView extends StatefulWidget {
  final ProductRepository productRepository;

  CartView({required this.productRepository});

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  List<ProductById> cartProducts = [];

  @override
  void initState() {
    super.initState();
    loadCartItems();
  }

  Future<void> loadCartItems() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? storedItems = prefs.getStringList('cart');

      if (storedItems != null && storedItems.isNotEmpty) {
        List<ProductById> loadedProducts = [];

        for (String productId in storedItems) {
          try {
            ProductById? product =
                await widget.productRepository.getProductById(productId);
            if (product != null) {
              loadedProducts.add(product);
            } else {
              print('Product with ID $productId not found.');
            }
          } catch (e) {
            print('Error fetching product with ID $productId: $e');
          }
        }

        setState(() {
          cartProducts = loadedProducts;
        });
      }
    } catch (e) {
      print('Error loading cart items: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey.shade800,
          ),
          onPressed: () {
            // Tambahkan fungsi untuk kembali ke layar sebelumnya
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Keranjang',
          style: TextStyle(color: Colors.grey.shade800),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: isAllSelected(),
                      onChanged: (value) {
                        toggleSelectAll(value);
                      },
                    ),
                    Text('Pilih Semua'),
                  ],
                ),
                Text(
                  'Hapus',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cartProducts.length,
              itemBuilder: (context, index) {
                ProductById product = cartProducts[index];
                return ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  tileColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    side: BorderSide(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  leading: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: product.isSelected,
                        onChanged: (value) {
                          toggleProductSelection(product.id.toString());
                        },
                      ),
                      SizedBox(width: 6.0),
                      Container(
                        width: 70,
                        height: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4.0),
                          child: Image.network(
                            buildFullImageUrl(product.images[0].filePath),
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  title: Text(product.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        formatCurrency(product.discountPrice.toDouble()),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        children: [
                          Text('- ${product.quantity} +'),
                        ],
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.restore_from_trash_rounded),
                    onPressed: () {
                      removeFromCart(product.id.toString());
                    },
                  ),
                );
              },
            ),
          ),
          buildCheckoutSection(),
        ],
      ),
    );
  }

  Widget buildCheckoutSection() {
    double totalAmount = calculateTotalAmount();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Harga Produk: ${formatCurrency(totalAmount)}',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AddressListView(totalAmount: totalAmount),
                    ),
                  );
                },
                child: Text('Beli'),
              ),
            ],
          ),
        ],
      ),
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

  bool isAllSelected() {
    // Memeriksa apakah semua produk sudah dipilih
    return cartProducts.every((product) => product.isSelected);
  }

  void toggleSelectAll(bool? value) {
    // Mengubah status pilihan (isSelected) untuk semua produk
    for (var product in cartProducts) {
      product.isSelected = value ?? false;
    }
    setState(() {});
  }

  void toggleProductSelection(String productId) {
    setState(() {
      final productIndex = cartProducts.indexWhere(
        (product) => product.id.toString() == productId,
      );

      if (productIndex != -1) {
        cartProducts[productIndex].isSelected =
            !(cartProducts[productIndex].isSelected );
      }

      // Memanggil fungsi calculateTotalAmount setiap kali ada perubahan pada cartProducts
      calculateTotalAmount();
    });
  }

  void removeFromCart(String productId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? cartData = prefs.getStringList('cart');
      cartData?.remove(productId);

      // Update selected product list without the removed product
      setState(() {
        cartProducts
            .removeWhere((product) => product.id.toString() == productId);
      });

      await prefs.setStringList('cart', cartData ?? []);

      // Memanggil fungsi calculateTotalAmount setiap kali ada perubahan pada cartProducts
      calculateTotalAmount();
    } catch (e) {
      print('Error removing product from cart: $e');
    }
  }

  double calculateTotalAmount() {
    double totalAmount = 0;
    for (var product in cartProducts) {
      if (product.isSelected ?? false) {
        totalAmount += product.discountPrice * product.quantity;
      }
    }
    return totalAmount;
  }
}
