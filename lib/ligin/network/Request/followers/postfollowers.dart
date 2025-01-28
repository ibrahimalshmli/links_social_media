import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:links_social_media/network/endpoints.dart';

import '../../../../network/save_token.dart';

// class FollowersApi extends ChangeNotifier {
//   Future<void> postfollow(BuildContext context) async {
//     try {
//       final token = await SharedPreferencesHelper.getToken();
//       if (token == null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Token not found. Please login again.')),
//         );
//
//         return;
//       }
//       print(token);
//
//       var headers = {
//         'Content-Type': 'application/x-www-form-urlencoded',
//         'Authorization': 'Bearer $token',
//       };
//       var request = http.Request('POST', Uri.parse(Endpoints.follow));
//       request.bodyFields = {'followee_id': '58'};
//       request.headers.addAll(headers);
//
//       http.StreamedResponse response = await request.send();
//
//       if (response.statusCode == 200) {
//         print(await response.stream.bytesToString());
//       } else {
//         print(response.reasonPhrase);
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text('Exception: $e')));
//     }
//   }
// }

class FollowersApi extends ChangeNotifier {
  int followerCount = 0; // Counter for followers

  Future<void> postFollow(BuildContext context, String followeeId) async {
    try {
      // Get token from SharedPreferences
      final token = await SharedPreferencesHelper.getToken();
      if (token == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Token not found. Please login again.')),
        );
        return;
      }

      print('Token: $token');

      // Set headers
      var headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $token',
      };

      // Create request
      var request = http.Request('POST', Uri.parse(Endpoints.follow));
      request.bodyFields = {
        'followee_id': followeeId,
      }; // Pass followeeId dynamically
      request.headers.addAll(headers);
      print(headers);

      // Send request
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(response);
        print(await response.stream.bytesToString());
        followerCount += 1; // Increment the counter
        notifyListeners(); // Notify listeners of the change
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Follow request successful.')));
      } else {
        print('Error: ${response.reasonPhrase}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.reasonPhrase}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Exception: $e')));
      print(e);
    }
  }
}
