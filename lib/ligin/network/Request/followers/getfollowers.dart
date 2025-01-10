import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:links_social_media/ligin/network/endpoints.dart';
import 'package:links_social_media/ligin/network/save_token.dart';
import 'package:links_social_media/screens/Profile_screen.dart';

Future<void> postfollowers({id, required BuildContext context}) async {
  try {
    String? token = await SharedPreferencesHelper.getToken();

    print('##################${token}');

    // التحقق إذا كان التوكن موجودًا
    if (token == null) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(content: Text('Token not found. Please login again.')),
      );
      return;
    }
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': token,
    };
    var request = http.Request('GET', Uri.parse(Endpoints.follow));
    request.bodyFields = {'followee_id': id};
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => ProfileScreen()),
    );
  } catch (e) {
    // التعامل مع الاستثناءات
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Exception: $e')));
    print(e.toString());
  }
}
