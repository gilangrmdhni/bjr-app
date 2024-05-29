import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

class PaymentView extends StatelessWidget {
  final String name;
  final String address;
  final String province;
  final String city;
  final double totalAmount;

  PaymentView({
    required this.name,
    required this.address,
    required this.province,
    required this.city,
    required this.totalAmount,
  });

  final RxString selectedPaymentOption = ''.obs;

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
          'Pembayaran',
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
            SizedBox(height: 16),
            buildPaymentOptions(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Detail Pembayaran',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Nama Penerima: $name'),
            SizedBox(height: 4),
            Text('Alamat: $address, $province, $city'),
            SizedBox(height: 4),
            Text('Nominal Produk: ${formatCurrency(totalAmount)}'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                Get.toNamed('/success-payment');
              },
              child: Text('Konfirmasi Pembayaran'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPaymentOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pilih Metode Pembayaran:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        buildPaymentOption('BCA Virtual Account', Icons.credit_card),
        buildPaymentOption('OVO', Icons.wallet_giftcard),
        buildPaymentOption('GoPay', Icons.payment),
      ],
    );
  }

  Widget buildPaymentOption(String option, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(option),
      trailing: Obx(
        () => Radio(
          value: option,
          groupValue: selectedPaymentOption.value,
          onChanged: (value) {
            selectedPaymentOption.value = value.toString();
          },
        ),
      ),
      onTap: () {
        selectedPaymentOption.value = option;
      },
    );
  }

  String formatCurrency(double amount) {
    final currencyFormat =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp.');
    return currencyFormat.format(amount);
  }

  Future<void> initiatePayment() async {
    try {
      final String dynamicLink =
          Uri.encodeFull('https://appbjr.page.link/success?success=true');
      print('Encoded URL: $dynamicLink');
      final String paymentConfirmationUrl =
          'https://ewallet-mock-connector.xendit.co/v1/ewallet_connector/checkouts?token=cn7i67d8jg0h99n5qebg';

      await FlutterWebBrowser.openWebPage(
        url: paymentConfirmationUrl,
      );
    } catch (e) {
      print('Error initiating payment: $e');
    }
  }
}
