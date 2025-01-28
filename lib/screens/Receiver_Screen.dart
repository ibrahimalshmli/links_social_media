// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// //
// // import '../ligin/network/Request/active_sharing/Active_Sharing.dart';
// //
// // class ReceiverPage extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     final provider = Provider.of<ActiveSharingProvider>(context);
// //
// //     return Scaffold(
// //       appBar: AppBar(title: Text('Receiver Page')),
// //       body:
// //           provider.isLoading
// //               ? Center(child: CircularProgressIndicator())
// //               : ListView.builder(
// //                 itemCount: provider.nearestUsers.length,
// //                 itemBuilder: (context, index) {
// //                   final user = provider.nearestUsers[index];
// //                   return ListTile(
// //                     title: Text(user.user.name),
// //                     subtitle: Text(' ${user.user.email}'),
// //                   );
// //                 },
// //               ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: () async {
// //           await provider.fetchNearestUsers();
// //         },
// //         child: Icon(Icons.refresh),
// //       ),
// //     );
// //   }
// // }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ligin/network/Request/active_sharing/Active_Sharing.dart';
import '../ligin/network/Request/followers/postfollowers.dart';

// class ReceiverPage extends StatefulWidget {
//   @override
//   _ReceiverPageState createState() => _ReceiverPageState();
// }
//
// class _ReceiverPageState extends State<ReceiverPage> {
//   ActiveSharingProvider? _activeSharingProvider;
//
//   @override
//   void initState() {
//     super.initState();
//     _activeSharingProvider = Provider.of<ActiveSharingProvider>(
//       context,
//       listen: false,
//     );
//     _activateSharing();
//   }
//
//   @override
//   void dispose() {
//     _deactivateSharing();
//     super.dispose();
//   }
//
//   Future<void> _activateSharing() async {
//     final success = await _activeSharingProvider?.setActiveSharing('receiver');
//     if (success == true) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text('You are now a receiver!')));
//     } else {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text('Failed to set as receiver!')));
//     }
//   }
//
//   Future<void> _deactivateSharing() async {
//     final success = await _activeSharingProvider?.removeActiveSharing();
//     if (success == true) {
//       print('Receiver deactivated successfully');
//     } else {
//       print('Failed to deactivate receiver');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<ActiveSharingProvider>(context);
//
//     return Scaffold(
//       appBar: AppBar(title: Text('Receiver Page')),
//       body:
//           provider.isLoading
//               ? Center(child: CircularProgressIndicator())
//               : ListView.builder(
//                 itemCount: provider.nearestUsers.length,
//                 itemBuilder: (context, index) {
//                   final user = provider.nearestUsers[index];
//                   return ListTile(
//                     title: Text(user.user.name),
//                     subtitle: Text(' ${user.user.email}'),
//                   );
//                 },
//               ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           await provider.fetchNearestUsers();
//         },
//         child: Icon(Icons.refresh),
//       ),
//     );
//   }
// }

class ReceiverPage extends StatefulWidget {
  @override
  _ReceiverPageState createState() => _ReceiverPageState();
}

class _ReceiverPageState extends State<ReceiverPage> {
  ActiveSharingProvider? _activeSharingProvider;

  @override
  void initState() {
    super.initState();
    _activeSharingProvider = Provider.of<ActiveSharingProvider>(
      context,
      listen: false,
    );
    _activateSharing();
  }

  @override
  void dispose() {
    _deactivateSharing();
    super.dispose();
  }

  Future<void> _activateSharing() async {
    final success = await _activeSharingProvider?.setActiveSharing('receiver');
    if (success == true) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('You are now a receiver!')));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to set as receiver!')));
    }
  }

  Future<void> _deactivateSharing() async {
    final success = await _activeSharingProvider?.removeActiveSharing();
    if (success == true) {
      print('Receiver deactivated successfully');
    } else {
      print('Failed to deactivate receiver');
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ActiveSharingProvider>(context);
    final followersApi = Provider.of<FollowersApi>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Receiver Page'),
            Text(
              'Followers: ${followersApi.followerCount}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
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
                    trailing: ElevatedButton(
                      onPressed: () async {
                        await followersApi.postFollow(
                          context,
                          user.user.id.toString(),
                        );
                      },
                      child: Text('Follow'),
                    ),
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
