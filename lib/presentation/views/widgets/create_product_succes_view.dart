import 'package:flutter/material.dart';
import 'package:jual_rugi_app/app_routes.dart';
import 'package:jual_rugi_app/presentation/views/home_view.dart';

class CreateProductSuccessView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sukses Membuat Produk'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 100,
            ),
            SizedBox(height: 16),
            Text(
              'Produk berhasil ditambahkan!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigasi ke halaman beranda dengan menggantikan seluruh stack
                Navigator.pushReplacementNamed(context, AppRoutes.home);
              },
              child: Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}
