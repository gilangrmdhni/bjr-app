class Product {
  final int id;
  final String name;
  final double originalPrice;
  final double discountPrice;
  final double discount;
  final double weight;
  final String description;
  final int stock;
  final int minOrder;
  final bool harmful;
  final bool liquid;
  final bool flammable;
  final bool fragile;
  final Category category;
  final Store store;
  final List<ImageData> images;

  Product({
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
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['body']['id'],
      name: json['body']['name'],
      originalPrice: json['body']['original_price'].toDouble(),
      discountPrice: json['body']['discount_price'].toDouble(),
      discount: json['body']['discount'].toDouble(),
      weight: json['body']['weight'].toDouble(),
      description: json['body']['description'],
      stock: json['body']['stock'],
      minOrder: json['body']['min_order'],
      harmful: json['body']['harmful'],
      liquid: json['body']['liquid'],
      flammable: json['body']['flammable'],
      fragile: json['body']['fragile'],
      category: Category.fromJson(json['body']['category']),
      store: Store.fromJson(json['body']['store']),
      images: (json['body']['images'] as List)
          .map((imageJson) => ImageData.fromJson(imageJson))
          .toList(),
    );
  }
}

class Category {
  final int id;
  final String name;
  final String image;

  Category({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}

class Store {
  final String name;
  final City city;

  Store({
    required this.name,
    required this.city,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      name: json['name'],
      city: City.fromJson(json['city']),
    );
  }
}

class City {
  final String name;

  City({
    required this.name,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      name: json['name'],
    );
  }
}

class ImageData {
  final int id;
  final int fileSize;
  final String filePath;
  final String contentType;
  final DateTime createdAt;

  ImageData({
    required this.id,
    required this.fileSize,
    required this.filePath,
    required this.contentType,
    required this.createdAt,
  });

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      id: json['id'],
      fileSize: json['file_size'],
      filePath: json['file_path'],
      contentType: json['content_type'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
