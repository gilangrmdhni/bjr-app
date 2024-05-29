import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jual_rugi_app/core/domain/model/product.dart';
import 'package:jual_rugi_app/core/domain/model/product_by_id.dart';
import 'package:logger/logger.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts(int page);
  Future<ProductById> getProductById(String productId);
}

class ProductRepositoryImpl implements ProductRepository {
  final String apiUrl = 'https://api.bjr-dev.nuncorp.id/ps/api/v1/products';
  final int itemsPerPage = 10;
  final Logger logger = Logger();

  @override
  Future<List<Product>> getProducts(int page) async {
    try {
      final response =
          await http.get(Uri.parse('$apiUrl?page=$page&limit=$itemsPerPage'));

      if (response.statusCode == 200) {
        logger.d('Response Body: ${response.body}');
        final Map<String, dynamic> data = json.decode(response.body);
        print('Received JSON data: $data');

        if (data['body'] != null) {
          final List<dynamic> rows = data['body'];
          List<Product> products = rows
              .map<Product>((json) => _safeProductFromJson(json))
              .whereType<Product>()
              .toList();

          return products;
        } else {
          logger.e('Failed to load products. Unexpected response format.');
          throw Exception('Failed to load products');
        }
      } else {
        logger
            .e('Failed to load products. Status code: ${response.statusCode}');
        throw Exception('Failed to load products');
      }
    } catch (e, stackTrace) {
      logger.e('Error fetching products: $e\n$stackTrace');
      throw Exception('Error fetching products: $e');
    }
  }

  Product _safeProductFromJson(dynamic json) {
    try {
      return Product(
        id: json['id'],
        name: json['name'],
        originalPrice: json['original_price'],
        discountPrice: json['discount_price'],
        discount: (json['discount'] as num?)?.toDouble() ??
            0, // Ambil nilai discount dari JSON
        category: Category.fromJson(json['category']),
        images: (json['images'] as List<dynamic>)
            .map((imageJson) => ImageModel.fromJson(imageJson))
            .toList(),
      );
    } catch (e, stackTrace) {
      logger
          .e('Error converting json to Product: $e\n$stackTrace\nJSON: $json');
      throw Exception('Error converting json to Product: $e');
    }
  }

  @override
  Future<ProductById> getProductById(String productId) async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/id/$productId'));
      if (response.statusCode == 200) {
        final Map<String, dynamic>? data = json.decode(response.body);
        final dynamic bodyData = data?['body'];

        if (bodyData != null && bodyData is Map<String, dynamic>) {
          List<ImageModel> images = bodyData['images'] != null
              ? (bodyData['images'] as List<dynamic>)
                  .map<ImageModel>(
                      (imageJson) => ImageModel.fromJson(imageJson))
                  .toList()
              : [];

          ProductById product = ProductById(
            id: bodyData['id'],
            name: bodyData['name'],
            originalPrice: bodyData['original_price'],
            discountPrice: bodyData['discount_price'],
            discount: (bodyData['discount'] as num?)?.toDouble() ?? 0,
            weight: bodyData['weight'],
            description: bodyData['description'] ?? '',
            stock: bodyData['stock'] ?? 0,
            minOrder: bodyData['min_order'] ?? 0,
            harmful: bodyData['harmful'] ?? false,
            liquid: bodyData['liquid'] ?? false,
            flammable: bodyData['flammable'] ?? false,
            fragile: bodyData['fragile'] ?? false,
            category: Category.fromJson(bodyData['category'] ?? {}),
            store: Store.fromJson(bodyData['store'] ?? {}),
            images: images,
            isSelected: bodyData['isSelected'] ?? false,
            quantity: bodyData['quantity'] ?? 1,
          );

          return product;
        } else {
          throw Exception('Invalid JSON data received');
        }
      } else {
        throw Exception('Failed to load product by ID');
      }
    } catch (e, stackTrace) {
      logger.e('Error fetching product by ID: $e\n$stackTrace');
      throw Exception('Error fetching product by ID: $e');
    }
  }
}
