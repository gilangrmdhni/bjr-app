import 'package:jual_rugi_app/core/domain/model/shipping_address_model.dart';
import 'package:jual_rugi_app/data/repositories/shipping_address_repository.dart';

class GetShippingAddresses {
  final ShippingAddressRepository repository;

  GetShippingAddresses(this.repository);

  Future<List<ShippingAddress>> call() async {
    return await repository.getShippingAddresses();
  }
}
