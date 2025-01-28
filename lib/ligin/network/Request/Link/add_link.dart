import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:links_social_media/network/endpoints.dart';
import 'package:links_social_media/screens/Profile_screen.dart';

import '../../../../network/save_token.dart';

Future<void> AddLink({
  required BuildContext context,
  required String title,
  required String link,
  required String username,
  required String isActive,
}) async {
  try {
    // جلب التوكن من SharedPreferences
    String? token = await SharedPreferencesHelper.getToken();

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Token not found. Please login again.')),
      );
      return;
    }

    var response = await http.post(
      Uri.parse(Endpoints.links),
      // headers: {
      //   "Authorization": "Bearer $token",
      //   "Content-Type": "application/json",
      // },
      body: json.encode({
        "title": title,
        "link": link,
        "username": username,
        "isActive": isActive,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => ProfileScreen()),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Exception: $e')));
  }
}
