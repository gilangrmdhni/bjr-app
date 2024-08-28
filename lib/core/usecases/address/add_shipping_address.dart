import 'package:jual_rugi_app/data/repositories/shipping_address_repository.dart';

class AddShippingAddress {
  final ShippingAddressRepository repository;

  AddShippingAddress(this.repository);

  Future<void> call(Map<String, dynamic> data) async {
    return await repository.addShippingAddress(data);
  }
}
