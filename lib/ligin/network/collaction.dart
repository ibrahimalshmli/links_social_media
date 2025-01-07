import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:links_social_media/ligin/network/endpoints.dart';
import 'package:links_social_media/ligin/network/networkhelber.dart';
import 'package:links_social_media/model/mymodel.dart';
import 'package:links_social_media/screens/Profile_screen.dart';
import 'package:links_social_media/screens/homescrren.dart';

class Colaction extends ChangeNotifier {
  LinkMymodel? linkModel;

  //تسجيل الدخول
  Future<void> login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      Map<String, dynamic>? response = await NetworkHelper.postData(
        Endpoints.login,
        body: {"email": email, "password": password},
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) {
            return HomeScreen();
          },
        ),
      );
    } catch (e, s) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  // كولكشن تسجيل حساب جديد
  Future<void> Register({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
    required String password_confirmation,
  }) async {
    try {
      Map<String, dynamic>? response = await NetworkHelper.postData(
        Endpoints.register,
        body: {
          "name": name, // Corrected to use .text
          "email": email,
          "password": password,
          "password_confirmation": password_confirmation,
        },
      );

      // Navigate to HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) {
            return HomeScreen();
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

  // كولكشن تسجيل رابط جديد
  Future<void> AddLink({
    required BuildContext context,
    required String title,
    required String link,
    required String username,
    required String isActive,
  }) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Endpoints.token}',
      };
      var request = http.Request('POST', Uri.parse(Endpoints.links));
      request.body = json.encode({
        "title": title,
        "link": link,
        "username": username,
        "isActive": isActive,
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
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
}
