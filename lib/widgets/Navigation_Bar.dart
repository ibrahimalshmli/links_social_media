import 'package:flutter/material.dart';
import 'package:links_social_media/screens/Profile_screen.dart';
import 'package:links_social_media/screens/homescrren.dart';

class NavigationBarWidget extends StatelessWidget {
  const NavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Color(0xFF2F2B4A),
        borderRadius: BorderRadius.circular(40),
      ),

      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: [
            InkWell(
              child: Image(
                image: AssetImage(
                  "assets/images/material-symbols_emergency-share-outline-rounded@2x.png",
                ),
                height: 35,
              ),

              onTap: () {},
            ),
            InkWell(
              child: Image(image: AssetImage("assets/images/Home (1).png")),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) {
                      return HomeScreen();
                    },
                  ),
                );
              },
            ),
            InkWell(
              child: Image(
                image: AssetImage("assets/images/Customer.png"),
                height: 70,
              ),

              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) {
                      return ProfileScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
