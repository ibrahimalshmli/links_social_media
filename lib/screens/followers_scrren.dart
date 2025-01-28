import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:links_social_media/model/follower.dart';
//
// class FollowersScreen extends StatefulWidget {
//   @override
//   _FollowersScreenState createState() => _FollowersScreenState();
// }
//
// class _FollowersScreenState extends State<FollowersScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // جلب البيانات عند فتح الصفحة
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final followersApi = Provider.of<FollowersApi>(context, listen: false);
//       followersApi.postfollow(context);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final followersApi = Provider.of<FollowersApi>(context, listen: true);
//
//     return Scaffold(
//       appBar: AppBar(title: Text('Followers')),
//       //  body:
//       // followersApi.following.isEmpty
//       //     ? Center(child: Text('No followers found.'))
//       //     : ListView.builder(
//       //       itemCount: followersApi.following.length,
//       //       itemBuilder: (context, index) {
//       //         final follower = followersApi.following[index];
//       //         return ListTile(
//       //           leading: CircleAvatar(
//       //             // يمكنك إضافة صورة المتابع إذا كانت متوفرة
//       //             child: Text(follower.name[0]), // الحرف الأول من الاسم
//       //           ),
//       //           title: Text(follower.name),
//       //           subtitle: Text(follower.email),
//       //           trailing: IconButton(
//       //             icon: Icon(Icons.remove_circle_outline),
//       //             onPressed: () {
//       //               // إزالة المتابع (يمكنك إضافة هذه الوظيفة لاحقًا)
//       //             },
//       //           ),
//       //         );
//       //       },
//       //     ),
//     );
//   }
// }

class FollowersPage extends StatefulWidget {
  @override
  _FollowersPageState createState() => _FollowersPageState();
}

class _FollowersPageState extends State<FollowersPage> {
  final String baseUrl = "http://betweener.kicklance.com/api";
  final String accessToken = "242|4d1O1EcfEe03JArDWcJA3TovVfhtMG4uRhioFALN";
  FollowModel? followModel;
  bool isLoading = false;

  Future<void> fetchFollowers() async {
    setState(() {
      isLoading = true;
    });
    try {
      var response = await http.get(
        Uri.parse('$baseUrl/follow'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        setState(() {
          followModel = FollowModel.fromJson(json.decode(response.body));
        });
      } else {
        showError(response.reasonPhrase ?? 'Error fetching followers');
      }
    } catch (e) {
      showError(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void initState() {
    super.initState();
    fetchFollowers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Followers')),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : followModel == null
              ? Center(child: Text('No followers available'))
              : ListView.builder(
                itemCount: followModel!.followers.length,
                itemBuilder: (context, index) {
                  var follower = followModel!.followers[index];
                  return ListTile(
                    title: Text(follower["name"] ?? 'Unknown'),
                    subtitle: Text('ID: ${follower["id"]}'),
                  );
                },
              ),
    );
  }
}
