import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jual_rugi_app/presentation/controllers/shipping_address_controller.dart';

class ShippingAddressView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ShippingAddressController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Alamat Pengiriman',
          style: TextStyle(color: Colors.grey.shade800),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.grey.shade800),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Tambah') {
                // Aksi untuk menambah alamat
              } else if (value == 'Ubah') {
                // Aksi untuk mengubah alamat
              } else if (value == 'Hapus') {
                // Aksi untuk menghapus alamat
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Tambah', 'Ubah', 'Hapus'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Row(
                    children: [
                      if (choice == 'Tambah') Icon(Icons.add, color: Colors.black),
                      if (choice == 'Ubah') Icon(Icons.edit, color: Colors.black),
                      if (choice == 'Hapus') Icon(Icons.delete, color: Colors.red),
                      SizedBox(width: 8),
                      Text(choice),
                    ],
                  ),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: controller.addresses.length,
            itemBuilder: (context, index) {
              final address = controller.addresses[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: address.defaultLocation ? Colors.blue : Colors.grey.shade300,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    title: Row(
                      children: [
                        if (address.defaultLocation)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'Utama',
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            '${address.name} - ${address.phone}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Text(address.address),
                    onTap: () {
                      // Handle tap on address
                    },
                  ),
                ),
              );
            },
          );
        }
      }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            // Handle save button
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
            onPrimary: Colors.white,
            padding: EdgeInsets.all(14),
            minimumSize: Size(double.infinity, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
          ),
          child: Text(
            'Simpan',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
