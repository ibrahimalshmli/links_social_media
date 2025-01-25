
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:links_social_media/ligin/network/endpoints.dart';
import 'package:links_social_media/ligin/network/save_token.dart';

class EditProvider with ChangeNotifier {
  Future<void> editLink({
    required String id,
    required String title,
    required String link,
    required String username,
  }) async {
    try {
      final token = await SharedPreferencesHelper.getToken();

      final response = await http.put(
        Uri.parse("${Endpoints.edtlinks}  $id"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({"title": title, "link": link, "username": username}),
      );

      if (response.statusCode == 200) {
        debugPrint('Link updated successfully');
        notifyListeners();
      } else {
        throw Exception('Failed to update link: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error updating link: $e');
      rethrow;
    }
  }
}
