import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StoreView extends StatefulWidget {
  @override
  _StoreViewState createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView>
    with SingleTickerProviderStateMixin {
  final List<String> categories = ['Fashion', 'Sports', 'Gadget', 'Furniture'];
  final List<Map<String, dynamic>> popularProducts = [
    {
      'name': 'Laptop ROG Red Devil ',
      'price': 200000,
      'image': 'assets/images/products/acer_laptop_1.png',
      'discount': 20,
      'location': 'Jakarta',
      'rating': 4.5,
    },
    {
      'name': 'Bola NIKE FOOTBALL',
      'price': 399000,
      'image': 'assets/images/products/Adidas_Football.png',
      'discount': 10,
      'location': 'Bandung',
      'rating': 4.0,
    },
    {
      'name': 'iphone 12 64gb Black',
      'price': 20999000,
      'image': 'assets/images/products/iphone_12_black.png',
      'discount': 15,
      'location': 'Surabaya',
      'rating': 4.2,
    },
  ];

  bool showModal = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animation =
        Tween<double>(begin: 1.0, end: 0.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleModal() {
    if (showModal) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
    setState(() {
      showModal = !showModal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Icon(Icons.search, color: Colors.grey.shade400),
              SizedBox(width: 8),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search On Berani Jual Rugi',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.more_vert, color: Colors.black),
                onPressed: _toggleModal,
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                Container(
                  padding: EdgeInsets.all(16),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // Gambar profil toko (ganti dengan gambar logo toko Anda)
                          CircleAvatar(
                            backgroundImage: AssetImage('assets/logos/bjr.png'),
                            radius: 30,
                          ),
                          SizedBox(
                              width:
                                  16), // Memberi jarak antara gambar profil dan teks
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Nama Toko
                              Text(
                                'Toko Dina Dini',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                  height:
                                      4), // Memberi sedikit jarak antara teks nama dan email
                              // Email Toko (sebelumnya Deskripsi singkat toko)
                              Text(
                                'dini@mailinator.com', // Ganti dengan alamat email toko Anda
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.star, color: Colors.yellow),
                                      SizedBox(width: 4),
                                      Text(
                                        '4.5',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Ulasan Toko',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(width: 20),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width: 4),
                                    Text(
                                      'Sedang Online',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Terakhir Online',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 20),
                          Row(
                            children: [
                              SizedBox(width: 4),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '20 jam',
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    'Waktu Proses',
                                    textAlign: TextAlign
                                        .center, // Mengatur teks menjadi berpusat
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Produk
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 40,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Chip(
                                label: Text(categories[index]),
                                backgroundColor: Colors.grey.shade300,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // Produk Terpopuler
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Produk Terpopuler',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200, // Sesuaikan sesuai kebutuhan
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 4.0,
                          childAspectRatio: 0.6, // Sesuaikan sesuai kebutuhan
                        ),
                        itemCount: popularProducts.length,
                        itemBuilder: (context, index) {
                          return buildProductCard(popularProducts[index]);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (showModal)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Home'),
                      onTap: () {
                        // Aksi ketika opsi 1 dipilih
                      },
                    ),
                    ListTile(
                      title: Text('Jual Produk'),
                      onTap: () {
                        // Aksi ketika opsi 2 dipilih
                      },
                    ),
                    ListTile(
                      title: Text('Edit Toko'),
                      onTap: () {
                        // Aksi ketika opsi 3 dipilih
                      },
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildProductCard(Map<String, dynamic> product) {
    final currencyFormat =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            product['image'],
            height: 120,
            width: 160,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['name'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  currencyFormat.format(product['price']),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.pink.shade100,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${product['discount']}%',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: 2),
                    Text(
                      currencyFormat.format(product['price'] *
                          (100 / (100 - product['discount']))),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: Colors.grey),
                    SizedBox(width: 4),
                    Text(
                      product['location'],
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 0.5,
                  color: Colors.grey,
                  margin: EdgeInsets.symmetric(vertical: 6),
                ),
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      Icons.star,
                      color: index < product['rating']
                          ? Colors.yellow
                          : Colors.grey,
                      size: 25,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
