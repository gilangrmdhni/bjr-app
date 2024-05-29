class ProductCompare {
  final List<String> images;
  final String name;
  final int price;
  final String description;
  final int stock;
  final bool harmful;
  final bool liquid;
  final bool flammable;
  final bool fragile;
  final String category;
  final String store;

  ProductCompare({
    required this.images,
    required this.name,
    required this.price,
    required this.description,
    required this.stock,
    required this.harmful,
    required this.liquid,
    required this.flammable,
    required this.fragile,
    required this.category,
    required this.store,
  });
}
