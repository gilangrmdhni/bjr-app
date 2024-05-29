import 'package:jual_rugi_app/core/domain/model/product.dart';

class Store {
  final String name;

  Store({
    required this.name,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      name: json['name'] ?? '',
    );
  }
}

class ProductById {
  final int id;
  final String name;
  final int originalPrice;
  final int discountPrice;
  final double discount;
  final int weight;
  final String description;
  final int stock;
  final int minOrder;
  final bool harmful;
  final bool liquid;
  final bool flammable;
  final bool fragile;
  final Category category;
  final Store store;
  final List<ImageModel> images;
  bool isSelected;
  int quantity;

  ProductById({
    required this.id,
    required this.name,
    required this.originalPrice,
    required this.discountPrice,
    required this.discount,
    required this.weight,
    required this.description,
    required this.stock,
    required this.minOrder,
    required this.harmful,
    required this.liquid,
    required this.flammable,
    required this.fragile,
    required this.category,
    required this.store,
    required this.images,
    this.isSelected = false,
    this.quantity = 1,
  });

  factory ProductById.fromJson(Map<String, dynamic> json) {
    return ProductById(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      originalPrice: json['original_price'] ?? 0,
      discountPrice: json['discount_price'] ?? 0,
      discount: json['discount'] != null ? (json['discount'] as num).toDouble() : 0,
      weight: json['weight'] ?? 0,
      description: json['description'] ?? '',
      stock: json['stock'] ?? 0,
      minOrder: json['min_order'] ?? 0,
      harmful: json['harmful'] ?? false,
      liquid: json['liquid'] ?? false,
      flammable: json['flammable'] ?? false,
      fragile: json['fragile'] ?? false,
      category: Category.fromJson(json['category'] ?? {}),
      store: Store.fromJson(json['store'] ?? {}),
      images: (json['images'] as List<dynamic>?)
          ?.map((imageJson) => ImageModel.fromJson(imageJson))
          .toList() ??
          [],
      isSelected: json['isSelected'] ?? false,
      quantity: json['quantity'] ?? 1,
    );
  }
}
