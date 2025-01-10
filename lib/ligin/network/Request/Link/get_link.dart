import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:links_social_media/ligin/network/endpoints.dart';
import 'package:links_social_media/ligin/network/save_token.dart';
import 'package:links_social_media/model/mymodel.dart';

class GetLinks extends ChangeNotifier {
  List<LinkMymodel> linkMymodel = [];
  // int? selectedId;
  Future<void> getLink(BuildContext context) async {
    try {
      final token = await SharedPreferencesHelper.getToken();
      if (token == null) {
        _showMessage(context, 'Token not found. Please login again.');
        return;
      }

      final response = await http.get(
        Uri.parse(Endpoints.links),
        headers: _buildHeaders(token),
      );

      if (response.statusCode == 200) {
        _handleSuccessResponse(response.body);
      } else {
        _showMessage(context, 'Error: ${response.statusCode}');
      }
    } catch (e) {
      _showMessage(context, 'Exception: $e');
    }
  }

  void _handleSuccessResponse(String responseBody) async {
    final Map<String, dynamic>? map = jsonDecode(responseBody);
    if (map != null && map.containsKey('links')) {
      final List list = map['links'];

      linkMymodel =
          list
              .map(
                (item) => LinkMymodel(
                  id: item['id'],
                  title: item['title'],
                  link: item['link'],
                  username: item['username'],
                  isActive: item['isActive'],
                ),
              )
              .toList();

      notifyListeners();
    }
  }

  Map<String, String> _buildHeaders(String token) {
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  //
  // void setSelectedId(int? id) {
  //   selectedId = id.t;
  //   notifyListeners();
  // }
  //
  // int? get getSelectedId => selectedId;
}
