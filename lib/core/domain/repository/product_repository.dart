
import 'package:jual_rugi_app/core/domain/models/product.dart';
import 'package:jual_rugi_app/data/datasource/product_remote_data_source.dart';

class ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepository({required this.remoteDataSource});

  Future<List<Product>> getProductList() async {
    try {
      final response = await remoteDataSource.getProductList();
      final List<Product> products = (response['body']['data'] as List)
          .map((productJson) => Product.fromJson(productJson))
          .toList();
      return products;
    } catch (e) {
      throw Exception('Failed to fetch product list');
    }
  }

  Future<Product> getProductById(int productId) async {
    try {
      final response = await remoteDataSource.getProductById(productId);
      final product = Product.fromJson(response);
      return product;
    } catch (e) {
      throw Exception('Failed to fetch product by id');
    }
  }
}