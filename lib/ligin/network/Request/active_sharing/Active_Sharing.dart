// // // import 'package:flutter/cupertino.dart';
// // // import 'package:http/http.dart' as http;
// // // import 'package:links_social_media/ligin/network/endpoints.dart';
// // //
// // // import '../../../../model/activemodel.dart';
// // //
// // // class ActiveApi extends ChangeNotifier {
// // //   List<NearestUser> nearestUser = [];
// // //
// // //   Future<bool> getactive() async {
// // //     final response = await http.get(Uri.parse(Endpoints.follow));
// // //     if (response.statusCode == 200) {
// // //       final result = activemodelFromJson(response.body);
// // //       nearestUser = result.nearestUsers;
// // //       notifyListeners();
// // //       return true;
// // //     } else {
// // //       return false;
// // //     }
// // //   }
// // // }
// // import 'dart:convert';
// //
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:links_social_media/ligin/network/endpoints.dart';
// //
// // import '../../../../model/activemodel.dart';
// // import '../../save_token.dart';
// // import '../login/login.dart';
// //
// // class NetworkService extends ChangeNotifier {
// //   final String baseUrl = "http://betweener.kicklance.com/api";
// //
// //   Future<bool> setActiveSharing(String type) async {
// //     final token = await SharedPreferencesHelper.getToken();
// //
// //     final userId = await getUserId();
// //     print("##############${userId}");
// //     final url = Uri.parse("${Endpoints.activ}$userId");
// //     final response = await http.post(
// //       url,
// //       headers: {'Authorization': 'Bearer $token'},
// //       body: {'type': type},
// //     );
// //     print("#######${response.statusCode}");
// //     print("#######${response.body}");
// //
// //     return response.statusCode == 200;
// //   }
// //
// //   // final token = await SharedPreferencesHelper.getToken();
// //   //
// //   // final userId = await getUserId();
// //   // var headers = {'Authorization': 'Bearer $token'};
// //   // var request = http.Request(
// //   //   'GET',
// //   //   Uri.parse("${Endpoints.activnearest}$userId"),
// //   // );
// //   //
// //   // request.headers.addAll(headers);
// //   //
// //   // http.StreamedResponse response = await request.send();
// //   // print(response.statusCode);
// //   // if (response.statusCode == 200) {
// //   //   print(await response.stream.bytesToString());
// //   // } else {
// //   //   print(response.reasonPhrase);
// //   // }
// //   List<NearestUser> nearestUser = [];
// //
// //   Future<ActiveModel?> fetchActiveSharing(BuildContext context) async {
// //     try {
// //       final token = await SharedPreferencesHelper.getToken();
// //       if (token == null) {
// //         _showMessage(context, 'Token not found. Please login again.');
// //       }
// //
// //       final response = await http.get(
// //         Uri.parse(Endpoints.links),
// //         headers: _buildHeaders(token!),
// //       );
// //
// //       if (response.statusCode == 200) {
// //         _handleSuccessResponse(response.body);
// //       } else {
// //         _showMessage(context, 'Error: ${response.statusCode}');
// //       }
// //     } catch (e) {
// //       _showMessage(context, 'Exception: $e');
// //     }
// //   }
// //
// //   void _handleSuccessResponse(String responseBody) async {
// //     final Map<String, dynamic>? map = jsonDecode(responseBody);
// //     if (map != null && map.containsKey('active')) {
// //       final List list = map['active'];
// //
// //       nearestUser =
// //           list
// //               .map(
// //                 (item) => NearestUser(
// //                   id: item['id'],
// //                   userId: item['userId'],
// //                   user: item['user'],
// //                   type: item['type'],
// //                   distance: item['distance'],
// //                 ),
// //               )
// //               .toList();
// //
// //       notifyListeners();
// //     }
// //   }
// //
// //   Map<String, String> _buildHeaders(String token) {
// //     return {
// //       'Authorization': 'Bearer $token',
// //       'Content-Type': 'application/json',
// //     };
// //   }
// //
// //   void _showMessage(BuildContext context, String message) {
// //     ScaffoldMessenger.of(
// //       context,
// //     ).showSnackBar(SnackBar(content: Text(message)));
// //   }
// // }
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:links_social_media/ligin/network/endpoints.dart';
// import 'package:provider/provider.dart';
//
// import '../login/login.dart';
//
//
// class ActiveSharingService {
//   final String baseUrl;
//
//   ActiveSharingService(this.baseUrl);
//
//   Future<void> setActiveSharing( String type) async {
//     // final token = await SharedPreferencesHelper.getToken();
//
//     final userId = await getUserId();
//     final response = await http.post(
//       Uri.parse('${Endpoints.activ}$userId'),
//       headers: {'Content-Type': 'application/x-www-form-urlencoded'},
//       body: {'type': type},
//     );
//
//     if (response.statusCode != 200) {
//       throw Exception('Failed to set active sharing');
//     }
//   }
//
//   Future<void> removeActiveSharing( ) async {
//     //final token = await SharedPreferencesHelper.getToken();
//
//   final userId = await getUserId();
//     final response = await http.delete(
//       Uri.parse('${Endpoints.activ}$userId'),
//     );
//
//     if (response.statusCode != 200) {
//       throw Exception('Failed to remove active sharing');
//     }
//   }
//
//   Future<ActiveSharing> fetchNearestSender( ) async {
//     //final token = await SharedPreferencesHelper.getToken();
//
//   final userId = await getUserId();
//     final response = await http.get(
//       Uri.parse('${Endpoints.activnearest}$userId'),
//     );
//
//     if (response.statusCode == 200) {
//       return ActiveSharing.fromJson(json.decode(response.body));
//     } else {
//       throw Exception('Failed to fetch nearest sender');
//     }
//   }
// }
//
// class ActiveSharing {
// }
// // import 'active_sharing_service.dart';
//
// class ActiveSharingProvider with ChangeNotifier {
//   final ActiveSharingService _service = ActiveSharingService(
//     'http://betweener.kicklance.com/api',
//   );
//   List<ActiveSharing> _activeSharings = [];
//
//   List<ActiveSharing> get activeSharings => _activeSharings;
//
//   Future<void> setActiveSharing(int userId, String type) async {
//     await _service.setActiveSharing(userId, type);
//     // قم بتحديث الحالة بعد نجاح الطلب
//     notifyListeners();
//   }
//
//   Future<void> removeActiveSharing( ) async {
//     await _service.removeActiveSharing( );
//     // قم بتحديث الحالة بعد نجاح الطلب
//     notifyListeners();
//   }
//
//   Future<void> fetchNearestSender(int userId) async {
//     final sender = await _service.fetchNearestSender( );
//     _activeSharings.add(sender);
//     notifyListeners();
//   }
// }
// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'active_sharing_provider.dart';
//
// class SetActiveSharingButton extends StatelessWidget {
//   final int userId;
//   final String type;
//
//   SetActiveSharingButton({required this.userId, required this.type});
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () async {
//         await Provider.of<ActiveSharingProvider>(
//           context,
//           listen: false,
//         ).setActiveSharing(userId, type);
//       },
//       child: Text('Set Active Sharing as $type'),
//     );
//   }
// }
