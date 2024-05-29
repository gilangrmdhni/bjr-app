// // user_repository.dart
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class UserRepository {
//   final String baseUrl = 'https://api.bjr-dev.nuncorp.id/as/api/v1';

//   UserRepository();

//   Future<String?> loginUser(String email, String password) async {
//     try {
//       final response = await http.post(
//         Uri.parse('$baseUrl/auth/signin'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({'email': email, 'password': password}),
//       );

//       print('Response status code: ${response.statusCode}');
//       print('Response body: ${response.body}');

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> data = jsonDecode(response.body);
//         return data['access_token'];
//       } else {
//         return null;
//       }
//     } catch (e) {
//       print('Error parsing JSON: $e');
//       throw ArgumentError('Invalid JSON format');
//     }
//   }

//   Future<bool> registerUser(String username, String email, String password) async {
//     try {
//       final response = await http.post(
//         Uri.parse('$baseUrl/auth/signup'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({'username': username, 'email': email, 'password': password}),
//       );

//       return response.statusCode == 200;
//     } catch (e) {
//       print('Error dusring registration: $e');
//       return false;
//     }
//   }
// }
