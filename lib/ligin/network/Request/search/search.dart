import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:links_social_media/network/endpoints.dart';

import '../../../../model/mymodel.dart';
import '../../../../network/save_token.dart';

class FetchUser extends ChangeNotifier {
  List<User> users = [];

  Future<List<User>?> searchUser(String name, BuildContext context) async {
    final String? token = await SharedPreferencesHelper.getToken();
    print(token);
    if (token == null) {
      print("Error: Token not found.");
      return [];
    }

    try {
      var response = await http.post(
        Uri.parse(Endpoints.search),
        headers: {"Authorization": "Bearer $token"},
        body: {"name": name},
      );
      print(name);
      print(users.length);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['user'] != null) {
          print("#########@@@@@${responseData}");
          List<dynamic> userList = responseData['user'];
          print("#423562e4${userList}");
          users =
              userList
                  .map((e) => User.fromJson(Map<String, dynamic>.from(e)))
                  .toList();
          notifyListeners();
          print(users);
          return users;
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.statusCode}')),
        );
        return [];
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Exception: $e')));
      print(e);
    }
  }
}
