import 'package:flutter/material.dart';
import 'package:links_social_media/ligin/network/endpoints.dart';
import 'package:links_social_media/ligin/network/networkhelber.dart';
import 'package:links_social_media/model/mymodel.dart';
import 'package:links_social_media/screens/homescrren.dart';

class Colaction extends ChangeNotifier {
  LinkModel? linkModel;

  Future<void> login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      Map<String, dynamic>? response = await NetworkHelper.postData(
        Endpoints.login,
        body: {"email": email, "password": password},
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) {
            return HomeScreen();
          },
        ),
      );
    } catch (e, s) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  // كولكشن تسجيل حساب جديد
  Future<void> Register({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
    required String password_confirmation,
  }) async {
    try {
      Map<String, dynamic>? response = await NetworkHelper.postData(
        Endpoints.register,
        body: {
          "name": name, // Corrected to use .text
          "email": email,
          "password": password,
          "password_confirmation": password_confirmation,
        },
      );

      // Navigate to HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) {
            return HomeScreen();
          },
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
      print(e.toString());
    }
  }

  // كولكشن تسجيل رابط جديد
  Future<void> AddLink({
    required BuildContext context,
    required String title,
    required String link,
    required String username,
    // required dynamic isActive,
  }) async {
    try {
      Map<String, dynamic>? response = await NetworkHelper.postData(
        Endpoints.links,

        body: {
          "title": title,
          "link": link,
          "username": username,
          // "isActive": isActive,
        },
      );

      // Navigate to HomeScreen
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  //حذف معلومات الرابط
  // Future<void> DeleteLink({
  //   required BuildContext context,
  //   required String title,
  //   required String link,
  //   required String username,
  //   // required dynamic isActive,
  // }) async {
  //   try {
  //     Map<String, dynamic>? response = await NetworkHelper.deleteData(
  //       Endpoints.links,
  //
  //       body: {
  //         "title": title,
  //         "link": link,
  //         "username": username,
  //         // "isActive": isActive,
  //       },
  //     );
  //
  //     //Navigate to ProfileScreen
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //         builder: (_) {
  //           return ProfileScreen();
  //         },
  //       ),
  //     );
  //   } catch (e) {
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(SnackBar(content: Text(e.toString())));
  //   }
  // }

  // تعديل معلومات الرابط
  // Future<void> updateLink({
  //   required BuildContext context,
  //   required String title,
  //   required String link,
  //   required String username,
  //   // required dynamic isActive,
  // }) async {
  //   try {
  //     Map<String, dynamic>? response = await NetworkHelper.PutData(
  //       Endpoints.links,
  //
  //       body: {
  //         "title": title,
  //         "link": link,
  //         "username": username,
  //         // "isActive": isActive,
  //       },
  //     );
  //
  //     // Navigate to HomeScreen
  //     // Navigator.pushReplacement(
  //     //   context,
  //     //   MaterialPageRoute(
  //     //     builder: (_) {
  //     //       return HomeScreen();
  //     //     },
  //     //   ),
  //     // );
  //   } catch (e) {
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(SnackBar(content: Text(e.toString())));
  //   }
  // }

  //جلب معلومات الرابط
  //   Future<void> getLink({
  //     required BuildContext context,
  //     required String title,
  //     required String link,
  //     required String username,
  //     // required dynamic isActive,
  //   }) async {
  //     try {
  //       Map<String, dynamic>? response = await NetworkHelper.getData(
  //         Endpoints.links,
  // List<dynamic>body:{
  //           "title": title,
  //           "link": link,
  //           "username": username,
  //
  //           // "isActive": isActive,
  //         },
  //       );
  //
  //       // Navigate to HomeScreen
  //       // Navigator.pushReplacement(
  //       //   context,
  //       //   MaterialPageRoute(
  //       //     builder: (_) {
  //       //       return HomeScreen();
  //       //     },
  //       //   ),
  //       // );
  //     } catch (e) {
  //       ScaffoldMessenger.of(
  //         context,
  //       ).showSnackBar(SnackBar(content: Text(e.toString())));
  //     }
  //   }
}
