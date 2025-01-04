import 'package:flutter/material.dart';
import 'package:links_social_media/ligin/screen/Login_Screen.dart';

import '../widget/button_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  child: Column(
                    children: [
                      Image(image: AssetImage("assets/images/1.png")),

                      Text(
                        "Just one Scan for everything",
                        style: TextStyle(color: Color(0xff1C1948)),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 80),

                ButtonWidget(
                  text: "Get Started",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },

                  color: Color(0xffFFD465),
                  Color: Color(0xff784E00),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
