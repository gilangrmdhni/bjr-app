import 'package:jual_rugi_app/core/domain/model/product_compare.dart';
import 'package:jual_rugi_app/core/usecases/compare_usecase.dart';

class CompareController {
  final CompareUseCase _useCase;

  CompareController(this._useCase);

  List<ProductCompare> getDummyProducts() {
    return _useCase.getDummyProducts();
  }
}
