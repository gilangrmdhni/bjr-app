import 'package:jual_rugi_app/core/domain/model/product_compare.dart';

class CompareRepository {
  List<ProductCompare> getDummyProducts() {
    return [
      ProductCompare(
        images: [
          'assets/images/products/iphone_12_blue.png',
        ],
        name: 'Iphone 12 Blue 64gb IBOX',
        price: 100000,
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        stock: 50,
        harmful: false,
        liquid: false,
        flammable: false,
        fragile: false,
        category: 'Electronics',
        store: 'Tech Store',
      ),
      ProductCompare(
        images: [
          'assets/images/products/NikeAirJordonSingleOrange.png',
        ],
        name: 'Nike Air Jordan Black and red',
        price: 120000,
        description:
            'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        stock: 30,
        harmful: true,
        liquid: false,
        flammable: true,
        fragile: true,
        category: 'Home Appliances',
        store: 'Home Goods',
      ),
    ];
  }
}
