import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart';
import 'package:links_social_media/ligin/network/endpoints.dart';
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
  List<LinkMymodel> linkMymodel = [];

  User? user;

  Future<void> getLink(String url) async {
    try {
      Response response = await get(
        Uri.parse(Endpoints.links),
        headers: {
          "Authorization": "Bearer ${Endpoints.token}",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic>? map = jsonDecode(response.body);
        if (map != null) {
          List list = map["links"];
          for (int i = 0; i < list.length; i++) {
            linkMymodel.add(
              LinkMymodel(
                title: list[i]["title"],
                link: list[i]["link"],
                username: list[i]["username"],
                isActive: list[i]["isActive"],
              ),
            );
          }

          setState(() {});
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Exception: $e')));
    }
  }

  @override
  @override
  void initState() {
    initPreferences();

    getLink(Endpoints.links);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      // automaticallyImplyLeading: false),
      body:
          linkMymodel == null
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundImage: AssetImage(
                                  "assets/images/Mask group.png",
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                    SizedBox(height: 30),
                                    Container(
                                      child: Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Color(0xffFFD465),
                                            ),
                                            child: InkWell(
                                              onTap: () {},
                                              child: Text(
                                                "followers",
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            height: 20,
                                            width: 80,
                                          ),
                                          SizedBox(width: 10),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Color(0xffFFD465),
                                            ),
                                            child: InkWell(
                                              onTap: () {},
                                              child: Text(
                                                "following",
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            height: 20,
                                            width: 80,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Column(
                              //   children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.edit),
                                color: Colors.white,
                              ),
                            ],
                          ),
                          //   ],
                          // ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    Expanded(
                      child: ListView.builder(
                        itemCount: linkMymodel.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 10.0,
                            ), // مسافة بين العناصر
                            child: Slidable(
                              startActionPane: ActionPane(
                                motion: StretchMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {},
                                    backgroundColor: Color(0xffF56C61),
                                    borderRadius: BorderRadius.circular(20),
                                    icon: Icons.delete,
                                  ),
                                  SizedBox(width: 15),
                                  SlidableAction(
                                    onPressed: (context) {},
                                    backgroundColor: Color(0xffFFD465),
                                    borderRadius: BorderRadius.circular(20),
                                    icon: Icons.edit,
                                  ),
                                  SizedBox(width: 15),
                                ],
                              ),

                              child: Container(
                                decoration: BoxDecoration(
                                  color:
                                      index % 2 == 0
                                          ? Color(0xffFEE2E7)
                                          : Color(
                                            0xffE7E5F1,
                                          ), // تناوب تلقائي للألوان
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  title: Text(
                                    '${linkMymodel[index].title}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  subtitle: Text(
                                    "${linkMymodel[index].link}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      //     );
                      //   },
                      // ),
                    ),
                  ],
                ),
              ),

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
