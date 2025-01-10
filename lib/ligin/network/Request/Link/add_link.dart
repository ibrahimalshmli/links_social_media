import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:links_social_media/ligin/network/endpoints.dart';
import 'package:links_social_media/ligin/network/save_token.dart';
import 'package:links_social_media/screens/Profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    // إرسال طلب POST لإضافة الرابط
    var response = await http.post(
      Uri.parse(Endpoints.links),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: json.encode({
        "title": title,
        "link": link,
        "username": username,
        "isActive": isActive,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['id'] != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('id', responseData['di']);
        final id = responseData['id'];

        if (id != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setInt('linkId', id);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${response.statusCode}')),
          );
        }
      }
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

Future<void> saveLinkId(int id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('linkId', id); // حفظ الـ id كـ int
  print('Link ID saved: $id');
}

Future<int?> getLinkId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int? linkId = prefs.getInt('id');
  print('#########################${linkId}');
}
