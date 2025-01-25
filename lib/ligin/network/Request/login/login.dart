// // // // import 'package:flutter/material.dart';
// // // // import 'package:links_social_media/ligin/network/networkhelber.dart';
// // // // import 'package:links_social_media/screens/homescrren.dart';
// // // //
// // // // import '../endpoints.dart';
// // // //
// // // // Future<void> login({
// // // //   required BuildContext context,
// // // //   required String email,
// // // //   required String password,
// // // // }) async {
// // // //   try {
// // // //     Map<String, dynamic>? response = await NetworkHelper.postData(
// // // //       Endpoints.login,
// // // //       body: {"email": email, "password": password},
// // // //     );
// // // //     if (response.statusCode == 200) {
// // // //       // تحليل الاستجابة
// // // //       final data = jsonDecode(response.body);
// // // //
// // // //       if (data['token'] != null) {
// // // //         // حفظ التوكين في SharedPreferences
// // // //         final prefs = await SharedPreferences.getInstance();
// // // //         await prefs.setString('access_token', data['token']);
// // // //
// // // //         print("Token saved: ${data['token']}");
// // // //       } else {
// // // //         print("Login failed: No token received");
// // // //       }
// // // //     } else {
// // // //       print("Login failed: ${response.statusCode}");
// // // //     }
// // // //
// // // //     Navigator.pushReplacement(
// // // //       context,
// // // //       MaterialPageRoute(
// // // //         builder: (_) {
// // // //           return HomeScreen();
// // // //         },
// // // //       ),
// // // //     );
// // // //   } catch (e, s) {
// // // //     ScaffoldMessenger.of(
// // // //       context,
// // // //     ).showSnackBar(SnackBar(content: Text('###########${e.toString()}')));
// // // //   }
// // // // }
// // // import 'package:flutter/material.dart';
// // // import 'package:links_social_media/ligin/network/networkhelber.dart';
// // // import 'package:links_social_media/screens/homescrren.dart';
// // // import 'package:shared_preferences/shared_preferences.dart';
// // //
// // // import '../endpoints.dart';
// // //
// // // Future<void> login({
// // //   required BuildContext context,
// // //   required String email,
// // //   required String password,
// // // }) async {
// // //   try {
// // //     // استدعاء الطلب
// // //     Map<String, dynamic>? response = await NetworkHelper.postData(
// // //       Endpoints.login,
// // //       body: {"email": email, "password": password},
// // //     );
// // //
// // //     if (response != null && response['token'] != null) {
// // //       // حفظ التوكين في SharedPreferences
// // //       final prefs = await SharedPreferences.getInstance();
// // //       await prefs.setString('access_token', response['token']);
// // //
// // //       print("Token saved: ${response['token']}");
// // //
// // //       // الانتقال إلى الشاشة الرئيسية
// // //       Navigator.pushReplacement(
// // //         context,
// // //         MaterialPageRoute(builder: (_) => HomeScreen()),
// // //       );
// // //     } else {
// // //       // إذا لم يتم العثور على التوكين
// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         SnackBar(content: Text('Login failed: No token received')),
// // //       );
// // //     }
// // //   } catch (e) {
// // //     // التعامل مع الأخطاء
// // //     ScaffoldMessenger.of(
// // //       context,
// // //     ).showSnackBar(SnackBar(content: Text('Exception: ${e.toString()}')));
// // //   }
// // // }
// // //
// // import 'dart:convert';
// //
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:links_social_media/screens/homescrren.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// //
// // import '../../endpoints.dart';
// //
// // Future<void> login({
// //   required BuildContext context,
// //   required String email,
// //   required String password,
// // }) async {
// //   try {
// //     // بناء عنوان API
// //     final url = Uri.parse(Endpoints.login);
// //
// //     // إرسال طلب POST إلى API
// //     final response = await http.post(
// //       url,
// //       headers: {'Content-Type': 'application/json'},
// //       body: jsonEncode({'email': email, 'password': password}),
// //     );
// //
// //     // التحقق من حالة الاستجابة
// //     if (response.statusCode == 200) {
// //       // تحليل الاستجابة
// //       final data = jsonDecode(response.body);
// //
// //       // التحقق من وجود التوكين
// //       if (data['token'] != null) {
// //         // حفظ التوكين في SharedPreferences
// //         final prefs = await SharedPreferences.getInstance();
// //         await prefs.setString('access_token', data['token']);
// //
// //         print("Token saved: ${data['token']}");
// //
// //         // الانتقال إلى الشاشة الرئيسية
// //         Navigator.pushReplacement(
// //           context,
// //           MaterialPageRoute(builder: (_) => HomeScreen()),
// //         );
// //       } else {
// //         // رسالة خطأ عند غياب التوكين
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(content: Text('Login failed: No token received.')),
// //         );
// //       }
// //     } else {
// //       // رسالة خطأ عند فشل الطلب
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text('Login failed: ${response.statusCode}')),
// //       );
// //     }
// //   } catch (e) {
// //     // التعامل مع الأخطاء
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(content: Text('An error occurred: ${e.toString()}')),
// //     );
// //   }
// // }
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:links_social_media/screens/homescrren.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../endpoints.dart';
//
// Future<void> login({
//   required BuildContext context,
//   required String email,
//   required String password,
// }) async {
//   try {
//     // بناء عنوان API
//     final url = Uri.parse(Endpoints.login);
//
//     // إرسال طلب POST إلى API
//     final response = await http.post(
//       url,
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'email': email, 'password': password}),
//     );
//
//     // التحقق من حالة الاستجابة
//     if (response.statusCode == 200) {
//       // تحليل الاستجابة
//       final data = jsonDecode(response.body);
//
//       // التحقق من وجود التوكين وبيانات المستخدم
//       if (data['token'] != null && data['user'] != null) {
//         // استخراج user_id
//         final userId = data['user']['id'];
//         print("User ID: $userId");
//
//         // حفظ التوكين في SharedPreferences
//         final prefs = await SharedPreferences.getInstance();
//         await prefs.setString('access_token', data['token']);
//
//         print("Token saved: ${data['token']}");
//
//         // حفظ user_id في SharedPreferences
//         await prefs.setInt('user_id', userId);
//
//         // الانتقال إلى الشاشة الرئيسية
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => HomeScreen()),
//         );
//       } else {
//         // رسالة خطأ عند غياب التوكين أو user_id
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Login failed: Missing token or user data.')),
//         );
//       }
//     } else {
//       // رسالة خطأ عند فشل الطلب
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Login failed: ${response.statusCode}')),
//       );
//     }
//   } catch (e) {
//     // التعامل مع الأخطاء
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('An error occurred: ${e.toString()}')),
//     );
//   }
// }
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:links_social_media/screens/homescrren.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../endpoints.dart';

Future<void> login({
  required BuildContext context,
  required String email,
  required String password,
}) async {
  try {
    // بناء عنوان API
    final url = Uri.parse(Endpoints.login);

    // إرسال طلب POST إلى API
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    // التحقق من حالة الاستجابة
    if (response.statusCode == 200) {
      // تحليل الاستجابة
      final data = jsonDecode(response.body);

      // التحقق من وجود التوكين وبيانات المستخدم
      if (data['token'] != null && data['user'] != null) {
        // استخراج user_id
        final userId = data['user']['id'];
        print("User ID: $userId");

        // حفظ التوكين وuser_id في SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', data['token']);
        await prefs.setInt('user_id', userId); // حفظ user_id كقيمة عددية

        print("Token saved: ${data['token']}");
        print("User ID saved: $userId");

        // الانتقال إلى الشاشة الرئيسية
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomeScreen()),
        );
      } else {
        // رسالة خطأ عند غياب التوكين أو user_id
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: Missing token or user data.')),
        );
      }
    } else {
      // رسالة خطأ عند فشل الطلب
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: ${response.statusCode}')),
      );
    }
  } catch (e) {
    // التعامل مع الأخطاء
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('An error occurred: ${e.toString()}')),
    );
  }
}

Future<int?> getUserId() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt('user_id'); // استرجاع user_id
}
