import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:links_social_media/ligin/network/endpoints.dart';

import '../../../../model/follower.dart';
import '../../save_token.dart';

class FollowApi extends ChangeNotifier {
  List<Following> following = [];

  Future<void> getfollow(BuildContext context) async {
    try {
      final token = await SharedPreferencesHelper.getToken();
      if (token == null) {
        _showMessage(context, 'Token not found. Please login again.');
        return;
      }
      print(token);

      final response = await http.get(
        Uri.parse(Endpoints.follow),
        headers: _buildHeaders(token),
      );

      if (response.statusCode == 200) {
        _handleSuccessResponse(response.body);
        print(response.body);
        print(response);
      } else {
        _showMessage(context, 'Error: ${response.statusCode}');
      }
    } catch (e) {
      _showMessage(context, 'Exception: $e');
    }
  }

  void _handleSuccessResponse(String responseBody) {
    try {
      final Map<String, dynamic> map = jsonDecode(responseBody);
      if (map.containsKey('following') && map['following'] is List) {
        following = List<Following>.from(
          map["following"].map((x) => Following.fromJson(x)),
        );
      } else {
        following = [];
        print("No 'links' field found or it's not a list.");
      }
      notifyListeners();
    } catch (e) {
      print("Error parsing response: $e");
      following = [];
    }
  }

  // void _handleSuccessResponse(String responseBody) async {
  //   final Map<String, dynamic>? map = jsonDecode(responseBody);
  //   if (map != null && map.containsKey('following')) {
  //     final List list = map['following'];
  //
  //     following =
  //         list
  //             .map(
  //               (item) => Following(
  //                 id: item['id'],
  //                 name: item['name'],
  //                 email: item['email'],
  //                 emailVerifiedAt: item['emailVerifiedAt'],
  //                 createdAt: item['createdAt'],
  //                 updatedAt: item['updatedAt'],
  //                 isActive: item['isActive'],
  //                 country: item['country'],
  //                 ip: item['ip'],
  //                 long: item['long'],
  //                 lat: item['lat'],
  //               ),
  //             )
  //             .toList();
  //
  //     notifyListeners();
  //   }
  // }

  Map<String, String> _buildHeaders(String token) {
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}

// Future<bool> getfollow() async {
//   final response = await http.get(Uri.parse(Endpoints.follow));
//   if (response.statusCode == 200) {
//     final result = followmodelFromJson(response.body);
//     following = result.following;
//     notifyListeners();
//     return true;
//   } else {
//     return false;
//   }
// }
//   Future<List<Followee>?> getFollowers() async {
//     final token = await SharedPreferencesHelper.getToken();
//
//     final url = Uri.parse(Endpoints.follow);
//     final response = await http.get(
//       url,
//       headers: {
//         'Authorization': 'Bearer $token',
//         'Content-Type': 'application/json',
//       },
//     );
//     if (response.statusCode == 200) {
//       final jsonResponse = json.decode(response.body);
//
//       if (jsonResponse is Map && jsonResponse['data'] is List) {
//         final data = jsonResponse['data'];
//         return data
//             .map<Folloewmodel>((json) => Folloewmodel.fromJson(json))
//             .toList();
//       } else {
//         throw Exception('Failed to load followers');
//       }
//     }
//   }
//   //
//   // List<Followee> folloewmodel = [];
//   // bool isLoading = false;
//   //
//   // Future<void> getFollowing(BuildContext context) async {
//   //   isLoading = true;
//   //   notifyListeners();
//   //
//   //   final token = await SharedPreferencesHelper.getToken();
//   //   final url = Uri.parse(Endpoints.follow);
//   //
//   //   try {
//   //     final response = await http.get(
//   //       url,
//   //       headers: {
//   //         'Authorization': 'Bearer $token',
//   //         'Content-Type': 'application/json',
//   //       },
//   //     );
//   //
//   //     if (response.statusCode == 200) {
//   //       _handleSuccessResponse(response.body);
//   //     } else if (response.statusCode == 401) {
//   //       print('Unauthorized: Invalid token');
//   //     } else if (response.statusCode == 500) {
//   //       print('Server error: Please try again later');
//   //     } else {
//   //       print('Error: ${response.statusCode}');
//   //     }
//   //   } catch (e) {
//   //     print('Exception: $e');
//   //   } finally {
//   //     isLoading = false;
//   //     notifyListeners();
//   //   }
//   // }
//   //
//   // void _handleSuccessResponse(String responseBody) {
//   //   try {
//   //     final Map<String, dynamic>? map = jsonDecode(responseBody);
//   //     if (map != null && map.containsKey('followee')) {
//   //       final List list = map['followee'];
//   //
//   //       folloewmodel =
//   //           list
//   //               .map(
//   //                 (item) => Followee(
//   //                   id: item["id"],
//   //                   userId: item["user_id"],
//   //                   followeeId: item["followee_id"],
//   //                   user: item["user"],
//   //                 ),
//   //               )
//   //               .toList();
//   //
//   //       notifyListeners();
//   //     } else {
//   //       print('Error: Key "follow" not found in response');
//   //     }
//   //   } catch (e) {
//   //     print('Error decoding JSON: $e');
//   //   }
//   // }
//
//   List<Folloewmodel> followingList = [];
//   bool isLoading = false;
//
//   Future<void> getFollowing(BuildContext context) async {
//     isLoading = true;
//     notifyListeners();
//
//     final token = await SharedPreferencesHelper.getToken();
//     final url = Uri.parse(Endpoints.follow);
//
//     try {
//       print('Sending request to: $url');
//       final response = await http.get(
//         url,
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//       );
//
//       print('Response Code: ${response.statusCode}');
//       print('Response Body: ${response.body}');
//
//       if (response.statusCode == 200) {
//         _handleSuccessResponse(response.body);
//       } else if (response.statusCode == 401) {
//         _showMessage(context, 'Unauthorized: Invalid token');
//       } else if (response.statusCode == 500) {
//         _showMessage(context, 'Server error: Please try again later');
//       } else {
//         _showMessage(context, 'Error: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Exception: $e');
//       _showMessage(context, 'An error occurred. Please try again.');
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   void _handleSuccessResponse(String responseBody) {
//     try {
//       final Map<String, dynamic> decodedJson = jsonDecode(responseBody);
//       if (decodedJson.containsKey('followee') &&
//           decodedJson['followee'] is List) {
//         final List<dynamic> list = decodedJson['followee'];
//         followingList =
//             list.map((item) => Folloewmodel.fromJson(item)).toList();
//         notifyListeners();
//       } else {
//         print('Error: Key "followee" not found or not a list in the response');
//       }
//     } catch (e) {
//       print('Error decoding JSON: $e');
//     }
//   }
//
//   void _showMessage(BuildContext context, String message) {
//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(SnackBar(content: Text(message)));
//   }
// }
