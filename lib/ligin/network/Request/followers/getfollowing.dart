import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:links_social_media/network/endpoints.dart';

import '../../../../model/follower.dart';
import '../../../../network/save_token.dart';

class FollowApi extends ChangeNotifier {
  List<Following> following = [];

  Future<void> getfollow(BuildContext context) async {
    try {
      final token = await SharedPreferencesHelper.getToken();
      if (token == null) {
        _showMessage(context, 'Token not found. Please login again.');
        return;
      }
      print(token);

      final response = await http.get(
        Uri.parse(Endpoints.follow),
        headers: _buildHeaders(token),
      );

      if (response.statusCode == 200) {
        _handleSuccessResponse(response.body);
        print(response.body);
        print(response);
      } else {
        _showMessage(context, 'Error: ${response.statusCode}');
      }
    } catch (e) {
      _showMessage(context, 'Exception: $e');
    }
  }

  void _handleSuccessResponse(String responseBody) {
    try {
      final Map<String, dynamic> map = jsonDecode(responseBody);
      if (map.containsKey('following') && map['following'] is List) {
        following = List<Following>.from(
          map["following"].map((x) => Following.fromJson(x)),
        );
      } else {
        following = [];
        print("No 'links' field found or it's not a list.");
      }
      notifyListeners();
    } catch (e) {
      print("Error parsing response: $e");
      following = [];
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
}
