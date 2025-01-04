import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:links_social_media/model/mymodel.dart';
import 'package:links_social_media/widgets/Condition_check.dart';
import 'package:links_social_media/widgets/Navigation_Bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Image(
            image: AssetImage("assets/images/Frame 2.png"),
            color: Colors.black,
          ),
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
                      ],
                    )
                    : CircularProgressIndicator(),
          ),
        ),
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
