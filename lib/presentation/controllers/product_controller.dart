// lib/presentation/controllers/product_controller.dart
import 'package:get/get.dart';
import 'package:jual_rugi_app/core/domain/model/product.dart';
import 'package:jual_rugi_app/data/repositories/product_repository.dart';

class ProductController extends GetxController {
  final ProductRepository _productRepository;
  RxList<Product> productList = <Product>[].obs;
  int _currentPage = 1; // Track the current page
  bool _loading = false; // Track if data is being loaded
  bool hasMoreData = true; // Track if there's more data available

  ProductController(this._productRepository);

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      if (_loading || !hasMoreData) {
        return;
      }

      _loading = true;
      List<Product> products =
          await _productRepository.getProducts(_currentPage);

      if (products.isNotEmpty) {
        productList.addAll(products);
        _currentPage++;
        print('Products fetched successfully!');
      } else {
        // No more data available
        hasMoreData = false;
      }

      _loading = false;
    } catch (e, stackTrace) {
      print("Error fetching products: $e, Stack trace: $stackTrace");
      _loading = false;
    }
  }

  Future<void> refreshProducts() async {
    try {
      _currentPage = 1; // Reset page to 1 when refreshing
      hasMoreData = true; // Reset hasMoreData to true
      print("Refreshing products...");
      List<Product> updatedProducts =
          await _productRepository.getProducts(_currentPage);

      print("Number of updated products: ${updatedProducts.length}");

      // Clear existing products before adding updated ones
      productList.clear();

      updatedProducts.forEach((product) {
        print(
            "Updated Product: ${product.name}, Price: ${product.originalPrice}");
      });

      productList.addAll(updatedProducts);
      _currentPage++; // Increment current page for future fetches

      print("Products refreshed successfully!");
    } catch (e, stackTrace) {
      print("Error refreshing products: $e, Stack trace: $stackTrace");
    }
  }

  Future<void> loadMoreProducts() async {
    try {
      // Check if the last product from the previous fetch is already in the list
      if (productList.isNotEmpty) {
        List<Product> lastProducts =
            await _productRepository.getProducts(_currentPage - 1);
        if (lastProducts.isNotEmpty && lastProducts.last == productList.last) {
          print('Data already loaded. Skipping loadMoreProducts.');
          return;
        }
      }
      // Trigger fetchProducts to load more data
      await fetchProducts();
    } catch (e, stackTrace) {
      print("Error loading more products: $e, Stack trace: $stackTrace");
    }
  }
}
