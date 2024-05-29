import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jual_rugi_app/app_routes.dart';

class SuccessPaymentView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Success Payment'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.blue,
              size: 100.0,
            ),
            SizedBox(height: 16.0),
            Text(
              'Transaksi Selesai!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Terimakasih telah berbelanja di Berani Jual Rugi dengan berbelanja di toko kami, kamu sudah mendukung produk lokal untuk terus tumbuh dan berkembang.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12.0),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
               Get.offAllNamed(AppRoutes.home);
              },
              child: Text('Beranda'),
            ),
          ],
        ),
      ),
    );
  }
}
