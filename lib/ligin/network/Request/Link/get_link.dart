import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:links_social_media/ligin/network/endpoints.dart';
import 'package:links_social_media/model/mymodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetLinks extends ChangeNotifier {
  List<LinkMymodel> linkMymodel = [];
  late BuildContext context;

  Future<void> getLink(String url) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      Response response = await get(
        Uri.parse(Endpoints.links),
        headers: {"Authorization": token!, "Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic>? map = jsonDecode(response.body);
        if (map != null) {
          List list = map["links"];
          for (int i = 0; i < list.length; i++) {
            linkMymodel.add(
              LinkMymodel(
                title: list[i]["title"],
                link: list[i]["link"],
                username: list[i]["username"],
                isActive: list[i]["isActive"],
              ),
            );
          }
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Exception: $e')));
    }
  }
}
