import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:links_social_media/model/mymodel.dart';
import 'package:links_social_media/screens/New_Link_screen.dart';
import 'package:links_social_media/screens/search_Screen.dart';
import 'package:links_social_media/widgets/Condition_check.dart';
import 'package:links_social_media/widgets/Navigation_Bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../ligin/network/Request/Link/get_link.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _authService = AuthService();
  //late SharedPreferences pref;
  User? user;

  @override
  void initState() {
    super.initState();
    initPreferences();
  }

  @override
  Widget build(BuildContext context) {
    final getLinks = Provider.of<GetLinks>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          // InkWell(
          //   onTap: () {
          //     Navigator.of(context).pushReplacement(
          //       MaterialPageRoute(
          //         builder: (_) {
          //           return SearchScreen();
          //         },
          //       ),
          //     );
          //   },
          //   child:
          Padding(
            padding: const EdgeInsets.all(15),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) {
                      return SearchScreen();
                    },
                  ),
                );
                //    showSearch(context: context, delegate: SearchPage());
              },
              icon: Icon(Icons.search),
            ),
          ),
          // ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Center(
            child:
                user != null
                    ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello, ${user!.name} ",
                          style: TextStyle(fontSize: 30),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Image(
                            image: AssetImage("assets/images/QR Code.png"),
                          ),
                        ),
                        SizedBox(
                          height: 200,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: getLinks.linkMymodel.length + 1,
                            itemBuilder: (context, index) {
                              if (index == getLinks.linkMymodel.length) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                    horizontal: 10.0,
                                  ),
                                  child: Container(
                                    width: 180,
                                    decoration: BoxDecoration(
                                      color: Color(0xffE7E5F1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) {
                                              return NewLinkScreen();
                                            },
                                          ),
                                        );
                                      },
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.add,
                                              size: 40,
                                              color: Color(0xff2D2B4E),
                                            ),
                                            Text(
                                              "Add More",
                                              style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xff2D2B4E),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }

                              // تصميم باقي عناصر القائمة
                              final Uri url = Uri.parse(
                                "${getLinks.linkMymodel[index].link}",
                              );

                              Future<void> _launchUrl() async {
                                if (!await launchUrl(url)) {
                                  throw Exception('Could not launch $url');
                                }
                              }

                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: 10.0,
                                ),
                                child: Container(
                                  width: 180,
                                  decoration: BoxDecoration(
                                    color: Color(0xffFFE6A6),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: ListTile(
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                    title: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${getLinks.linkMymodel[index].title}',
                                            style: TextStyle(
                                              fontSize: 35,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          Text(
                                            "${getLinks.linkMymodel[index].username}",
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.blueGrey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      _launchUrl();
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )
                    : CircularProgressIndicator(),
          ),
        ),
      ),
      bottomNavigationBar: NavigationBarWidget(),
    );
  }

  //NavigationBarWidget
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
