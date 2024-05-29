
import 'package:jual_rugi_app/core/domain/model/product_compare.dart';
import 'package:jual_rugi_app/data/repositories/compare_repository.dart';

class CompareUseCase {
  final CompareRepository _repository;

  CompareUseCase(this._repository);

  List<ProductCompare> getDummyProducts() {
    return _repository.getDummyProducts();
  }
}
