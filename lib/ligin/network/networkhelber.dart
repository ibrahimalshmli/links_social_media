import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:links_social_media/ligin/network/save_token.dart';

class NetworkHelper {
  static Future<Map<String, dynamic>?> getData(
    String url,
    Map<String, String>? headers,
    BuildContext context,
  ) async {
    String? token = await SharedPreferencesHelper.getToken();

    print('##################${token}');

    // التحقق إذا كان التوكن موجودًا
    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Token not found. Please login again.')),
      );
    }
    Response response = await get(
      Uri.parse(url),
      headers: {"Authorization": token!},
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      return map;
    }
    return null;
  }

  static Future<Map<String, dynamic>?> postData(
    String url, {
    Map<String, String>? headers,
    Map<String, String>? body,
  }) async {
    Response response = await post(
      Uri.parse(url),
      //  headers: {"Authorization": token!},
      body: body,
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      return map;
    }
    return null;
  }

  static Future<Map<String, dynamic>?> PutData(
    BuildContext context,
    String url, {
    Map<String, String>? headers,
    Map<String, String>? body,
  }) async {
    String? token = await SharedPreferencesHelper.getToken();

    print('##################${token}');

    // التحقق إذا كان التوكن موجودًا
    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Token not found. Please login again.')),
      );
    }
    Response response = await put(
      Uri.parse(url),
      headers: {"Authorization": token!},
      body: body,
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      return map;
    }
    return null;
  }

  static Future<Map<String, dynamic>?> deleteData(
    BuildContext context,
    String url, {
    Map<String, String>? headers,
    required Map<String, String> body,
  }) async {
    String? token = await SharedPreferencesHelper.getToken();

    print('##################${token}');

    // التحقق إذا كان التوكن موجودًا
    if (token == null) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(content: Text('Token not found. Please login again.')),
      );
    }
    Response response = await delete(
      Uri.parse(url),
      headers: {"Authorization": token!},
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      return map;
    }
    return null;
  }

  static Map<String, dynamic> handelResponse(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        {
          Map<String, dynamic> map = jsonDecode(response.body);
          return map;
        }
      case 400:
        Map<String, dynamic> map = jsonDecode(response.body);
        throw map['message'];
      default:
        {
          throw "NetWork Error";
        }
    }
  }
}
