// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// import '../ligin/network/endpoints.dart';
// import '../ligin/network/save_token.dart';
// import '../model/activemodel.dart';
//
// class ActiveSharingPage extends StatefulWidget {
//   @override
//   _ActiveSharingPageState createState() => _ActiveSharingPageState();
// }
//
// class _ActiveSharingPageState extends State<ActiveSharingPage> {
//   List<NearestUser> nearestUsers = [];
//
//   Future<void> fetchActiveSharing(BuildContext context) async {
//     try {
//       final token = await SharedPreferencesHelper.getToken();
//       if (token == null) {
//         _showMessage(context, 'Token not found. Please login again.');
//         return;
//       }
//
//       final response = await http.get(
//         Uri.parse(Endpoints.links), // Adjust the URL accordingly.
//         headers: _buildHeaders(token),
//       );
//       print(response.statusCode);
//       if (response.statusCode == 200) {
//         _handleSuccessResponse(response.body);
//       } else {
//         _showMessage(context, 'Error: ${response.statusCode}');
//       }
//     } catch (e) {
//       _showMessage(context, 'Exception: $e');
//     }
//   }
//
//   void _handleSuccessResponse(String responseBody) {
//     final Map<String, dynamic>? map = jsonDecode(responseBody);
//     print("#########${map}");
//     if (map != null && map.containsKey('active')) {
//       final List list = map['active'];
//
//       setState(() {
//         nearestUsers = list.map((item) => NearestUser.fromJson(item)).toList();
//       });
//     }
//     print("#########${nearestUsers}");
//   }
//
//   Map<String, String> _buildHeaders(String token) {
//     return {
//       'Authorization': 'Bearer $token',
//       'Content-Type': 'application/json',
//     };
//   }
//
//   void _showMessage(BuildContext context, String message) {
//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(SnackBar(content: Text(message)));
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     fetchActiveSharing(context); // Fetch data when the screen is loaded.
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Active Sharing')),
//       body:
//           nearestUsers.isEmpty
//               ? Center(child: CircularProgressIndicator())
//               : ListView.builder(
//                 itemCount: nearestUsers.length,
//                 itemBuilder: (context, index) {
//                   final user = nearestUsers[index].user;
//                   return Card(
//                     margin: EdgeInsets.all(8.0),
//                     child: ListTile(
//                       title: Text(user.name),
//                       subtitle: Text(user.email),
//                     ),
//                   );
//                 },
//               ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ligin/network/user_providre.dart';

class ReceiverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ActiveSharingProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Receiver Page')),
      body:
          provider.isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: provider.nearestUsers.length,
                itemBuilder: (context, index) {
                  final user = provider.nearestUsers[index];
                  return ListTile(
                    title: Text(user.user.name),
                    subtitle: Text(' ${user.user.email}'),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await provider.fetchNearestUsers();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
