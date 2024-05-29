import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jual_rugi_app/data/repositories/product_repository.dart';
import 'package:jual_rugi_app/presentation/controllers/product_controller.dart';
import 'package:jual_rugi_app/presentation/views/utils/text/section_heading.dart';
import 'package:jual_rugi_app/presentation/views/widgets/custom_app_bar.dart';
import 'package:jual_rugi_app/presentation/views/widgets/home_category.dart';
import 'package:jual_rugi_app/presentation/views/widgets/image_slider.dart';
import 'package:jual_rugi_app/presentation/views/widgets/product_card.dart';

class HomeView extends StatelessWidget {
  final ProductController productController =
      Get.put(ProductController(ProductRepositoryImpl()));
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: RefreshIndicator(
        onRefresh: productController
            .refreshProducts, // Fungsi yang dipanggil saat melakukan refresh
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.pixels ==
                scrollInfo.metrics.maxScrollExtent) {
              // Reached the bottom of the list, load more
              productController.fetchProducts();
            }
            return true;
          },
          child: CustomScrollView(
            physics: ClampingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(height: 8),
              ),
              SliverToBoxAdapter(
                child: ImageSlider(),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: 8),
              ),
              SliverToBoxAdapter(
                child: HomeCategories(),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: 4),
              ),
              SliverToBoxAdapter(
                child: SectionHeading(
                  title: 'Rekomendasi buat kamu',
                  onPressed: () {},
                ),
              ),
              Obx(
                () => SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index < productController.productList.length) {
                        return ProductCard(
                          product: productController.productList[index],
                        );
                      } else {
                        return Container(); // Return an empty container for the indicator
                      }
                    },
                    childCount: productController.productList.length + 1,
                  ),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200, // Sesuaikan sesuai kebutuhan
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 0.6, // Sesuaikan sesuai kebutuhan
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Center(
                  child: SizedBox(
                    width: 20.0,
                    height: 20.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
