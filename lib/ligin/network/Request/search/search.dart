// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:links_social_media/ligin/network/endpoints.dart';
//
// import '../../../../model/mymodel.dart';
// import '../../save_token.dart';
//
// class FetchUser extends ChangeNotifier {
//   List<User> users = [];
//   Future<List<User>?> searchUser(String name, BuildContext context) async {
//     final String? token = await SharedPreferencesHelper.getToken();
//     print(token);
//     if (token == null) {
//       print("Error: Token not found.");
//     }
//     try {
//       String? token = await SharedPreferencesHelper.getToken();
//
//       if (token == null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Token not found. Please login again.')),
//         );
//         return [];
//       }
//
//       var response = await http.post(
//         Uri.parse(Endpoints.search),
//         headers: {"Authorization": "Bearer $token"},
//         body: {
//           "name": name, // Corrected to use .text
//         },
//       );
//       if (response.statusCode == 200) {
//         print(response.statusCode);
//
//         final responseData = json.decode(response.body);
//         print(responseData);
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text('Exception: $e')));
//       print(e);
//     }
//   }
// }
// import 'dart:convert';
//
// import 'package:http/http.dart' as http;
// import 'package:links_social_media/ligin/network/endpoints.dart';
//
// import '../../save_token.dart';
//
// Future<Map<String, dynamic>?> searchByName(String name) async {
//   final String? token = await SharedPreferencesHelper.getToken();
//   final url = Uri.parse(Endpoints.search);
//   final response = await http.post(
//     url,
//     headers: {
//       'Authorization': 'Bearer $token',
//       //'Content-Type': 'application/x-www-form-urlencoded',
//     },
//     body: {'name': name},
//   );
//
//   if (response.statusCode == 200) {
//     return jsonDecode(response.body);
//   } else {
//     print('Error: ${response.statusCode}');
//     return null;
//   }
// }
