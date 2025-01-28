import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:links_social_media/network/endpoints.dart';

import '../../../../model/activemodel.dart';
import '../../../../network/save_token.dart';
import '../login/login.dart';

class ActiveSharingProvider with ChangeNotifier {
  List<NearestUser> nearestUsers = [];
  bool isLoading = false;

  Future<void> fetchNearestUsers() async {
    final token = await SharedPreferencesHelper.getToken();

    final userId = await getUserId();
    isLoading = true;
    notifyListeners();

    final response = await http.get(
      Uri.parse("${Endpoints.activnearest}$userId"),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      nearestUsers = ActiveModel.fromJson(data).nearestUsers;
    } else {
      throw Exception('Failed to load nearest users');
    }

    isLoading = false;
    notifyListeners();
  }

  Future<bool> setActiveSharing(String type) async {
    final token = await SharedPreferencesHelper.getToken();

    final userId = await getUserId();
    final response = await http.post(
      Uri.parse(
        "${Endpoints.activeShare}$userId",
      ), // استبدل بالـ endpoint الصحيح
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'type': type}),
    );
    print(response.statusCode);
    print(userId);
    return response.statusCode == 200;
  }

  Future<bool> removeActiveSharing() async {
    final token = await SharedPreferencesHelper.getToken();
    final userId = await getUserId();

    final response = await http.delete(
      Uri.parse("${Endpoints.activeShare}$userId"),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    print(response.statusCode);
    print(userId);
    return response.statusCode == 200;
  }
}
