// // // import 'dart:convert';
// // //
// // // import 'package:flutter/material.dart';
// // // import 'package:geolocator/geolocator.dart';
// // // import 'package:http/http.dart' as http;
// // // import 'package:links_social_media/ligin/network/endpoints.dart';
// // // import 'package:links_social_media/ligin/screen/Login_Screen.dart';
// // // import 'package:shared_preferences/shared_preferences.dart';
// // //
// // // Future<void> Register({
// // //   required BuildContext context,
// // //   required String name,
// // //   required String email,
// // //   required String password,
// // //   required String passwordConfirmation,
// // // }) async {
// // //   try {
// // //     // الحصول على الموقع الجغرافي
// // //     Position position = await Geolocator.getCurrentPosition(
// // //       desiredAccuracy: LocationAccuracy.high,
// // //     );
// // //
// // //     double latitude = position.latitude;
// // //     double longitude = position.longitude;
// // //
// // //     // إرسال بيانات التسجيل إلى الخادم
// // //     final response = await http.post(
// // //       Uri.parse(Endpoints.register), // رابط API الخاص بالتسجيل
// // //       headers: {'Content-Type': 'application/json'},
// // //       body: jsonEncode({
// // //         "name": name,
// // //         "email": email,
// // //         "password": password,
// // //         "password_confirmation": passwordConfirmation,
// // //         "lat": latitude.toString(),
// // //         "long": longitude.toString(),
// // //       }),
// // //     );
// // //
// // //     // التحقق من نجاح الاستجابة
// // //     if (response.statusCode == 200) {
// // //       final data = jsonDecode(response.body);
// // //
// // //       // استخراج `id` الخاص بالمستخدم
// // //       final int userId = data['id']; // تأكد من وجود `id` في الاستجابة
// // //       print('User ID: $userId');
// // //
// // //       // تخزين `id` في SharedPreferences
// // //       final prefs = await SharedPreferences.getInstance();
// // //       await prefs.setInt('user_id', userId);
// // //
// // //       // التنقل إلى الشاشة التالية أو تسجيل الدخول
// // //       Navigator.pushReplacement(
// // //         context,
// // //         MaterialPageRoute(builder: (_) => LoginScreen()),
// // //       );
// // //     } else {
// // //       throw Exception('Failed to register: ${response.body}');
// // //     }
// // //   } catch (e) {
// // //     print('Error: $e');
// // //     ScaffoldMessenger.of(
// // //       context,
// // //     ).showSnackBar(SnackBar(content: Text('An error occurred: $e')));
// // //   }
// // // }
// // //
// // // Future<int?> getUserId() async {
// // //   final prefs = await SharedPreferences.getInstance();
// // //   return prefs.getInt('user_id'); // إرجاع `id` أو `null` إذا لم يتم تخزينه
// // // }
// // import 'package:flutter/material.dart';
// // import 'package:links_social_media/ligin/network/endpoints.dart';
// // import 'package:links_social_media/ligin/network/networkhelber.dart';
// // import 'package:links_social_media/ligin/screen/Login_Screen.dart';
// //
// // Future<void> Register({
// //   required BuildContext context,
// //   required String name,
// //   required String email,
// //   required String password,
// //   required String password_confirmation,
// // }) async {
// //   try {
// //     Map<String, dynamic>? response = await NetworkHelper.postData(
// //       Endpoints.register,
// //
// //       body: {
// //         "name": name, // Corrected to use .text
// //         "email": email,
// //         "password": password,
// //         "password_confirmation": password_confirmation,
// //       },
// //     );
// //
// //     // Navigate to HomeScreen
// //     Navigator.pushReplacement(
// //       context,
// //       MaterialPageRoute(
// //         builder: (_) {
// //           return LoginScreen();
// //         },
// //       ),
// //     );
// //   } catch (e) {
// //     ScaffoldMessenger.of(
// //       context,
// //     ).showSnackBar(SnackBar(content: Text(e.toString())));
// //     print(e.toString());
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:links_social_media/ligin/network/endpoints.dart';
// import 'package:links_social_media/ligin/network/networkhelber.dart';
// import 'package:links_social_media/ligin/screen/Login_Screen.dart';
//
// Future<void> Register({
//   required BuildContext context,
//   required String name,
//   required String email,
//   required String password,
//   required String password_confirmation,
// }) async {
//   try {
//     Map<String, dynamic>? response = await NetworkHelper.postData(
//       Endpoints.register,
//
//       body: {
//         "name": name, // Corrected to use .text
//         "email": email,
//         "password": password,
//         "password_confirmation": password_confirmation,
//       },
//     );
//
//     // Navigate to HomeScreen
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (_) {
//           return LoginScreen();
//         },
//       ),
//     );
//   } catch (e) {
//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(SnackBar(content: Text(e.toString())));
//     print(e.toString());
//   }
// }

import 'package:flutter/material.dart';
import 'package:links_social_media/ligin/network/endpoints.dart';
import 'package:links_social_media/ligin/network/networkhelber.dart';
import 'package:links_social_media/ligin/screen/Login_Screen.dart';

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
          return LoginScreen();
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
