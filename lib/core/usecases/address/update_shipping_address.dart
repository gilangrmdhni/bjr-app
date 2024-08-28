import 'package:jual_rugi_app/data/repositories/shipping_address_repository.dart';

class UpdateShippingAddress {
  final ShippingAddressRepository repository;

  UpdateShippingAddress(this.repository);

  Future<void> call(int id, Map<String, dynamic> data) async {
    return await repository.updateShippingAddress(id, data);
  }
}
