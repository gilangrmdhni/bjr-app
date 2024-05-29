class WishlistProduct {
  final String name;
  final double originalPrice;
  final double discountPrice;
  final int discount;
  final String category;
  final String location;
  final List<String> images;
  final double rating;

  WishlistProduct({
    required this.name,
    required this.originalPrice,
    required this.discountPrice,
    required this.discount,
    required this.category,
    required this.location,
    required this.images,
    required this.rating,
  });
}
