import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';

class ImageSlider extends StatefulWidget {
  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            double screenWidth = constraints.maxWidth;
            double imageHeight = screenWidth * 0.6; // Sesuaikan dengan kebutuhan

            return CarouselSlider(
              options: CarouselOptions(
                height: imageHeight,
                viewportFraction: 1.0,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 8),
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentImageIndex = index;
                  });
                },
              ),
              items: [
                'assets/images/products/promo-banner-1.png',
                'assets/images/products/promo-banner-2.png',
                'assets/images/products/promo-banner-3.png',
                // Tambahkan banner lainnya sesuai kebutuhan
              ].map((imagePath) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: screenWidth,
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(imagePath),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    );
                  },
                );
              }).toList(),
            );
          },
        ),
        SizedBox(height: 10),
        DotsIndicator(
          dotsCount: 3, // Ganti dengan jumlah gambar Anda
          position: _currentImageIndex.toDouble(),
          decorator: DotsDecorator(
            color: Colors.grey[300]!, // Warna dot non-aktif
            activeColor: Color.fromARGB(244, 84, 177, 253), // Warna dot aktif
            spacing: EdgeInsets.all(5),
            size: const Size.square(8),
            activeSize: const Size(20, 8),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ],
    );
  }
}
