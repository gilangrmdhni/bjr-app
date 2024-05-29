import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jual_rugi_app/presentation/views/transaction/add_address.dart';
import 'package:jual_rugi_app/presentation/views/transaction/payment_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressListView extends StatelessWidget {
  final double totalAmount;

  AddressListView({required this.totalAmount});

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
          'Daftar Alamat',
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
            Expanded(
              child: AddressList(totalAmount: totalAmount),
            ),
            SizedBox(height: 16),
            OutlinedButton(
              onPressed: () {
                // Tambahkan logika untuk menangani tombol "Tambah Alamat"
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AddAddressView(totalAmount: totalAmount)));
              },
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 6.0),
                side: BorderSide(
                    color: Colors.blue), // Ganti warna sesuai keinginan
              ),
              child: Text('Tambah Alamat'),
            ),
            SizedBox(
                height:
                    16), // Jarak antara tombol "Tambah Alamat" dan "Harga Produk"
            Text(
              'Harga Produk: ${formatCurrency(totalAmount)}',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(
                height: 16), // Jarak antara "Harga Produk" dan tombol "Lanjut"
            ElevatedButton(
              onPressed: () {
                // Navigasi ke halaman pembayaran dengan membawa data yang dibutuhkan
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentView(
                      name: "NamaPenerima", // Gantilah dengan nilai yang sesuai
                      address: "Alamat", // Gantilah dengan nilai yang sesuai
                      province: "Provinsi", // Gantilah dengan nilai yang sesuai
                      city: "Kota", // Gantilah dengan nilai yang sesuai
                      totalAmount: totalAmount,
                    ),
                  ),
                );
              },
              child: Text('Lanjut'),
            ),
          ],
        ),
      ),
    );
  }
}

class AddressList extends StatelessWidget {
  final double totalAmount;

  AddressList({required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      // Fetch the list of addresses from SharedPreferences
      future: _getSavedAddresses(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          // If data is received, display the list of addresses
          List<String>? addresses = snapshot.data;
          if (addresses != null && addresses.isNotEmpty) {
            return AddressListContent(
              addresses: addresses,
              totalAmount: totalAmount,
            );
          } else {
            // Display a message if no addresses are saved
            return Center(
              child: Text('Belum ada alamat yang tersimpan.'),
            );
          }
        }
      },
    );
  }

  Future<List<String>> _getSavedAddresses() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? savedAddresses = prefs.getStringList('addresses') ?? [];
      return savedAddresses;
    } catch (e) {
      print('Error fetching saved addresses: $e');
      return [];
    }
  }
}

class AddressListContent extends StatefulWidget {
  final double totalAmount;
  final List<String> addresses;

  AddressListContent({
    required this.addresses,
    required this.totalAmount,
  });

  @override
  _AddressListContentState createState() => _AddressListContentState();
}

class _AddressListContentState extends State<AddressListContent> {
  int selectedAddressIndex = -1;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.addresses.length,
      itemBuilder: (context, index) {
        return AddressCard(
          address: widget.addresses[index],
          isSelected: index == selectedAddressIndex,
          onSelect: () {
            // Toggle selection on tap
            setState(() {
              selectedAddressIndex =
                  (selectedAddressIndex == index) ? -1 : index;
            });
          },
        );
      },
    );
  }
}

class AddressCard extends StatelessWidget {
  final String address;
  final bool isSelected;
  final VoidCallback onSelect;

  AddressCard({
    required this.address,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text('Alamat Pengiriman'),
        subtitle: Text(address),
        onTap: onSelect,
        tileColor: isSelected
            ? Colors.grey.shade200
            : null, // Highlight the selected address
      ),
    );
  }
}

String formatCurrency(double amount) {
  final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp.');
  return currencyFormat.format(amount);
}
