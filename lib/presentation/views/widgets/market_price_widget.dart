// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:jual_rugi_app/core/domain/model/product_by_id.dart';

// class MarketPriceWidget extends StatelessWidget {
//   final MarketPrice marketPrice;

//   const MarketPriceWidget({Key? key, required this.marketPrice}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Dari ${marketPrice.companyName}',
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         SizedBox(height: 8),
//         Text(
//           '${formatCurrency(marketPrice.price)}',
//           style: TextStyle(
//             fontSize: 18,
//             color: Colors.red,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         SizedBox(height: 8),
//         TextButton(
//           onPressed: () {
//             // Tambahkan logika navigasi ke link harga pembanding di sini
//           },
//           child: Text(
//             'Lihat Harga Pembanding',
//             style: TextStyle(
//               color: Colors.blue,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   String formatCurrency(double amount) {
//     final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp.');
//     return currencyFormat.format(amount);
//   }
// }
