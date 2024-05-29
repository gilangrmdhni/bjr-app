import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jual_rugi_app/presentation/views/create_product.dart';
import 'package:jual_rugi_app/presentation/views/home_view.dart';
import 'package:jual_rugi_app/presentation/views/profile/main_view.dart';
import 'package:jual_rugi_app/presentation/views/transaction/transaksi_view.dart';
import 'package:jual_rugi_app/presentation/views/wishlist_view.dart';

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    HomeView(),
    WishlistView(),
    CreateProductView(),
    TransaksiView(),
    MainView(),
  ];

  Widget buildScreen(int index) {
    return screens[index];
  }

  void changePage(int index) {
    selectedIndex.value = index;
  }
}

