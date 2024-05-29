// core/usecases/get_products_usecase.dart

import 'package:jual_rugi_app/core/domain/model/product.dart';
import 'package:jual_rugi_app/data/repositories/product_repository.dart';

class GetProductsUseCase {
  final ProductRepository _repository;

  GetProductsUseCase(this._repository);

  Future<List<Product>> execute(int page) async {
    return _repository.getProducts(page);
  }
}
