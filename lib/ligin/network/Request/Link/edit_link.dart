import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:links_social_media/ligin/network/Request/Link/add_link.dart';
import 'package:links_social_media/ligin/network/endpoints.dart';
import 'package:links_social_media/screens/Profile_screen.dart';

import '../../save_token.dart';

Future<void> editLink({
  required BuildContext context,
  required String title,
  required String link,
  required String username,
  required bool isActive,
}) async {
  try {
    int? linkId = await getLinkId();
    print('###########################${linkId}');
    String? token = await SharedPreferencesHelper.getToken();

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Token not found. Please login again.')),
      );
      return;
    }

    if (linkId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Link ID not found.')));
      return;
    }

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var request = http.Request(
      'PUT',
      Uri.parse("${Endpoints.edtlinks}/$linkId"),
    );

    request.body = json.encode({
      "title": title,
      "link": link,
      "username": username,
      "isActive": isActive ? 1 : 0,
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Link updated successfully!')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => ProfileScreen()),
      );
    } else {
      // إضافة مزيد من المعلومات للتتبع في حالة الخطأ
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error: ${response.statusCode}, ${response.reasonPhrase}',
          ),
        ),
      );
    }
  } catch (e) {
    print('Exception: $e');
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Exception: $e')));
  }
}
