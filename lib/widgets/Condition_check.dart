import 'package:flutter/material.dart';
import 'package:links_social_media/ligin/screen/Login_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool IsloggedIn = false;
const String username = "username";

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  @override
  final AuthService _authService = AuthService();
  @override
  void initState() {
    //if (IsloggedIn)

    super.initState();

    chack();
  }

  Future<void> chack() async {
    bool isloggedIn = await _authService.isloggedIn();
    if (isloggedIn) {
      {
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (_) {
        //       return HomeScreen();
        //     },
        //   ),
        // );
      }
    }
  }

  Widget build(BuildContext context) {
    return LoginScreen();
  }
}

class AuthService {
  Future<bool> isloggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getBool("IsloggedIn") ?? false;
  }

  Future<void> login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("IsloggedIn", true);
  }
}
