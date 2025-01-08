import 'package:flutter/material.dart';
import 'package:links_social_media/ligin/network/endpoints.dart';
import 'package:links_social_media/ligin/network/networkhelber.dart';
import 'package:links_social_media/screens/homescrren.dart';

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
