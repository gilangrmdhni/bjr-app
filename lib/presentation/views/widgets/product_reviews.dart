import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProductReviews extends StatelessWidget {
  final int totalReviews;
  final int averageRating;

  ProductReviews({required this.totalReviews, required this.averageRating});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Ulasan Produk',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12),
        RatingProgressIndicator(
          text: '5 ',
          value: 0.8, // Sesuaikan dengan nilai yang sesuai
        ),
        RatingProgressIndicator(
          text: '4 ',
          value: 0.6, // Sesuaikan dengan nilai yang sesuai
        ),
        RatingProgressIndicator(
          text: '3 ',
          value: 0.5, // Sesuaikan dengan nilai yang sesuai
        ),
        RatingProgressIndicator(
          text: '2 ',
          value: 0.2, // Sesuaikan dengan nilai yang sesuai
        ),
        RatingProgressIndicator(
          text: '1 ',
          value: 0.1, // Sesuaikan dengan nilai yang sesuai
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Iconsax.star,
                  color: Colors.yellow,
                  size: 20,
                ),
                SizedBox(width: 4),
                Text(
                  '$averageRating.0',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 4),
                Text(
                  '($totalReviews Ulasan)',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                // Implementasikan logika untuk membuka halaman ulasan produk
              },
              child: Text(
                'Lihat Semua Ulasan',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        UserReviewCard(),
        UserReviewCard(),
        SizedBox(height: 16),
      ],
    );
  }
}

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Implementasi dari UserReviewCard
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/logos/e-com-logo.png'),
                ),
                SizedBox(width: 8),
                Text(
                  'Haikal Ramadan',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                // Implementasikan logika untuk tombol lebih banyak
              },
              icon: Icon(Icons.more_vert),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(
              Iconsax.star, // Ganti dengan ikon bintang yang sesuai
              color: Colors.yellow,
              size: 16,
            ),
            SizedBox(width: 4),
            Text(
              '4.0',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 4),
            Text(
              '01 Nov 2023',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          'Ulasan pengguna akan ditampilkan di sini. The user interface of the app is quite intuitive. I was able to navigate and make purchases seamlessly. Great Job!!',
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(height: 8),
      ],
    );
  }
}

class RatingProgressIndicator extends StatelessWidget {
  const RatingProgressIndicator({
    Key? key,
    required this.text,
    required this.value,
  });

  final String text;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        Expanded(
          flex: 11,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: LinearProgressIndicator(
              value: value,
              minHeight: 10,
              backgroundColor: Color.fromARGB(255, 178, 201, 255),
              valueColor: const AlwaysStoppedAnimation(Colors.blue),
              borderRadius: BorderRadius.circular(7),
            ),
          ),
        ),
      ],
    );
  }
}
