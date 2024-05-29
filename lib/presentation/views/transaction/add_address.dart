import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jual_rugi_app/presentation/views/transaction/address_list_view.dart';
import 'package:jual_rugi_app/presentation/views/transaction/payment_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddAddressView extends StatelessWidget {
  final double totalAmount;

  AddAddressView({required this.totalAmount});

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController provinceController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  int currentStep = 0;

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
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Alamat',
          style: TextStyle(color: Colors.grey.shade800),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nama Penerima'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: provinceController,
              decoration: InputDecoration(labelText: 'Provinsi'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: cityController,
              decoration: InputDecoration(labelText: 'Kota'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: addressController,
              decoration: InputDecoration(labelText: 'Alamat Pengiriman'),
              maxLines: 3,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                saveAddressAndShowNotification();
              },
              child: Text('Tambah'),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void saveAddressAndShowNotification() async {
    String name = nameController.text;
    String address = addressController.text;
    String province = provinceController.text;
    String city = cityController.text;

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? savedAddresses = prefs.getStringList('addresses') ?? [];
      savedAddresses.add(
          '$name, $address, $province, $city, ${formatCurrency(totalAmount)}');
      await prefs.setStringList('addresses', savedAddresses);

      Get.snackbar(
          'Alamat Disimpan',
          backgroundColor: Colors.blue,
          colorText: Colors.white,
          'Alamat pengiriman berhasil disimpan: $name, $address, $province, $city');

      Get.to(() => AddressListView(
            totalAmount: totalAmount,
          ));
    } catch (e) {
      print('Error saving address: $e');
    }
  }

  String formatCurrency(double amount) {
    final currencyFormat =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp.');
    return currencyFormat.format(amount);
  }
}
