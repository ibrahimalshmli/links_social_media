import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:links_social_media/ligin/screen/Onboarding_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/homescrren.dart';

bool IsloggedIn = false;
const String username = "username";

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  String status = "";
  late StreamSubscription subscription;

  void checkConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.mobile) {
      setState(() {
        status = "Mobile Network";
      });
    } else if (result == ConnectivityResult.wifi) {
      setState(() {
        status = "Wifi Network";
      });
    } else {
      setState(() {
        status = "No Network";
      });
    }
  }

  @override
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    checkConnectivity();
    subscription = Connectivity().onConnectivityChanged.listen((result) {
      String connectionStatus;
      if (result == ConnectivityResult.mobile) {
        connectionStatus = "Mobile Network";
      } else if (result == ConnectivityResult.wifi) {
        connectionStatus = "Wifi Network";
      } else {
        connectionStatus = "No Network";
      }

      // عرض Snackbar لتغيير الاتصال
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Connectivity changed to $connectionStatus")),
        );
      });

      setState(() {
        status = connectionStatus;
      });
    });

    chack();
  }

  Future<void> chack() async {
    bool isloggedIn = await _authService.isloggedIn();
    if (isloggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
    }
  }

  @override
  void dispose() {
    subscription.cancel(); // إلغاء الاشتراك لتجنب تسريبات الذاكرة
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingScreen(); // عرض شاشة Onboarding
  }
}

class AuthService {
  Future<bool> isloggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("IsloggedIn") ?? false; // التحقق من تسجيل الدخول
  }

  Future<void> logins() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("IsloggedIn", true); // تسجيل الدخول
  }
}
