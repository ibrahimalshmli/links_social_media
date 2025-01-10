import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:links_social_media/ligin/network/endpoints.dart';
import 'package:links_social_media/ligin/network/save_token.dart';
import 'package:links_social_media/model/mymodel.dart';

class GetLinks extends ChangeNotifier {
  List<LinkMymodel> linkMymodel = [];

  Future<void> getLink(String url, BuildContext context) async {
    try {
      String? token = await SharedPreferencesHelper.getToken();

      if (token == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Token not found. Please login again.')),
        );
        return;
      }

      Response response = await get(
        Uri.parse(Endpoints.links),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        Map<String, dynamic>? map = jsonDecode(response.body);
        if (map != null) {
          List list = map["links"];
          linkMymodel =
              list
                  .map(
                    (item) => LinkMymodel(
                      id: item['id'],
                      title: item["title"],
                      link: item["link"],
                      username: item["username"],
                      isActive: item["isActive"],
                    ),
                  )
                  .toList();
          notifyListeners();
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.statusCode}')),
        );
      }
    } catch (e) {
      print('Exception: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Exception: $e')));
    }
  }
}
