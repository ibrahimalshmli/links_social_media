// import 'package:flutter/material.dart';
//
// import '../ligin/network/Request/followers/getfollowers.dart';
// import '../model/follower.dart';
//
// class FollowersScreen extends StatefulWidget {
//   @override
//   _FollowersScreenState createState() => _FollowersScreenState();
// }
//
// class _FollowersScreenState extends State<FollowersScreen> {
//   final FollowApi _followApi = FollowApi();
//   List<Folloewmodel> followers = [];
//   bool isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchFollowers();
//   }
//
//   void fetchFollowers() async {
//     try {
//       final fetchedFollowers = await _followApi.getFollowers();
//       setState(() {
//         followers = fetchedFollowers!.cast<Folloewmodel>();
//         isLoading = false;
//       });
//     } catch (e) {
//       print("Error fetching followers: $e");
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Followers")),
//       body:
//           isLoading
//               ? Center(child: CircularProgressIndicator())
//               : ListView.builder(
//                 itemCount: followers.length,
//                 itemBuilder: (context, index) {
//                   final user = followers[index].followee?.user;
//                   return ListTile(
//                     title: Text(user?.name ?? "Unknown"),
//                     subtitle: Text(user?.email ?? ""),
//                   );
//                 },
//               ),
//     );
//   }
// }
