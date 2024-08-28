import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:jual_rugi_app/core/domain/model/shipping_address_model.dart';

abstract class ShippingAddressRepository {
  Future<List<ShippingAddress>> getShippingAddresses();
  Future<void> addShippingAddress(Map<String, dynamic> data);
  Future<void> updateShippingAddress(int id, Map<String, dynamic> data);
}

class ShippingAddressRepositoryImpl implements ShippingAddressRepository {
  final String baseUrl = 'https://api.igarage.nuncorp.id/api/v1/users/shipping-address';

  @override
  Future<List<ShippingAddress>> getShippingAddresses() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['body'] as List)
          .map((address) => ShippingAddress.fromJson(address))
          .toList();
    } else {
      throw Exception('Failed to load shipping addresses');
    }
  }

  @override
  Future<void> addShippingAddress(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to add shipping address');
    }
  }

  @override
  Future<void> updateShippingAddress(int id, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse('$baseUrl/id/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update shipping address');
    }
  }
}
