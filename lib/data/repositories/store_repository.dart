import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jual_rugi_app/core/domain/model/store_model.dart';

class StoreRepository {
  Future<Store?> registerStore(String name, String location) async {
    final String apiUrl = 'https://api.bjr-dev.nuncorp.id/ss/api/v1/stores';
    final Map<String, dynamic> payload = {
      'name': name,
      'location': location,
    };

    try {
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode(payload),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final Store store = Store.fromJson(responseData['body']);
        return store;
      } else {
        throw Exception(
            'Failed to register store. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error registering store: $error');
    }
  }

  Future<Store?> getStoreProfile(int userId) async {
    final String apiUrl =
        'https://api.bjr-dev.nuncorp.id/ss/api/v1/stores/user/$userId';

    try {
      final http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final Store store = Store.fromJson(responseData['body']);
        return store;
      } else {
        throw Exception(
            'Failed to get store profile. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error getting store profile: $error');
    }
  }
}
