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

class AuthRequest {
  String? email;
  String? password;
  String? name;
  String? passwordConfirmation;

  AuthRequest({
    this.email,
    this.password,
    this.name,
    this.passwordConfirmation,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'name': name,
    'password_confirmation': passwordConfirmation,
  };
}

class UserLocationUpdate {
  String lat;
  String long;

  UserLocationUpdate({required this.lat, required this.long});

  Map<String, dynamic> toJson() => {'lat': lat, 'long': long};
}

class ActiveSharing {
  String type;

  ActiveSharing({required this.type});

  Map<String, dynamic> toJson() => {'type': type};
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

class FollowRequest {
  String followeeId;

  FollowRequest({required this.followeeId});

  Map<String, dynamic> toJson() => {'followee_id': followeeId};
}

class SearchRequest {
  String name;

  SearchRequest({required this.name});

  Map<String, dynamic> toJson() => {'name': name};
}
