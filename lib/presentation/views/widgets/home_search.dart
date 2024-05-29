import 'package:flutter/material.dart';

class SearchForm extends StatelessWidget {
  final TextEditingController searchController;

  const SearchForm({required this.searchController});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade200,
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.grey),
            onPressed: () {
              // Tambahkan logika pencarian sesuai kebutuhan
              // Anda dapat memanggil fungsi pencarian di sini jika diperlukan
            },
          ),
          Expanded(
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Cari di BJR',
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}