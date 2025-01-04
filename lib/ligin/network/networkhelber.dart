import 'dart:convert';

import 'package:http/http.dart';
import 'package:links_social_media/ligin/network/endpoints.dart';

class NetworkHelper {
  static Future<Map<String, dynamic>?> getData(
    String url,
    Map<String, String>? headers,
  ) async {
    Response response = await get(
      Uri.parse(url),
      headers: {"Authorization": Endpoints.token},
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
      headers: {"Authorization": Endpoints.token},
      body: body,
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      return map;
    }
    return null;
  }

  static Future<Map<String, dynamic>?> PutData(
    String url, {
    Map<String, String>? headers,
    Map<String, String>? body,
  }) async {
    Response response = await put(
      Uri.parse(url),
      headers: {"Authorization": Endpoints.token},
      body: body,
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      return map;
    }
    return null;
  }

  static Future<Map<String, dynamic>?> deleteData(
    String url, {
    Map<String, String>? headers,
    required Map<String, String> body,
  }) async {
    Response response = await delete(
      Uri.parse(url),
      headers: {"Authorization": Endpoints.token},
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
