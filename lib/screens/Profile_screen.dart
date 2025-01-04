import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:links_social_media/model/mymodel.dart';
import 'package:links_social_media/widgets/Navigation_Bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'New_Link_screen.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // static LinkModel? linkModel;
  // User? user;
  // static Future<Map<String, dynamic>?> getLink(
  //   String url, {
  //   Map<String, String>? headers,
  // }) async {
  //   Response response = await get(
  //     Uri.parse(url),
  //     // headers: {"Authorization": Endpoints.token},
  //   );
  //   if (response.statusCode == 200) {
  //     Map<String, dynamic> map = jsonDecode(response.body);
  //     if (map != null) {
  //       linkModel = LinkModel(
  //         id: map["id"],
  //         title: map["title"],
  //         link: map["link"],
  //         username: map["username"],
  //       );
  //       setState(() {});
  //     }
  //   }
  //   // return null;
  // }
  // LinkModel? linkModel;
  User? user;
  //
  // Future<void> getLink(String url, {Map<String, String>? headers}) async {
  //   try {
  //     Response response = await get(
  //       Uri.parse(url),
  //       headers: {"Authorization": Endpoints.token},
  //     );
  //
  //     if (response.statusCode == 200) {
  //       Map<String, dynamic> map = jsonDecode(response.body);
  //       setState(() {
  //         linkModel = LinkModel(
  //           id: map["id"],
  //           title: map["title"],
  //           link: map["link"],
  //           username: map["username"],
  //         );
  //       });
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(SnackBar(content: Text(e.toString())));
  //   }
  // }

  @override
  @override
  void initState() {
    initPreferences();
    // getLink(Endpoints.links);
    super.initState();
  }

  // List<LinkModel> links = [
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      // automaticallyImplyLeading: false),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              Text(
                "Profile",
                style: TextStyle(fontSize: 40),
                textAlign: TextAlign.end,
              ),
              SizedBox(
                width: double.infinity,

                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xff2D2B4E),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: 150,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage(
                            "assets/images/Mask group.png",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${user?.name}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "${user?.email}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // Consumer<Item>(
      //   builder: (context, item, child) {
      //     return
      //       ListView.builder(
      //       itemCount: item.links.length,
      //       itemBuilder: (context, i) {
      //         return ListTile(
      //           title: Text(item.links[i].title),
      //           subtitle: Text(item.links[i].username),
      //           onTap: () {
      //             // Open the link
      //             print('Opening: ${item.links[i].link}');
      //           },
      //         );
      //       },
      //     );
      //   },
      // ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff2D2B4E),

        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) {
                return NewLinkScreen();
              },
            ),
          );
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: NavigationBarWidget(),
    );
  }

  void initPreferences() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? userData = pref.getString("userData");

    if (userData != null) {
      setState(() {
        user = User.fromJson(jsonDecode(userData));
      });
    }
  }
}

// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
// import 'package:links_social_media/ligin/network/endpoints.dart';
// import 'package:links_social_media/model/mymodel.dart';
// import 'package:links_social_media/widgets/Navigation_Bar.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'New_Link_screen.dart';
//
// class ProfileScreen extends StatefulWidget {
//   ProfileScreen({super.key});
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   LinkModel? linkModel;
//   User? user;
//
//   Future<void> getLink(String url, {Map<String, String>? headers}) async {
//     try {
//       Response response = await get(
//         Uri.parse(url),
//         headers: {"Authorization": Endpoints.token},
//       );
//
//       if (response.statusCode == 200) {
//         Map<String, dynamic> map = jsonDecode(response.body);
//         setState(() {
//           linkModel = LinkModel(
//             id: map["id"],
//             title: map["title"],
//             link: map["link"],
//             username: map["username"],
//           );
//         });
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text(e.toString())));
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     initPreferences();
//     getLink(Endpoints.links);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Profile')),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//           child: Column(
//             children: [
//               Text(
//                 "Profile",
//                 style: TextStyle(fontSize: 40),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(
//                 width: double.infinity,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Color(0xff2D2B4E),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   height: 150,
//                   child: Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: Row(
//                       children: [
//                         CircleAvatar(
//                           radius: 50,
//                           backgroundImage: AssetImage(
//                             "assets/images/Mask group.png",
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(10),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "${user?.name ?? 'Guest'}",
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 20,
//                                 ),
//                               ),
//                               Text(
//                                 "${user?.email ?? 'No email'}",
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 13,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               if (linkModel != null)
//                 Text(
//                   'Link: ${linkModel?.link ?? ''}',
//                   style: TextStyle(fontSize: 18),
//                 ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Color(0xff2D2B4E),
//         onPressed: () {
//           Navigator.of(
//             context,
//           ).push(MaterialPageRoute(builder: (_) => NewLinkScreen()));
//         },
//         child: Icon(Icons.add, color: Colors.white),
//       ),
//       bottomNavigationBar: NavigationBarWidget(),
//     );
//   }
//
//   void initPreferences() async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     String? userData = pref.getString("userData");
//
//     if (userData != null) {
//       setState(() {
//         user = User.fromJson(jsonDecode(userData));
//       });
//     }
//   }
// }
