// // import 'package:flutter/material.dart';
// //
// // class User extends ChangeNotifier {
// //   int? id;
// //   String name;
// //   String email;
// //
// //
// //   User({this.id, required this.name, required this.email});
// //
// //   factory User.fromJson(Map<String, dynamic> json) {
// //     return User(id: json['id'], name: json['name'], email: json['email']);
// //   }
// //
// //   Map<String, dynamic> toJson() {
// //     return {'id': id, 'name': name, 'email': email};
// //   }
// // }
// //
// // class Link extends ChangeNotifier {
// //   int? id;
// //   String title;
// //   String link;
// //   String username;
// //
// //   Link({
// //     this.id,
// //     required this.title,
// //     required this.link,
// //     required this.username,
// //   });
// //
// //   factory Link.fromJson(Map<String, dynamic> json) {
// //     return Link(
// //       id: json['id'],
// //       title: json['title'],
// //       link: json['link'],
// //       username: json['username'],
// //     );
// //   }
// //
// //   Map<String, dynamic> toJson() {
// //     return {'id': id, 'title': title, 'link': link, 'username': username};
// //   }
// // }//
// import 'package:flutter/material.dart';
//
// class User {
//   final String name;
//   final String email;
//   final String? password;
//   final String? passwordConfirmation;
//
//   User({
//     required this.name,
//     required this.email,
//     this.password,
//     this.passwordConfirmation,
//   });
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(name: json['name'], email: json['email']);
//   }
//
//   Map<String, dynamic> toJson() {
//     return {'name': name, 'email': email};
//   }
// }
//
// class LoginModel {
//   final String email;
//   final String password;
//
//   LoginModel({required this.email, required this.password});
//
//   Map<String, dynamic> toJson() {
//     return {"email": email, "password": password};
//   }
// }
//
// class UserLocationModel {
//   final String lat;
//   final String long;
//
//   UserLocationModel({required this.lat, required this.long});
//
//   Map<String, dynamic> toJson() {
//     return {"lat": lat, "long": long};
//   }
// }
//
// class ActiveSharingModel {
//   final String type; // sender أو receiver
//
//   ActiveSharingModel({required this.type});
//
//   Map<String, dynamic> toJson() {
//     return {"type": type};
//   }
// }
//
// class LinkModel {
//   final String title;
//   final String link;
//   final String username;
//   final bool isActive;
//
//   LinkModel({
//     required this.title,
//     required this.link,
//     required this.username,
//     required this.isActive,
//   });
//
//   Map<String, dynamic> toJson() {
//     return {
//       "title": title,
//       "link": link,
//       "username": username,
//       "isActive": isActive,
//     };
//   }
// }
//
// class AppProvider with ChangeNotifier {
//   // Auth State
//   User? registerModel;
//   LoginModel? loginModel;
//
//   void setRegisterModel(User model) {
//     registerModel = model;
//     notifyListeners();
//   }
//
//   void setLoginModel(LoginModel model) {
//     loginModel = model;
//     notifyListeners();
//   }
//
//   // User Location State
//   UserLocationModel? userLocationModel;
//
//   void setUserLocationModel(UserLocationModel model) {
//     userLocationModel = model;
//     notifyListeners();
//   }
//
//   // Active Sharing State
//   ActiveSharingModel? activeSharingModel;
//
//   void setActiveSharingModel(ActiveSharingModel model) {
//     activeSharingModel = model;
//     notifyListeners();
//   }
//
//   // Links State
//   LinkModel? linkModel;
//
//   void setLinkModel(LinkModel model) {
//     linkModel = model;
//     notifyListeners();
//   }
// }
class User {
  final int id;
  final String name;
  final String email;
  // final String createdAt;
  // final String updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    // required this.createdAt,
    // required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      // createdAt: json['created_at'],
      // updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      // 'created_at': createdAt,
      // 'updated_at': updatedAt,
    };
  }
}

/// Link Model
class LinkModel {
  final int id;
  final String title;
  final String link;
  final String username;
  final User? user;

  LinkModel({
    required this.id,
    required this.title,
    required this.link,
    required this.username,
    this.user,
  });

  factory LinkModel.fromJson(Map<String, dynamic> json) {
    return LinkModel(
      id: json['id'],
      title: json['title'],
      link: json['link'],
      username: json['username'],
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'link': link,
      'username': username,
      'user': user?.toJson(),
    };
  }
}
