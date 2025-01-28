import 'dart:convert';

import 'mymodel.dart';

ActiveModel activeModelFromJson(String str) =>
    ActiveModel.fromJson(json.decode(str));

String activeModelToJson(ActiveModel data) => json.encode(data.toJson());

class ActiveModel {
  int count;
  List<NearestUser> nearestUsers;

  ActiveModel({required this.count, required this.nearestUsers});

  factory ActiveModel.fromJson(Map<String, dynamic> json) => ActiveModel(
    count: json["count"],
    nearestUsers: List<NearestUser>.from(
      json["nearest-users"].map((x) => NearestUser.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "nearest-users": List<dynamic>.from(nearestUsers.map((x) => x.toJson())),
  };
}

class NearestUser {
  int id;
  int userId;
  String type;
  User user;

  NearestUser({
    required this.id,
    required this.userId,
    required this.type,
    required this.user,
  });

  factory NearestUser.fromJson(Map<String, dynamic> json) => NearestUser(
    id: json["id"],
    userId: json["user_id"],
    type: json["type"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "type": type,

    "user": user.toJson(),
  };
}
