import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:links_social_media/model/mymodel.dart';
import 'package:links_social_media/widgets/Navigation_Bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ligin/network/Request/Link/get_link.dart';
import '../ligin/network/Request/followers/postfollowers.dart';
import '../widgets/Link_Information.dart';
import 'New_Link_screen.dart';
import 'followers_scrren.dart';
import 'following_scrren.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user;

  @override
  void initState() {
    super.initState();
    initPreferences();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GetLinks>(context, listen: false).getLink(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final followersApi = Provider.of<FollowersApi>(context);
    final getLinks = Provider.of<GetLinks>(context, listen: false);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                              "${user?.name ?? 'Guest'}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              "${user?.email ?? 'example@example.com'}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                            SizedBox(height: 30),
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Color(0xffFFD465),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) {
                                            return FollowersPage();
                                          },
                                        ),
                                      );
                                      Text(
                                        'Followers: ${followersApi.followerCount}',
                                        style: TextStyle(fontSize: 16),
                                      );
                                    },
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
                                    borderRadius: BorderRadius.circular(5),
                                    color: Color(0xffFFD465),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) {
                                            return FollowingScreen();
                                          },
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Followers: ${followersApi.followerCount}',
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                  height: 20,
                                  width: 80,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.edit),
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            buildExpanded(getLinks, context),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff2D2B4E),
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => NewLinkScreen()));
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
