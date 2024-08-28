import 'package:get/get.dart';
import 'package:jual_rugi_app/core/domain/model/shipping_address_model.dart';
import 'package:jual_rugi_app/core/usecases/address/add_shipping_address.dart';
import 'package:jual_rugi_app/core/usecases/address/get_shipping_addresses.dart';
import 'package:jual_rugi_app/core/usecases/address/update_shipping_address.dart';

class ShippingAddressController extends GetxController {
  final GetShippingAddresses getShippingAddresses;
  final AddShippingAddress addShippingAddress;
  final UpdateShippingAddress updateShippingAddress;

  var addresses = <ShippingAddress>[].obs;
  var isLoading = true.obs;

  ShippingAddressController({
    required this.getShippingAddresses,
    required this.addShippingAddress,
    required this.updateShippingAddress,
  });

  @override
  void onInit() {
    fetchShippingAddresses();
    super.onInit();
  }

  void fetchShippingAddresses() async {
    try {
      isLoading(true);
      addresses.value = await getShippingAddresses();
    } finally {
      isLoading(false);
    }
  }

  void addAddress(Map<String, dynamic> data) async {
    try {
      await addShippingAddress(data);
      fetchShippingAddresses();
    } catch (e) {
      print(e);
    }
  }

  void updateAddress(int id, Map<String, dynamic> data) async {
    try {
      await updateShippingAddress(id, data);
      fetchShippingAddresses();
    } catch (e) {
      print(e);
    }
  }
}
