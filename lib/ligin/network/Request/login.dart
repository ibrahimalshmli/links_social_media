import 'package:flutter/material.dart';
import 'package:links_social_media/ligin/network/networkhelber.dart';
import 'package:links_social_media/screens/homescrren.dart';

import '../endpoints.dart';

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
