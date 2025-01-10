// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:links_social_media/ligin/network/Request/Link/get_link.dart';
// import 'package:links_social_media/ligin/network/endpoints.dart';
// import 'package:provider/provider.dart';
//
// import '../../save_token.dart';
//
// // Future<void> editLink({
// //   required BuildContext context,
// //   required String title,
// //
// //   required String link,
// //   required String username,
// //   required bool isActive,
// // }) async {
// //   try {
// //     final getLinks = await Provider.of<GetLinks>(context, listen: false);
// //     String? token = await SharedPreferencesHelper.getToken();
// //
// //     if (token == null) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text('Token not found. Please login again.')),
// //       );
// //       return null;
// //     }
// //
// //     var headers = {
// //       'Content-Type': 'application/json',
// //       'Authorization': 'Bearer $token',
// //     };
// //
// //     var request = http.Request('PUT', Uri.parse("${Endpoints.edtlinks}"));
// //     request.body = json.encode({
// //       "title": title,
// //       "link": link,
// //       "username": username,
// //       "isActive": isActive,
// //     });
// //
// //     http.StreamedResponse response = await request.send();
// //
// //     if (response.statusCode == 200) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text('Link updated successfully!')),
// //       );
// //
// //       Navigator.pushReplacement(
// //         context,
// //         MaterialPageRoute(builder: (_) => ProfileScreen()),
// //       );
// //     } else {
// //       ScaffoldMessenger.of(
// //         context,
// //       ).showSnackBar(SnackBar(content: Text('Error: ${response.statusCode}')));
// //     }
// //   } catch (e) {
// //     print('Exception: $e');
// //     ScaffoldMessenger.of(
// //       context,
// //     ).showSnackBar(SnackBar(content: Text('Exception: $e')));
// //   }
// // }
// Future<void> editLink(
//   String id,
//   String newTitle,
//   String newLink,
//   BuildContext context,
// ) async {
//   try {
//     // الحصول على الـ token من التخزين
//     String? token = await SharedPreferencesHelper.getToken();
//
//     // إعداد البيانات الجديدة التي سيتم إرسالها في الطلب
//     final body = jsonEncode({
//       "title": newTitle, // العنوان الجديد
//       "link": newLink, // الرابط الجديد
//     });
//
//     // إرسال طلب التعديل باستخدام PUT
//     final response = await http.put(
//       Uri.parse("${Endpoints.edtlinks}$id"), // رابط التعديل مع ID
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $token',
//       },
//       body: body,
//     );
//
//     if (response.statusCode == 200) {
//       // نجاح العملية
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Link updated successfully!')),
//       );
//
//       // تحديث القائمة بعد التعديل
//
//       Provider.of<GetLinks>(context, listen: false).getLink(context);
//     } else {
//       // حالة فشل الطلب
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Failed to update link: ${response.statusCode}'),
//         ),
//       );
//     }
//   } catch (e) {
//     // التعامل مع الأخطاء
//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(SnackBar(content: Text('Error occurred: $e')));
//   }
// }
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:links_social_media/ligin/network/endpoints.dart';
import 'package:links_social_media/ligin/network/save_token.dart';

class EditProvider with ChangeNotifier {
  Future<void> editLink({
    required String id,
    required String title,
    required String link,
    required String username,
  }) async {
    try {
      final token = await SharedPreferencesHelper.getToken();

      final response = await http.put(
        Uri.parse("${Endpoints.edtlinks}  $id"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({"title": title, "link": link, "username": username}),
      );

      if (response.statusCode == 200) {
        debugPrint('Link updated successfully');
        notifyListeners();
      } else {
        throw Exception('Failed to update link: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error updating link: $e');
      rethrow;
    }
  }
}
