import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jual_rugi_app/presentation/controllers/store_controller.dart';

class StoreNameInputView extends StatelessWidget {
  final StoreController storeController = Get.find<StoreController>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Nama dan Lokasi Toko'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nama Toko'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: locationController,
              decoration: InputDecoration(labelText: 'Lokasi Toko'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Panggil fungsi registerStore saat tombol diklik
                storeController.registerStore(
                  nameController.text,
                  locationController.text,
                );
              },
              child: Text('Daftar Toko'),
            ),
          ],
        ),
      ),
    );
  }
}
