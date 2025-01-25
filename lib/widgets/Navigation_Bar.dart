import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:links_social_media/ligin/network/Request/location/location.dart';
import 'package:links_social_media/screens/Profile_screen.dart';
import 'package:links_social_media/screens/active_sharing_screen.dart';
import 'package:links_social_media/screens/homescrren.dart';
import 'package:provider/provider.dart';

import '../ligin/network/Request/login/login.dart';
import '../main.dart';

class NavigationBarWidget extends StatefulWidget {
  const NavigationBarWidget({super.key});

  @override
  State<NavigationBarWidget> createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    final getlocation = Provider.of<EditLocatino>(context, listen: false);
    final getuser = Provider.of<UserProvider>(context, listen: false);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF2F2B4A),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              child: const Image(
                image: AssetImage(
                  "assets/images/material-symbols_emergency-share-outline-rounded@2x.png",
                ),
                height: 35,
              ),
              onTap: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => MainScreen()));
              },
            ),
            InkWell(
              child: const Image(
                image: AssetImage("assets/images/Home (1).png"),
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => HomeScreen()),
                );
              },
            ),
            InkWell(
              child: const Image(
                image: AssetImage("assets/images/Customer.png"),
                height: 70,
              ),
              onTap: () async {
                determinePosition();
                Position position = await Geolocator.getCurrentPosition(
                  desiredAccuracy: LocationAccuracy.high,
                );
                final userId = await getUserId();
                double latitude = position.latitude;
                double longitude = position.longitude;

                getlocation.editlocation(
                  id: userId!,
                  context,
                  lat: latitude,
                  long: longitude,
                );

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) {
                      return ProfileScreen();
                    },
                  ),
                );
              },
              //
            ),
          ],
        ),
      ),
    );
  }
}
