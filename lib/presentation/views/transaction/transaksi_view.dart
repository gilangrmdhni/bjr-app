import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransaksiView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme:
            IconThemeData(color: Colors.black), // Ubah warna ikon menjadi hitam
        title: Text(
          'Transaksi',
          style:
              TextStyle(color: Colors.black), // Ubah warna teks menjadi hitam
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildFilterButtons(), // Filter buttons
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  TransactionCard(
                    productName: 'Sepatu Nike Air Jorda 556',
                    image: 'assets/images/products/acer_laptop_1.png',
                    price: 500000,
                    status: 'Pembelian',
                    estimatedDays: 3,
                    description: 'Menunggu konfirmasi pembayaran',
                  ),
                  SizedBox(height: 10),
                  TransactionCard(
                    productName: 'Kemeja Flanel',
                    image: 'assets/images/products/Adidas_Football.png',
                    price: 250000,
                    status: 'Penjualan',
                    estimatedDays: 2,
                    description: 'Sedang dalam proses pengiriman',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget for filter buttons
  Widget _buildFilterButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            // Filter transactions by status 'Semua'
            print('Filter by Semua');
          },
          child: Text('Semua'),
        ),
        DropdownButton<String>(
          items: <String>['Tanggal', 'Harga'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              // Sort transactions by selected value (Tanggal or Harga)
              print('Sort by $newValue');
            }
          },
          hint: Text('Sortir'),
        ),
        DropdownButton<String>(
          items:
              <String>['Status 1', 'Status 2', 'Status 3'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              // Filter transactions by selected status
              print('Filter by $newValue');
            }
          },
          hint: Text('Status'),
        ),
      ],
    );
  }
}

class TransactionCard extends StatelessWidget {
  final String productName;
  final String image;
  final int price;
  final String status;
  final int estimatedDays;
  final String description;

  const TransactionCard({
    required this.productName,
    required this.image,
    required this.price,
    required this.status,
    required this.estimatedDays,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Add navigation logic to product detail page
      },
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                productName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Harga: ${_formatCurrency(price)}',
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 5),
              Text(
                'Status: $status',
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 5),
              Text(
                'Estimasi: $estimatedDays hari',
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 5),
              Text(
                description,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatCurrency(int amount) {
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');
    return formatter.format(amount);
  }
}
