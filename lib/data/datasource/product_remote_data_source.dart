import 'package:dio/dio.dart';

class ProductRemoteDataSource {
  final Dio dio;

  ProductRemoteDataSource({required this.dio});

  Future<Map<String, dynamic>> getProductList() async {
    final response = await dio.get('https://api.bjr-dev.nuncorp.id/ps/api/v1/products');
    return response.data;
  }

  Future<Map<String, dynamic>> getProductById(int productId) async {
    final response = await dio.get('https://api.bjr-dev.nuncorp.id/ps/api/v1/products/id/$productId');
    return response.data;
  }
}
