// // import 'dart:core';
// //
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:links_social_media/ligin/network/Request/Link/get_link.dart';
// // import 'package:links_social_media/ligin/network/endpoints.dart';
// // import 'package:links_social_media/screens/Profile_screen.dart';
// // import 'package:provider/provider.dart';
// //
// // import '../../save_token.dart';
// //
// // Future<void> deleteLink(BuildContext context) async {
// //   try {
// //     final getLinks = Provider.of<GetLinks>(context, listen: false);
// //     String? token = await SharedPreferencesHelper.getToken();
// //
// //     if (token == null) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text('Token not found. Please login again.')),
// //       );
// //       return;
// //     }
// //
// //     // إعداد طلب HTTP
// //     var headers = {
// //       'Content-Type': 'application/json',
// //       'Authorization': 'Bearer $token',
// //     };
// //
// //     var response = await http.delete(
// //       Uri.parse("${Endpoints.edtlinks}/${getLinks.getSelectedId}"),
// //       headers: headers,
// //     );
// //
// //     if (response.statusCode == 200) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text('Link deleted successfully!')),
// //       );
// //
// //       await getLinks.getLink(context);
// //
// //       Navigator.pushReplacement(
// //         context,
// //         MaterialPageRoute(builder: (_) => ProfileScreen()),
// //       );
// //     } else {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(
// //           content: Text('Error: ${response.statusCode} - ${response.body}'),
// //         ),
// //       );
// //     }
// //   } catch (e) {
// //     print('Exception: $e');
// //     ScaffoldMessenger.of(
// //       context,
// //     ).showSnackBar(SnackBar(content: Text('Exception: $e')));
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:links_social_media/ligin/network/endpoints.dart';
// import 'package:links_social_media/model/mymodel.dart';
//
// class DeleteLinks with ChangeNotifier {
//   List<LinkMymodel> _links = [];
//   String? _selectedId;
//
//   List<LinkMymodel> get links => _links;
//   String? get getSelectedId => _selectedId;
//
//   void setSelectedId(String? id) {
//     _selectedId = id;
//     notifyListeners();
//   }
//
//   Future<void> deleteLink(BuildContext context, String? token) async {
//     if (token == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Token not found. Please login again.')),
//       );
//       return;
//     }
//
//     try {
//       var headers = {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $token',
//       };
//
//       var response = await http.delete(
//         Uri.parse("${Endpoints.edtlinks}/$_selectedId"),
//         headers: headers,
//       );
//
//       if (response.statusCode == 200) {
//         _links.removeWhere((LinkMymodel) => LinkMymodel.id == _selectedId);
//         notifyListeners();
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Link deleted successfully!')),
//         );
//
//         await deleteLink(context, token); // لجلب البيانات الجديدة بعد الحذف
//       } else {
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(SnackBar(content: Text('Error: ${response.body}')));
//         print(response.body);
//       }
//     } catch (e) {
//       print('Exception: $e');
//       // ScaffoldMessenger.of(
//       //   context,
//       // ).showSnackBar(SnackBar(content: Text('Exception: $e')));
//     }
//   }
// }
