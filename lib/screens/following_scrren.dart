// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../ligin/network/Request/followers/getfollowers.dart';
//
// class FollowingScreen extends StatefulWidget {
//   @override
//   _FollowingScreenState createState() => _FollowingScreenState();
// }
//
// class _FollowingScreenState extends State<FollowingScreen> {
//   // final FollowApi _followApi = FollowApi();
//   // List<Folloewmodel> following = [];
//   // bool isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final follow = Provider.of<FollowApi>(context);
//     return Scaffold(
//       body: Column(
//         children: [
//           follow.folloewmodel.isEmpty
//               ? const Center(child: CircularProgressIndicator())
//               : Expanded(
//                 // قم بتغليف القائمة بـ Expanded
//                 child: ListView.builder(
//                   itemCount: follow.folloewmodel.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title: Text('${follow.folloewmodel[index].userId}'),
//                       subtitle: Text(
//                         '${follow.folloewmodel[index].followeeId}',
//                       ),
//                     );
//                   },
//                 ),
//               ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ligin/network/Request/followers/getfollowers.dart';

class FollowingScreen extends StatefulWidget {
  @override
  _FollowingScreenState createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  @override
  @override
  void initState() {
    super.initState();

    // استدعاء الدالة بعد بناء الـ Widget Tree
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FollowApi>(context, listen: false).getfollow(context);
    });
  }

  Widget build(BuildContext context) {
    final follow = Provider.of<FollowApi>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Following")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: follow.following.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("${follow.following[index].name}"),

                  subtitle: Text("${follow.following[index].email}"),
                );
              },
            ),
          ),
          MaterialButton(
            onPressed: () {
              print(follow.following);
              setState(() {});
            },
            child: Text("data"),
          ),
        ],
      ),
    );
  }
}
