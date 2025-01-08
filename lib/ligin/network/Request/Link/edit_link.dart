import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:links_social_media/ligin/network/endpoints.dart';
import 'package:links_social_media/screens/Profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> EditLink({
  required BuildContext context,
  required String title,
  required String link,
  required String username,
  required String isActive,
}) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    var headers = {'Content-Type': 'application/json', 'Authorization': token};
    var request = http.Request('PUT', Uri.parse(Endpoints.links));
    request.body = json.encode({
      "title": "linkedin",
      "link": "www",
      "username": "www",
      "isActive": 1,
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }

    //Navigate to HomeScreen

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) {
          return ProfileScreen();
        },
      ),
    );
  } catch (e) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(e.toString())));
    print(e.toString());
  }
}
