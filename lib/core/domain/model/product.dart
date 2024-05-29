class Product {
  final int id;
  final String name;
  final int originalPrice;
  final int discountPrice;
  final num discount;
  final Category category;
  final List<ImageModel> images;

  Product({
    required this.id,
    required this.name,
    required this.originalPrice,
    required this.discountPrice,
    required this.discount,
    required this.category,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['body']['id'],
      name: json['body']['name'],
      originalPrice: json['body']['original_price'],
      discountPrice: json['body']['discount_price'],
      discount: json['body']['discount'],
      category: Category.fromJson(json['body']['category']),
      images: (json['body']['images'] as List<dynamic>)
          .map((imageJson) => ImageModel.fromJson(imageJson))
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

class ImageModel {
  final int id;
  final int fileSize;
  final String filePath;
  final String contentType;
  final DateTime createdAt;

  ImageModel({
    required this.id,
    required this.fileSize,
    required this.filePath,
    required this.contentType,
    required this.createdAt,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'],
      fileSize: json['file_size'],
      filePath: json['file_path'],
      contentType: json['content_type'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

