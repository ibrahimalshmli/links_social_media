import 'dart:convert';

Users usersFromJson(String str) => Users.fromJson(json.decode(str));

String usersToJson(Users data) => json.encode(data.toJson());

class Users {
  User user;
  String token;

  Users({required this.user, required this.token});

  factory Users.fromJson(Map<String, dynamic> json) =>
      Users(user: User.fromJson(json["user"]), token: json["token"]);

  Map<String, dynamic> toJson() => {"user": user.toJson(), "token": token};
}

class User {
  int id;
  String name;
  String email;
  double long;
  double lat;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.long,
    required this.lat,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    long: json["long"]?.toDouble(),
    lat: json["lat"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "long": long,
    "lat": lat,
  };
}

class LinkMymodel {
  int? id;
  String? title;
  String? link;
  String? username;
  int? isActive;
  int? userId;
  DateTime? createdAt;
  DateTime? updatedAt;

  LinkMymodel({
    this.id,
    this.title,
    this.link,
    this.username,
    this.isActive,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  factory LinkMymodel.fromJson(Map<String, dynamic> json) => LinkMymodel(
    id: json["id"],
    title: json["title"],
    link: json["link"],
    username: json["username"],
    isActive: json["isActive"],
    userId: json["user_id"],
    createdAt:
        json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt:
        json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "link": link,
    "username": username,
    "isActive": isActive,
    "user_id": userId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
