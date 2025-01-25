// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// //
// // import '../ligin/network/endpoints.dart';
// // import '../model/activemodel.dart';
// //
// // class SenderScreen extends StatefulWidget {
// //   @override
// //   State<SenderScreen> createState() => _SenderScreenState();
// // }
// //
// // class _SenderScreenState extends State<SenderScreen> {
// //   List<Activemodel> nearestUser = [];
// //
// //   Future<bool> getactive() async {
// //     final response = await http.post(Uri.parse(Endpoints.activ));
// //     if (response.statusCode == 200) {
// //       final result = activemodelFromJson(response.body);
// //       nearestUser = result.nearestUsers.cast<Activemodel>();
// //       setState(() {});
// //       return true;
// //     } else {
// //       return false;
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     // final activeSharingProvider = Provider.of<ActiveApi>(context);
// //
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Senders'),
// //         actions: [
// //           IconButton(
// //             icon: Icon(Icons.refresh),
// //             onPressed: () {
// //               getactive(); // استبدل '3' بـ userId
// //             },
// //           ),
// //         ],
// //       ),
// //       body:
// //       // activeSharingProvider.nearestUser.isEmpty
// //       //     ? Center(child: Text('No senders available.'))
// //       //     :
// //       Column(
// //         children: [
// //           Expanded(
// //             child: ListView.builder(
// //               itemCount: nearestUser.length,
// //               itemBuilder: (context, index) {
// //                 final sender = nearestUser[index];
// //                 return ListTile(
// //                   title: Text("${sender.nearestUsers[index].user.name}"),
// //                   subtitle: Text("${sender.nearestUsers[index].user.email}"),
// //                 );
// //               },
// //             ),
// //           ),
// //           MaterialButton(
// //             onPressed: () {
// //               print(nearestUser.length);
// //               setState(() {});
// //             },
// //             child: Text("data"),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../ligin/network/Request/active_sharing/Active_Sharing.dart';
//
// class SenderScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<NetworkService>(context);
//
//     return Scaffold(
//       appBar: AppBar(title: Text("الإرسال")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             ElevatedButton(
//               onPressed: () => provider.setActiveSharing("sender"),
//               child: Text("تفعيل الإرسال"),
//             ),
//             // ElevatedButton(
//             //   onPressed: provider.removeActiveSharing,
//             //   child: Text("إلغاء الإرسال"),
//             // ),
//             // ElevatedButton(
//             //   onPressed: provider.getNearestSender,
//             //
//             //   child: Text("عرض أقرب مستلم"),
//             // ),
//             SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ligin/network/user_providre.dart';

class SenderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ActiveSharingProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Sender Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final success = await provider.setActiveSharing('sender');
                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('You are now a sender!')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to set as sender!')),
                  );
                }
              },
              child: Text('Set as Sender'),
            ),
          ],
        ),
      ),
    );
  }
}
